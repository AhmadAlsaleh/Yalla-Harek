import 'package:flutter/material.dart';
import 'package:flutter_yalla_harek/home/view_models/home_search_filter.dart';
import 'package:flutter_yalla_harek/home/views/settings_dialog.dart';
import 'package:flutter_yalla_harek/utils/const.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeSearchSort? homeSearchSort = Provider.of(context);

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: Image.asset('assets/hero.jpeg').image,
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        color: Colors.black.withOpacity(0.5),
        padding: const EdgeInsets.all(MAIN_PADDING),
        alignment: Alignment.bottomCenter,
        child: SafeArea(
          child: Column(
            children: [
              Row(children: [
                const Expanded(
                  child: Text(
                    'Yalla Harek',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 22,
                    ),
                  ),
                ),
                PopupMenuButton(
                  tooltip: 'Sort',
                  onSelected: (int index) {
                    homeSearchSort?.sort = index;
                  },
                  itemBuilder: (_) => [
                    PopupMenuItem(
                      child: Text('${AppLocalizations.of(context)?.sort_date}'),
                      value: 0,
                    ),
                    PopupMenuItem(
                      child:
                          Text('${AppLocalizations.of(context)?.sort_title}'),
                      value: 1,
                    ),
                  ],
                  icon: const Icon(Icons.sort, color: Colors.white),
                ),
                IconButton(
                  onPressed: () => showDialog(
                      context: context, builder: (_) => const SettingsDialog()),
                  color: Colors.white,
                  icon: const Icon(Icons.settings),
                ),
              ]),
              const Divider(color: Colors.transparent),
              TextField(
                textInputAction: TextInputAction.search,
                onSubmitted: (value) {
                  homeSearchSort?.search = value;
                },
                decoration: InputDecoration(
                    filled: true,
                    hintText: '${AppLocalizations.of(context)?.search}',
                    fillColor: Colors.white.withOpacity(0.6),
                    border:
                        const OutlineInputBorder(borderSide: BorderSide.none)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
