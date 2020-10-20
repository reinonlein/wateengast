import 'package:alcoholvrijheid/models/alcoholvrijerd.dart';
import 'package:alcoholvrijheid/backup/av_members_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AlcoholvrijerdsList extends StatefulWidget {
  @override
  _AlcoholvrijerdsListState createState() => _AlcoholvrijerdsListState();
}

/// een voorbeeld van de members ophalen via een stream

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