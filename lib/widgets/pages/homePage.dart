import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mf_meix_le_tige/widgets/pages/menu.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              return const MenuPage();
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

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url, headers: {
      "Authorization":
          "WP_Access eyJpdiI6Ikdoa0VQMkpMdkFQRUFpU0VkRXlTXC9BPT0iLCJ2YWx1ZSI6IktEMG9KRTMxRjMxMlJnKys2RSszV0FQbGxBU0pjZ2l4YnFlWGF4U00wQzRxbVFEcTJyTkVsaFwvcmxDZkVEYWZKIiwibWFjIjoiODg1YjgzMjY4ZmU2MDdhNGFlNmRmNGU4NWQxNTQwMDY2YmU2ZjU2MjY2YzRjZTA1MWRlNTU5NDIwZDQxYmNmMyJ9"
    });
    if (response.statusCode == 200) {
      await Future.delayed(const Duration(seconds: 5), () {});
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      String ranking = jsonResponse['elements'].toString();
      print(ranking);
      return Future.value(ranking);
    } else {
      return Future.value(
          'Request failed with status: ${response.statusCode}.');
    }
  }
}
