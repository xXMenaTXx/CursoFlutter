import 'package:flutter/material.dart';
import 'package:newsapp/src/pages/pages.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatelessWidget {
  const TabsPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _NavegacionModel(),
      child: const Scaffold(
        body: _Paginas(),
        bottomNavigationBar: _Navegacion(),
      ),
    );
  }
}

class _Navegacion extends StatelessWidget {
  const _Navegacion({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final navegacionModel = Provider.of<_NavegacionModel>(context);

    return BottomNavigationBar(
      currentIndex: navegacionModel.paginaActual,
      onTap: (i) => navegacionModel.paginaActual = i,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Para ti',),
        BottomNavigationBarItem(icon: Icon(Icons.public), label: 'Encabezados',),
      ],
    );
  }
}

class _Paginas extends StatelessWidget {
  const _Paginas({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final navegacionModel = Provider.of<_NavegacionModel>(context);

    return PageView(
      // physics: const BouncingScrollPhysics(),
      physics: const NeverScrollableScrollPhysics(),
      controller: navegacionModel.pageController,
      children: const [

        Tab1Page(),
        Tab2Page()
      ],
    );
  }
}

class _NavegacionModel extends ChangeNotifier{

  int _paginaActual = 0;
  final PageController _pageController = PageController();

  int get paginaActual => _paginaActual;

  set paginaActual (int valor) {
    _paginaActual = valor;
    _pageController.animateToPage(valor, duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
    notifyListeners();
  }

  PageController get pageController => _pageController;
}