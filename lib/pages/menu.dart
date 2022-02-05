import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mf_meix_le_tige/model/Team.dart';
import 'package:mf_meix_le_tige/model/TeamDataSource.dart';
import 'package:mf_meix_le_tige/widgets/Table.dart';

class MenuPage extends StatefulWidget {
  final List<Team> teams;

  const MenuPage({Key? key, required this.teams}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<MenuPage> {
  int _currentIndex = 0;
  late TeamDataSource teamDataSource;
  List<Team> teams = [];
  List<Widget> body = [];

  @override
  void initState() {
    teams = widget.teams;
    teamDataSource = TeamDataSource(teamData: teams);
    body =  [
      RankingTable(teams: teamDataSource),
      const Icon(Icons.sports_soccer),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child : body[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(
            label: "Ranking",
            icon: Icon(Icons.format_list_numbered)
          ),
          BottomNavigationBarItem(
              label: "Matchs",
              icon: Icon(Icons.sports_soccer)
          ),
        ],
      ),
    );
  }
}
