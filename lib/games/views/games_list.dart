import 'package:flutter/material.dart';
import 'package:flutter_yalla_harek/games/models/game_model.dart';
import 'package:flutter_yalla_harek/games/views/game_list_item.dart';
import 'package:flutter_yalla_harek/home/view_models/home_search_filter.dart';
import 'package:flutter_yalla_harek/utils/const.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GamesList extends StatelessWidget {
  const GamesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var games = Provider.of<List<GameModel?>?>(context);
    var searchSort = Provider.of<HomeSearchSort?>(context);
    var sortedGames = searchSort?.searchAndSort(games);

    if (sortedGames == null) {
      return Center(
        child: CircularProgressIndicator(
          color: Theme.of(context).primaryColor,
        ),
      );
    }

    if (sortedGames.isEmpty) {
      return Center(child: Text('${AppLocalizations.of(context)?.no_games}'));
    }

    return ListView.builder(
        itemCount: sortedGames.length,
        padding: EdgeInsets.only(
          top: MAIN_PADDING,
          bottom: MAIN_PADDING + MediaQuery.of(context).viewPadding.bottom,
        ),
        itemBuilder: (_, int index) {
          GameModel game = sortedGames[index]!;

          return GameListItem(
            model: GameModel(
              id: game.id,
              title: game.title,
              maxPlayers: game.maxPlayers,
              dateTime: game.dateTime,
              image: game.image,
              description: game.description,
              address: game.address,
            ),
          );
        });
  }
}
