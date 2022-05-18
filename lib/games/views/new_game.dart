import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_yalla_harek/games/models/game_model.dart';
import 'package:flutter_yalla_harek/games/services/firestore_service.dart';
import 'package:flutter_yalla_harek/games/services/image_picker_service.dart';
import 'package:flutter_yalla_harek/utils/alerts.dart';
import 'package:flutter_yalla_harek/utils/colors.dart';
import 'package:flutter_yalla_harek/utils/const.dart';
import 'package:flutter_yalla_harek/utils/loading.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NewGame extends StatefulWidget {
  const NewGame({Key? key}) : super(key: key);

  @override
  State<NewGame> createState() => _NewGameState();
}

class _NewGameState extends State<NewGame> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _dateTimeController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  int _maxPlayers = 2;

  String? _imagePath;
  DateTime? _dateTime;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: [
        Container(
          height: height / 3,
          color: AppColors.COLOR_ICON_GRAY,
          child: InkWell(
            onTap: () async {
              var image = await ImagePickerService.getFromGallery();
              if (image != null) {
                setState(() {
                  _imagePath = image;
                });
              }
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                Text('${AppLocalizations.of(context)?.choose_image}'),
                Container(
                  height: height / 3,
                  decoration: BoxDecoration(
                    image: _imagePath != null
                        ? DecorationImage(
                            image: Image.file(File(_imagePath!)).image,
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: SafeArea(
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back),
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: SafeArea(
              top: false,
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(MAIN_PADDING),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: _titleController,
                        decoration: InputDecoration(
                            filled: true,
                            hintText: '${AppLocalizations.of(context)?.title}',
                            fillColor: AppColors.COLOR_ICON_GRAY,
                            border: const OutlineInputBorder(
                                borderSide: BorderSide.none)),
                      ),
                      const Divider(color: Colors.transparent),
                      InkWell(
                        onTap: () => showModalBottomSheet(
                            context: context,
                            builder: (_) => SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 3,
                                  child: CupertinoDatePicker(
                                    mode: CupertinoDatePickerMode.dateAndTime,
                                    onDateTimeChanged: (value) {
                                      setState(() {
                                        _dateTime = value;
                                        _dateTimeController.text = value
                                            .toLocal()
                                            .toString()
                                            .split('.')[0];
                                      });
                                    },
                                    initialDateTime: DateTime.now(),
                                  ),
                                )),
                        child: TextField(
                          controller: _dateTimeController,
                          enabled: false,
                          decoration: InputDecoration(
                            filled: true,
                            hintText:
                                '${AppLocalizations.of(context)?.date_time}',
                            fillColor: AppColors.COLOR_ICON_GRAY,
                            border: const OutlineInputBorder(
                                borderSide: BorderSide.none),
                            prefixIcon: const Icon(
                              Icons.today,
                              color: AppColors.primaryColors,
                            ),
                          ),
                        ),
                      ),
                      const Divider(color: Colors.transparent),
                      Row(
                        children: [
                          Text(
                            '${AppLocalizations.of(context)?.max_players}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                ?.copyWith(fontWeight: FontWeight.w800),
                          ),
                          const SizedBox(width: MAIN_PADDING),
                          ElevatedButton(
                              onPressed: () {
                                if (_maxPlayers <= 2) return;
                                setState(() {
                                  _maxPlayers--;
                                });
                              },
                              child: const Text('-')),
                          Expanded(
                            child: Text(
                              '$_maxPlayers',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _maxPlayers++;
                                });
                              },
                              child: const Text('+')),
                        ],
                      ),
                      const Divider(color: Colors.transparent),
                      TextField(
                        controller: _locationController,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          filled: true,
                          hintText: '${AppLocalizations.of(context)?.address}',
                          fillColor: AppColors.COLOR_ICON_GRAY,
                          border: const OutlineInputBorder(
                              borderSide: BorderSide.none),
                          prefixIcon: const Icon(Icons.pin_drop,
                              color: AppColors.primaryColors),
                        ),
                      ),
                      const Divider(color: Colors.transparent),
                      TextField(
                        controller: _descriptionController,
                        maxLines: 3,
                        decoration: const InputDecoration(
                            filled: true,
                            hintText: 'Description',
                            fillColor: AppColors.COLOR_ICON_GRAY,
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none)),
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(MAIN_PADDING),
                    child: FloatingActionButton.extended(
                        onPressed: () async {
                          Loading(
                              context: context,
                              action: () async {
                                var title = _titleController.text;
                                var dateTime = _dateTime;
                                var desc = _descriptionController.text;
                                var address = _locationController.text;

                                if (title.isEmpty == true) {
                                  CustomAlerts.showAlert(context,
                                      '${AppLocalizations.of(context)?.error_title}');
                                  return;
                                }

                                if (dateTime == null) {
                                  CustomAlerts.showAlert(context,
                                      '${AppLocalizations.of(context)?.error_date}');
                                  return;
                                }

                                if (address.isEmpty == true) {
                                  CustomAlerts.showAlert(context,
                                      '${AppLocalizations.of(context)?.error_address}');
                                  return;
                                }

                                if (_imagePath == null) {
                                  CustomAlerts.showAlert(context,
                                      '${AppLocalizations.of(context)?.error_image}');
                                  return;
                                }

                                var max = _maxPlayers;
                                var image = await ImagePickerService.uploadFile(
                                    File(_imagePath!));

                                await FireStoreService().newGame(GameModel(
                                  id: const Uuid().v4(),
                                  title: title,
                                  description: desc,
                                  image: image!,
                                  dateTime: dateTime,
                                  maxPlayers: max,
                                  address: address,
                                ));
                                Navigator.pop(context);
                                Navigator.pop(context);
                              }).showLoadingWithAction();
                        },
                        icon: const Icon(Icons.add),
                        label:
                            Text("${AppLocalizations.of(context)?.add_game}")))
              ]),
            ),
          ),
        ),
      ]),
    );
  }
}
