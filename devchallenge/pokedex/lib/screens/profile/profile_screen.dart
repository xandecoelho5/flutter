import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as svg;
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/screens/profile/profile_header.dart';
import 'package:pokedex/screens/profile/tabs/profile_about.dart';
import 'package:pokedex/screens/profile/tabs/profile_evolution.dart';
import 'package:pokedex/screens/profile/tabs/profile_stats.dart';
import 'package:pokedex/utils/constants.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key, required this.pokemon}) : super(key: key);

  final Pokemon pokemon;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late double _deviceWidth;
  late double _deviceHeight;

  _profileBars() {
    final tabs = ['About', 'Stats', 'Evolution'];

    // TODO find a way to make this SVG image linear gradient
    return TabBar(
      labelStyle: const TextStyle(
        color: kTextWhite,
        fontSize: 16,
        fontWeight: FontWeight.w700,
      ),
      indicator: const BoxDecoration(
        image: DecorationImage(
          image: svg.Svg(
            'assets/patterns/pokeball.svg',
            color: kTextWhite,
            size: Size(50, 50),
          ),
          // colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
          opacity: 0.15,
          fit: BoxFit.cover,
          alignment: FractionalOffset.topCenter,
        ),
      ),
      indicatorWeight: 15,
      padding: EdgeInsets.symmetric(horizontal: _deviceWidth * 0.05),
      unselectedLabelStyle: const TextStyle(color: kTextWhite, fontSize: 16),
      tabs: tabs.map((name) => Tab(text: name)).toList(),
    );
  }

  _profileBody() {
    _container(child) {
      return Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          color: kBackgroundColor,
        ),
        child: SingleChildScrollView(
          controller: ScrollController(),
          padding: EdgeInsets.only(
            left: _deviceWidth * 0.1,
            right: _deviceWidth * 0.1,
            top: _deviceHeight * 0.05,
            bottom: _deviceHeight * 0.02,
          ),
          child: child,
        ),
      );
    }

    return Expanded(
      child: TabBarView(
        children: [
          _container(ProfileAboutComponent(pokemon: widget.pokemon)),
          _container(ProfileStatsComponent(pokemon: widget.pokemon)),
          _container(ProfileEvolutionComponent(pokemon: widget.pokemon)),
        ],
      ),
    );
  }

  _appBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leadingWidth: 90,
      toolbarHeight: _deviceHeight * 0.1,
    );
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: _appBar(),
        backgroundColor: widget.pokemon.types.first.backgroundColor,
        body: Column(
          children: [
            ProfileHeaderComponent(pokemon: widget.pokemon),
            _profileBars(),
            _profileBody(),
          ],
        ),
        extendBodyBehindAppBar: true,
      ),
    );
  }
}
