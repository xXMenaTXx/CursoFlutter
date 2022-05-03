import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newsapp/src/models/category_model.dart';
import 'package:newsapp/src/models/news_models.dart';
import 'package:http/http.dart' as http;

class NewsService extends ChangeNotifier{

  final _urlNews = 'newsapi.org';
  final _apiKey = 'e3a4e16062ba425b9aa8ffa15975082b';
  String _selectedCategory = 'business';

  List<Article> headlines = [];
  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.volleyball, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology'),
  ];

  Map<String, List<Article>>  categoryArticles = {};

  NewsService(){
    getTopHeadlines();
    categories.forEach((item) {
      categoryArticles[item.name] = [];
    });
    getArticlesByCategory(selectedCategory);
  }

  String get selectedCategory => _selectedCategory;

  set selectedCategory (String valor){
    _selectedCategory = valor;
    getArticlesByCategory(valor);
    notifyListeners();
  }

  get getArticulosCategoriaSeleccionada => categoryArticles[selectedCategory];

  getTopHeadlines() async {
    final url = Uri.https(_urlNews, '/v2/top-headlines', {
      'apiKey': _apiKey,
      'country': 'co',
    });
    // final url = '$_urlNews/top-headlines?apiKey=$_apiKey&country=co';
    final resp = await http.get(url);

    final newsResponse = newResponseFromJson(resp.body);
    headlines.addAll(newsResponse.articles);
    notifyListeners();
  }

  getArticlesByCategory(String category)async{

    // ignore: prefer_is_empty
    if(categoryArticles[category]!.length > 0){
      return categoryArticles[category];
    }

    final url = Uri.https(_urlNews, '/v2/top-headlines', {
      'apiKey': _apiKey,
      'country': 'co',
      'category': category,
    });
    final resp = await http.get(url);

    final newsResponse = newResponseFromJson(resp.body);
    categoryArticles[category]!.addAll(newsResponse.articles);
    notifyListeners();
  }
}