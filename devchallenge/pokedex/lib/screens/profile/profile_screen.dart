import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as svg;
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/screens/profile/profile_header.dart';
import 'package:pokedex/screens/profile/profile_tab.dart';
import 'package:pokedex/screens/profile/tabs/profile_about.dart';
import 'package:pokedex/screens/profile/tabs/profile_evolution.dart';
import 'package:pokedex/screens/profile/tabs/profile_stats.dart';
import 'package:pokedex/utils/constants.dart';

import '../../widgets/shader_mask_linear.dart';

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
        fontWeight: FontWeight.bold,
      ),
      indicator: const BoxDecoration(
        image: DecorationImage(
          image: svg.Svg(
            'assets/patterns/pokeball.svg',
            color: kTextWhite,
            size: Size(50, 50),
          ),
          opacity: 0.15,
          fit: BoxFit.cover,
          alignment: FractionalOffset.topCenter,
        ),
      ),
      indicatorWeight: 10,
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

    return SizedBox(
      height: _deviceHeight * 0.82,
      child: TabBarView(
        children: [
          _container(ProfileAboutComponent(pokemon: widget.pokemon)),
          _container(ProfileStatsComponent(pokemon: widget.pokemon)),
          _container(ProfileEvolutionComponent(pokemon: widget.pokemon)),
        ],
      ),
    );
  }

  _flexibleTitle(top) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 100),
      opacity: top > 71 && top < 91 ? 1.0 : 0.0,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SizedBox(width: _deviceWidth, height: 100),
          Positioned(
            right: -76,
            top: 20,
            child: ShaderMaskLinear(
              from: const Offset(0.0, 0.0),
              to: const Offset(0.0, 70.0),
              colors: kGradientVector,
              child: SvgPicture.asset(
                'assets/patterns/10x5.svg',
                width: 140,
                height: 65,
              ),
            ),
          ),
          Positioned(
            bottom: 5,
            child: Text(
              widget.pokemon.name,
              style: const TextStyle(
                color: kTextWhite,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: widget.pokemon.types.first.backgroundColor,
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          headerSliverBuilder: (context, bodyIsScrolled) {
            return [
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverSafeArea(
                  sliver: SliverAppBar(
                    pinned: true,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    leadingWidth: 90,
                    toolbarHeight: _deviceHeight * 0.105,
                    expandedHeight: 235.0,
                    snap: true,
                    floating: true,
                    flexibleSpace: LayoutBuilder(
                      builder: (context, constraints) {
                        final top = constraints.biggest.height;
                        return FlexibleSpaceBar(
                          title: _flexibleTitle(top),
                          // titlePadding: const EdgeInsets.only(bottom: 28),
                          centerTitle: true,
                          background:
                              ProfileHeaderComponent(pokemon: widget.pokemon),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ];
          },
          body: SafeArea(
            child: Builder(
              builder: (context) {
                return CustomScrollView(
                  slivers: [
                    SliverOverlapInjector(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                          context),
                    ),
                    SliverPersistentHeader(
                      delegate: ProfileTab(_profileBars()),
                      pinned: true,
                    ),
                    SliverToBoxAdapter(child: _profileBody()),
                  ],
                );
              },
            ),
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
    );
  }
}
