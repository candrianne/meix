import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'Team.dart';

class TeamDataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  TeamDataSource({required List<Team> teamData}) {
    _teamData = teamData
        .map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<String>(columnName: 'equipe', value: e.name),
      DataGridCell<int>(columnName: 'J', value: e.nbMatchsPlayed),
      DataGridCell<int>(
          columnName: 'V', value: e.wins),
      DataGridCell<int>(columnName: 'D', value: e.losses),
      DataGridCell<int>(columnName: 'N', value: e.draws),
      DataGridCell<int>(columnName: 'PTS', value: e.points),
    ]))
        .toList();
  }

  List<DataGridRow> _teamData = [];

  @override
  List<DataGridRow> get rows => _teamData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
          return Container(
            //alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: Text(e.value.toString()),
          );
        }).toList());
  }
}