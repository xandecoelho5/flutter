import 'package:b2w/main.dart';
import 'package:b2w/models/banner.dart';
import 'package:b2w/models/categoria.dart';
import 'package:b2w/models/produto.dart';
import 'package:b2w/services/banner_service.dart';
import 'package:b2w/services/categoria_service.dart';
import 'package:flutter/material.dart';

import '../services/produto_service.dart';
import '../utils/constants.dart';
import '../utils/utils.dart';
import '../widgets/produto_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late double _deviceWidth;
  int _currentPage = 0;

  Future<List<BannerModel>> findBanners() async {
    return await getIt.get<BannerService>().findAll();
  }

  Future<List<Categoria>> findCategorias() async {
    return await getIt.get<CategoriaService>().findAll();
  }

  Future<List<Produto>> findMaisVendidos() async {
    return await getIt.get<ProdutoService>().maisvendidos();
  }

  Widget _body() {
    bannersView() {
      bannerImage(BannerModel banner) {
        return Image.network(
          banner.urlImagem,
          fit: BoxFit.fill,
        );
      }

      bannerIndicator(banners) {
        return Row(
          children: [
            for (var i = 0; i < banners.length; i++)
              Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 2,
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentPage == i
                      ? Colors.white
                      : Colors.white.withOpacity(0.5),
                ),
              ),
          ],
        );
      }

      return FutureBuilder<List<BannerModel>>(
        future: findBanners(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final banners = snapshot.data!;
            return Material(
              elevation: 8,
              child: Stack(
                children: [
                  PageView.builder(
                    itemCount: banners.length,
                    itemBuilder: (context, index) => bannerImage(
                      banners[index],
                    ),
                    onPageChanged: (index) {
                      setState(() => _currentPage = index);
                    },
                  ),
                  Positioned(
                    bottom: 0,
                    left: _deviceWidth / 2 - 25,
                    child: bannerIndicator(banners),
                  ),
                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      );
    }

    categoriasView() {
      categoriaItem(Categoria categoria) {
        return InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(
              Routes.categoria,
              arguments: categoria,
            );
          },
          child: Column(
            children: [
              SizedBox(
                width: 60,
                height: 60,
                child: fetchImage(categoria.urlImagem),
              ),
              const SizedBox(height: 4),
              Text(categoria.descricao, style: kNomeCategoria),
            ],
          ),
        );
      }

      categoriasList(categorias) {
        return Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 6,
            ),
            scrollDirection: Axis.horizontal,
            itemCount: categorias.length,
            itemBuilder: (ctx, i) => categoriaItem(categorias[i]),
            separatorBuilder: (ctx, i) => const SizedBox(width: 10),
          ),
        );
      }

      return FutureBuilder<List<Categoria>>(
        future: findCategorias(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(6.0),
                  child: Text('Categorias', style: kMenuItem),
                ),
                kDivider,
                categoriasList(snapshot.data!),
                kDivider,
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      );
    }

    maisVendidosView() {
      return FutureBuilder<List<Produto>>(
        future: findMaisVendidos(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(6.0),
                  child: Text('Mais vendidos', style: kMenuItem),
                ),
                kDivider,
                Expanded(child: ProdutoList(produtos: snapshot.data!)),
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      );
    }

    return Column(
      children: [
        SizedBox(
          height: 105,
          child: bannersView(),
        ),
        Expanded(
          flex: 2,
          child: categoriasView(),
        ),
        Expanded(
          flex: 4,
          child: maisVendidosView(),
        ),
      ],
    );
  }

  drawerHeader() {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 150,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/drawable-mdpi/menu_pattern.png'),
              fit: BoxFit.cover,
            ),
            color: kWarmPurple,
          ),
        ),
        Positioned(
          left: 20,
          top: 45,
          child: CircleAvatar(
            radius: 22,
            backgroundColor: kTomato,
            child: Image.asset(
              'assets/images/drawable-mdpi/logo_menu.png',
              height: 32,
            ),
          ),
        ),
        const Positioned(
          right: 10,
          bottom: 5,
          child: Text('a Lodjinha', style: kLogoMenu),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/images/drawable-hdpi/logo_navbar.png',
              height: 32,
            ),
            const Text('a Lodjinha', style: kLogoMenu),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            drawerHeader(),
            const SizedBox(height: 10),
            ListTile(
              leading: Image.asset('assets/images/drawable-mdpi/home_menu.png'),
              title: const Text('Home'),
              onTap: () => Navigator.pushNamed(context, Routes.home),
            ),
            ListTile(
              leading: Image.asset('assets/images/drawable-mdpi/tag_menu.png'),
              title: const Text('Sobre o aplicativo'),
              onTap: () => Navigator.pushNamed(
                context,
                Routes.sobre,
              ),
            ),
          ],
        ),
      ),
      body: _body(),
    );
  }
}
