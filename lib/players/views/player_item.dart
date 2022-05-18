import 'package:flutter/material.dart';
import 'package:flutter_yalla_harek/players/models/player_model.dart';
import 'package:flutter_yalla_harek/utils/const.dart';

class PlayerItem extends StatelessWidget {
  final PlayerModel model;
  const PlayerItem({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: MAIN_PADDING / 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            model.name,
            style: Theme.of(context).textTheme.headline2,
          ),
          Text(
            model.phone,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ],
      ),
    );
  }
}
