import 'package:flutter/material.dart';
import 'package:flutter_yalla_harek/games/models/game_model.dart';
import 'package:flutter_yalla_harek/games/views/game_details.dart';
import 'package:flutter_yalla_harek/utils/colors.dart';
import 'package:flutter_yalla_harek/utils/const.dart';

class GameListItem extends StatelessWidget {
  final GameModel model;
  const GameListItem({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (_) => GameDetails(model: model))),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: MAIN_PADDING),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(MAIN_RADIUS),
        ),
        child: Row(children: [
          Hero(
            tag: model.id,
            child: Container(
              height: 75,
              width: 75,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: Image.network(model.image).image,
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(MAIN_RADIUS),
              ),
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(MAIN_PADDING),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.title,
                  style: Theme.of(context).textTheme.headline2,
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(
                      Icons.today,
                      size: 18,
                      color: AppColors.COLOR_ARC_GRAY,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      model.dateTimeToString,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
                const Divider(color: Colors.lightBlue),
              ],
            ),
          )),
        ]),
      ),
    );
  }
}
