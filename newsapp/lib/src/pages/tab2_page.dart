import 'package:flutter/material.dart';
import 'package:newsapp/src/models/category_model.dart';
import 'package:newsapp/src/services/news_service.dart';
import 'package:newsapp/src/theme/tema.dart';
import 'package:newsapp/src/widgets/widgets.dart';
import 'package:provider/provider.dart';

class Tab2Page extends StatelessWidget {
  const Tab2Page({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final newsService = Provider.of<NewsService>(context);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const _ListaCategories(),
            Expanded(
              child: ListaNoticias(noticias: newsService.getArticulosCategoriaSeleccionada,)
            ),
          ],
        ),
      ),
    );
  }
}

class _ListaCategories extends StatelessWidget {
  const _ListaCategories({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final categorias = Provider.of<NewsService>(context).categories;

    return Container(
      width: double.infinity,
      height: 90,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categorias.length,
        itemBuilder: (BuildContext contex, int index){
    
          final cName = categorias[index].name;
    
          return Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                _CategoryButton(category: categorias[index]),
                const SizedBox(height: 5,),
                Text('${ cName[0].toUpperCase() }${ cName.substring(1)}')
              ],
            ),
          );
        }
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {

  final Category category;

  const _CategoryButton({
    Key? key,
    required this.category
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final newsService = Provider.of<NewsService>(context);
    return GestureDetector(
      onTap: () {
        newsService.selectedCategory = category.name;
      },
      child: Container(
        width: 50,
        height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ), 
        child: Icon(
          category.icon,
          color: category.name == newsService.selectedCategory
            ? miTema.colorScheme.primary
            : Colors.black54,
        ),
      ),
    ); 
  }
}