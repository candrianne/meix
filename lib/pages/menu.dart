import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:mf_meix_le_tige/utils/date.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mf_meix_le_tige/model/Match.dart';
import 'package:mf_meix_le_tige/model/Team.dart';
import 'package:mf_meix_le_tige/model/TeamDataSource.dart';
import 'package:mf_meix_le_tige/widgets/Table.dart';

// .where((g) => DateTime.now().isBefore(DateFormat('y-MM-dd').parse(g.date)))

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
  bool isSwitched = false;

  @override
  void initState() {
    teams = widget.teams;
    games = widget.games;
    teamDataSource = TeamDataSource(teamData: teams);

    body = [
      RankingTable(teams: teamDataSource),
      getMatches(),
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

  Widget getMatches() {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    for (var game in games)
                      SizedBox(
                        height: constraints.maxHeight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: CachedNetworkImage(
                                imageUrl: game.homeTeamImage,
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    new Icon(Icons.error),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    parseDate(game.date),
                                    style: const TextStyle(
                                        fontFamily:
                                            "Work Sans, BlinkMacSystemFont, Segoe UI, Roboto, Helvetica Neue, Arial, sans-serif, Apple Color Emoji, Segoe UI Emoji, Segoe UI Symbol",
                                        fontSize: 16),
                                  ),
                                  Text(
                                    game.time.substring(0, 5),
                                    style: const TextStyle(
                                        fontFamily: "Changa", fontSize: 16),
                                  ),
                                  if (!isSwitched)
                                    Text(
                                      game.homeScore.toString() +
                                          "-" +
                                          game.awayScore.toString(),
                                      style: const TextStyle(
                                          fontFamily: "Changa",
                                          fontSize: 32,
                                          fontWeight: FontWeight.w400),
                                    )
                                ],
                              ),
                            ),
                            Expanded(
                              child: CachedNetworkImage(
                                imageUrl: game.awayTeamImage,
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    new Icon(Icons.error),
                              ),
                            )
                          ],
                        ),
                      )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Switch(
                    value: isSwitched,
                    onChanged: (newValue) {
                      setState(() {
                        isSwitched = newValue;
                        if (isSwitched) {
                          games = widget.games
                              .where((g) => DateTime.now().isBefore(
                                  DateFormat('y-MM-dd').parse(g.date)))
                              .toList();
                        } else {
                          games = widget.games
                              .where((g) => DateTime.now()
                                  .isAfter(DateFormat('y-MM-dd').parse(g.date)))
                              .toList();
                        }
                      });
                    },
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 20),
                    child: Text('${isSwitched ? "Next" : "Previous"} Matches'),
                  ),
                ],
              )
            ],
          );
        });
      },
    );
  }
}
