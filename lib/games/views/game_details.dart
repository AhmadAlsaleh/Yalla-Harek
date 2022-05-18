import 'package:flutter/material.dart';
import 'package:flutter_yalla_harek/games/models/game_model.dart';
import 'package:flutter_yalla_harek/games/services/firestore_service.dart';
import 'package:flutter_yalla_harek/players/models/player_model.dart';
import 'package:flutter_yalla_harek/players/views/player_item.dart';
import 'package:flutter_yalla_harek/utils/colors.dart';
import 'package:flutter_yalla_harek/utils/const.dart';
import 'package:flutter_yalla_harek/utils/loading.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GameDetails extends StatelessWidget {
  final GameModel model;
  const GameDetails({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: [
        Stack(
          children: [
            Hero(
              tag: model.id,
              child: Container(
                height: height / 3,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: Image.network(model.image).image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Container(
              height: height / 3,
              padding: const EdgeInsets.symmetric(horizontal: MAIN_PADDING),
              alignment: Alignment.bottomCenter,
              child: SafeArea(
                bottom: false,
                minimum: const EdgeInsets.only(bottom: MAIN_PADDING),
                child: Row(children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back),
                    color: Colors.white,
                  ),
                  Expanded(
                    child: Text(
                      model.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Loading(
                          context: context,
                          action: () async {
                            var b = await FireStoreService().deleteGame(model);
                            Navigator.pop(context);
                            if (b) Navigator.pop(context);
                          }).showLoadingWithAction();
                    },
                    icon: const Icon(Icons.delete),
                    color: Colors.red,
                  ),
                ]),
              ),
            ),
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            child: SafeArea(
              top: false,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(MAIN_PADDING),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.today,
                                size: 30,
                                color: AppColors.COLOR_SECONDARY,
                              ),
                              const SizedBox(width: 5),
                              Expanded(
                                child: Text(
                                  model.dateTimeToString,
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Icon(
                                Icons.person,
                                size: 30,
                                color: AppColors.COLOR_SECONDARY,
                              ),
                              const SizedBox(width: 5),
                              Expanded(
                                child: Text(
                                  '${model.maxPlayers}',
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Icon(
                                Icons.pin_drop,
                                size: 30,
                                color: AppColors.COLOR_SECONDARY,
                              ),
                              const SizedBox(width: 5),
                              Expanded(
                                child: Text(
                                  model.address,
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.directions),
                                onPressed: () =>
                                    MapsLauncher.launchQuery(model.address),
                                color: AppColors.COLOR_ARC_GRAY,
                              ),
                            ],
                          ),
                          const Divider(height: 30),
                          Text(
                            model.description,
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          const Divider(height: 30),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  '${AppLocalizations.of(context)?.players}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      ?.copyWith(fontWeight: FontWeight.w800),
                                ),
                              ),
                              TextButton.icon(
                                icon: const Icon(Icons.person_add),
                                onPressed: () {
                                  // TODO
                                },
                                label: Text(
                                    '${AppLocalizations.of(context)?.add_player}'),
                              ),
                            ],
                          ),
                          PlayerItem(
                            model: PlayerModel(
                              name: 'Ahmad Alsaleh',
                              phone: '+951 784967',
                            ),
                          ),
                          PlayerItem(
                            model: PlayerModel(
                              name: 'Ahmad Alsaleh',
                              phone: '+951 784967',
                            ),
                          )
                        ],
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ]),
    );
  }
}
