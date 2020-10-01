import 'package:alcoholvrijheid/models/alcoholvrijerd.dart';
import 'package:alcoholvrijheid/screens/home/alcoholvrijerds_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AlcoholvrijerdsList extends StatefulWidget {
  @override
  _AlcoholvrijerdsListState createState() => _AlcoholvrijerdsListState();
}

class _AlcoholvrijerdsListState extends State<AlcoholvrijerdsList> {
  @override
  Widget build(BuildContext context) {
    final alcoholvrijerds = Provider.of<List<Alcoholvrijerd>>(context) ?? [];

    return ListView.builder(
      itemCount: alcoholvrijerds.length,
      itemBuilder: (context, index) {
        return AlcoholvrijerdTile(alcoholvrijerd: alcoholvrijerds[index]);
      },
    );
  }
}
