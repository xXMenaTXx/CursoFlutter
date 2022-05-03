import 'package:flutter/material.dart';
import 'package:newsapp/src/models/news_models.dart';
import 'package:newsapp/src/theme/tema.dart';
import 'package:url_launcher/url_launcher.dart';

class ListaNoticias extends StatelessWidget {

  final List<Article> noticias;

  const ListaNoticias({ Key? key, required this.noticias }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: noticias.length,
      itemBuilder: (BuildContext context, int index) {
        return _Noticia(noticia: noticias[index], index: index);
      },
    );
  }
}

class _Noticia extends StatelessWidget {

  final Article noticia;
  final int index;

  const _Noticia({ 
    Key? key, 
    required this.noticia, 
    required this.index 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TarjetaTopBar(noticia: noticia,index: index,),
        _TarjetaTitulo(noticia: noticia),
        _TarjetaImagen(noticia: noticia),
        _TarjetaBody(noticia: noticia),
        const _TarjetaBotones(),
        const SizedBox(height: 10,),
        const Divider(),
      ],
    );
  }
}

class _TarjetaBotones extends StatelessWidget {
  const _TarjetaBotones({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          RawMaterialButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            fillColor: miTema.colorScheme.primary,
            child: const Icon(Icons.star_border),
            onPressed: (){}
          ),
          const SizedBox(width: 10,),
          RawMaterialButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            fillColor: Colors.blue,
            child: const Icon(Icons.more),
            onPressed: (){}
          ),

        ],
      ),
    );
  }
}

class _TarjetaBody extends StatelessWidget {

  final Article noticia;
  
  const _TarjetaBody({
    Key? key, 
    required this.noticia, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text( (noticia.description ?? '' ) ),
    );
  }
}
class _TarjetaImagen extends StatelessWidget {

  final Article noticia;
  
  const _TarjetaImagen({
    Key? key, 
    required this.noticia, 
  }) : super(key: key);

  bool comprobarUrlImagen(String url) { 
    return Uri.parse(url).host.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
        child: Container(
          child: noticia.urlToImage != null && comprobarUrlImagen(noticia.urlToImage!)
            ? FadeInImage(
                placeholder: const AssetImage('assets/giphy.gif'),
                image: NetworkImage(noticia.urlToImage!),
                imageErrorBuilder: (context, error, stackTrace) {
                  return const Image(image: AssetImage('assets/no-image.png'));
                },
              )
            : const Image(image: AssetImage('assets/no-image.png'))
        ),
      ),
    );
  }
}

class _TarjetaTitulo extends StatelessWidget {

  final Article noticia;
  
  const _TarjetaTitulo({
    Key? key, 
    required this.noticia, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Text(noticia.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
    );
  }
}

class _TarjetaTopBar extends StatelessWidget {

  final Article noticia;
  final int index;
  
  const _TarjetaTopBar({
    Key? key, 
    required this.noticia, 
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text('${index + 1}. ', style: TextStyle(color: miTema.colorScheme.primary),),
          Text('${noticia.source.name}. ',),
        ],
      ),
    );
  }
}