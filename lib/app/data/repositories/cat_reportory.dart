import 'package:cat_app/app/data/http/exceptions.dart';
import 'package:cat_app/app/data/http/http_client.dart';
import 'package:cat_app/app/data/model/produto_model.dart';
import 'dart:convert';

abstract class ICatRepository {
  Future<List<CatModel>> getCat();
  Future<CatModel> getCatImage(CatModel cat);
}

class CatRepository implements ICatRepository {
  final IHttpClient client;

  CatRepository({required this.client});

  @override
  Future<List<CatModel>> getCat() async {
    final response = await client.get(
      url: 'https://api.thecatapi.com/v1/breeds?limit=10&page=0',
    );

    if (response.statusCode == 200) {
      final List<CatModel> cats = [];

      final body = jsonDecode(response.body);

      body.map((item) {
        final CatModel cat = CatModel.fromMap(item);
        cats.add(cat);
      }).toList();

      return cats;
    } else if (response.statusCode == 404) {
      throw NotFoundException('A url informada não é valida');
    } else {
      throw Exception('Não foi possivel carregar');
    }
  }

  @override
  Future<CatModel> getCatImage(CatModel cat) async {
    final response = await client.get(
      url: 'https://api.thecatapi.com/v1/images/' + cat.image_reference_id!,
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);

      cat.url_imagem = body['url'];

      print(cat);

      return cat;
    } else if (response.statusCode == 404) {
      throw NotFoundException('A url informada não é valida');
    } else {
      throw Exception('Não foi possivel carregar');
    }
  }
}
