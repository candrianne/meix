import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mf_meix_le_tige/model/Team.dart';
import 'package:mf_meix_le_tige/model/TeamDataSource.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class RankingTable extends StatelessWidget {
  final TeamDataSource teams;
  const RankingTable({Key? key, required this.teams}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfDataGrid(
      columnWidthMode: ColumnWidthMode.fill,
      columns: <GridColumn>[
        GridColumn(
          label: const Text(
            'Equipe',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
          columnName: 'equipe',
        ),
        GridColumn(
          label: const Text(
            'J',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
          columnName: 'J',
        ),
        GridColumn(
          label: Text(
            'V',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
          columnName: 'V',
        ),
        GridColumn(
          label: const Text(
            'D',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
          columnName: 'D',
        ),
        GridColumn(
          label: const Text(
            'N',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
          columnName: 'N',
        ),
        GridColumn(
          label: const Text(
            'PTS',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
          columnName: 'PTS',
        ),
      ],
      source: teams,
    );
  }
}
