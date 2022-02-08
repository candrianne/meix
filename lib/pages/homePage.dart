import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mf_meix_le_tige/model/Match.dart';
import 'package:mf_meix_le_tige/model/Team.dart';
import 'package:mf_meix_le_tige/pages/menu.dart';
import 'dart:convert' as convert;
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  final String title;

  const HomePage({Key? key, required this.title}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _enabled = true;
  List<Team> teams = [];
  List<Game> games = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.grey),
      body: FutureBuilder(
        future: fetchData(), // function where you call your api
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          // AsyncSnapshot<Your object type>
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Shimmer.fromColors(
                baseColor: Colors.black,
                highlightColor: (Colors.yellow[300])!,
                enabled: _enabled,
                child: Image.asset('assets/images/logo_basic.png'),
              ),
            );
          } else {
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              return MenuPage(teams: teams, games: games);
            } // snapshot.data  :- get your object which is pass from your downloadData() function
          }
        },
      ),
    );
  }

  // methods
  Future<String> fetchData() async {
    var url = Uri.https('gestion.lffs.eu',
        '/lms_league_ws/public/api/v1/ranking/byMyLeague', {'serie_id': '498'});

    var url2 = Uri.https(
        'gestion.lffs.eu', '/lms_league_ws/public/api/v1/game/byMyLeague', {
      'with_referees': 'true',
      'no_forfeit': 'true',
      'season_id': '5',
      'sort[0]': 'date',
      'sort[1]': 'time',
      'club_id': '1606'
    });

    var responses = await Future.wait([
      http.get(url, headers: {
        "Authorization":
            "WP_Access eyJpdiI6Ikdoa0VQMkpMdkFQRUFpU0VkRXlTXC9BPT0iLCJ2YWx1ZSI6IktEMG9KRTMxRjMxMlJnKys2RSszV0FQbGxBU0pjZ2l4YnFlWGF4U00wQzRxbVFEcTJyTkVsaFwvcmxDZkVEYWZKIiwibWFjIjoiODg1YjgzMjY4ZmU2MDdhNGFlNmRmNGU4NWQxNTQwMDY2YmU2ZjU2MjY2YzRjZTA1MWRlNTU5NDIwZDQxYmNmMyJ9"
      }),
      http.get(url2, headers: {
        "Authorization":
            "WP_Access eyJpdiI6Ikdoa0VQMkpMdkFQRUFpU0VkRXlTXC9BPT0iLCJ2YWx1ZSI6IktEMG9KRTMxRjMxMlJnKys2RSszV0FQbGxBU0pjZ2l4YnFlWGF4U00wQzRxbVFEcTJyTkVsaFwvcmxDZkVEYWZKIiwibWFjIjoiODg1YjgzMjY4ZmU2MDdhNGFlNmRmNGU4NWQxNTQwMDY2YmU2ZjU2MjY2YzRjZTA1MWRlNTU5NDIwZDQxYmNmMyJ9"
      }),
    ]);

    if (responses[0].statusCode == 200 && responses[1].statusCode == 200) {
      // to look at the logo for 5 sec
      await Future.delayed(const Duration(seconds: 5), () {});

      // fetch ranking data
      var rankingJson = jsonDecode(responses[0].body)["elements"] as List;
      List<Team> teamsObjs =
          rankingJson.map((teamJson) => Team.fromJson(teamJson)).toList();

      // fetch matches data
      var matchJson = jsonDecode(responses[1].body)["elements"] as List;
      print(Game.fromJson(matchJson[0]).date);
      List<Game> gamesObjs = matchJson
          .map((mJson) => Game.fromJson(mJson))
          .where((g) => g.serieName == "P3B" && DateTime.now().isBefore(DateFormat('y-MM-dd').parse(g.date)))
          .toList();

      teams = teamsObjs;
      games = gamesObjs;

      return Future.value("");
    } else {
      return Future.value('Request failed with status');
    }
  }
}
