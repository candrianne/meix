import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mf_meix_le_tige/model/Match.dart';
import 'package:mf_meix_le_tige/model/Team.dart';
import 'package:mf_meix_le_tige/model/TeamDataSource.dart';
import 'package:mf_meix_le_tige/widgets/Table.dart';

class MenuPage extends StatefulWidget {
  final List<Team> teams;
  final List<Game> games;

  const MenuPage({Key? key, required this.teams, required this.games})
      : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<MenuPage> {
  int _currentIndex = 0;
  late TeamDataSource teamDataSource;
  List<Team> teams = [];
  List<Game> games = [];
  List<Widget> body = [];

  @override
  void initState() {
    teams = widget.teams;
    games = widget.games;
    teamDataSource = TeamDataSource(teamData: teams);

    body = [
      RankingTable(teams: teamDataSource),
      getMatches(games),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(
              label: "Ranking", icon: Icon(Icons.format_list_numbered)),
          BottomNavigationBarItem(
              label: "Matchs", icon: Icon(Icons.sports_soccer)),
        ],
      ),
    );
  }

  Widget getMatches(List<Game> games) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return ListView(
        children: [
          for (var game in games)
            SizedBox(
              height: constraints.maxHeight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(game.homeTeamImage, width: 150, height: 150),
                  Center(child: const Text(" - ")),
                  Image.network(game.awayTeamImage, width: 150, height: 150)
                ],
              ),
            )
        ],
      );
    });
  }
}
