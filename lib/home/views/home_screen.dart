import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_yalla_harek/games/services/firestore_service.dart';
import 'package:flutter_yalla_harek/games/views/games_list.dart';
import 'package:flutter_yalla_harek/games/views/new_game.dart';
import 'package:flutter_yalla_harek/home/views/home_header.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _controller = ScrollController();
  bool _isAddButtonExpanded = true;

  _scrollListener() {
    if (_controller.position.userScrollDirection == ScrollDirection.reverse) {
      if (_isAddButtonExpanded) {
        setState(() {
          _isAddButtonExpanded = false;
        });
      }
    } else if (_controller.position.userScrollDirection ==
        ScrollDirection.forward) {
      if (!_isAddButtonExpanded) {
        setState(() {
          _isAddButtonExpanded = true;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(_scrollListener);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.removeListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => const NewGame())),
        isExtended: _isAddButtonExpanded,
        icon: const Icon(Icons.add),
        label: Text('${AppLocalizations.of(context)?.new_game}'),
      ),
      body: Column(
        children: [
          const HomeHeader(),
          Expanded(
            child: StreamProvider(
              create: (BuildContext context) => FireStoreService().getGames(),
              initialData: null,
              child: GamesList(),
            ),
          ),
        ],
      ),
    );
  }
}
