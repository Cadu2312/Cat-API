import 'package:cat_app/app/data/model/produto_model.dart';
import 'package:flutter/material.dart';
import 'package:cat_app/app/data/http/http_client.dart';
import 'package:cat_app/app/data/repositories/cat_reportory.dart';
import 'package:cat_app/app/store/cat_description_store.dart';

class CatPage extends StatefulWidget {
  final CatModel cat;

  CatPage({required this.cat});

  @override
  _CatDetailsPage createState() => _CatDetailsPage();
}

class _CatDetailsPage extends State<CatPage> {
  final CatDescriptionStore store = CatDescriptionStore(
    repository: CatRepository(
      client: HttpClient(),
    ),
  );

  @override
  void initState() {
    super.initState();
    store.getOneCat(widget.cat); // Usando a ID fornecida ao criar a página
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
          animation: Listenable.merge([
            store.isLoading,
            store.erro,
            store.state,
          ]),
          builder: (context, child) {
            if (store.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.network(widget.cat.url_imagem!),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${store.state.value.name}:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18, // Example of font size customization
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${store.state.value.description}',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      children: [
                        'Origin:\n${store.state.value.origin}',
                        'Life Span\n  ${store.state.value.life_span}',
                        "Weight\n ${store.state.value.weight}",
                        'Temperament:\n${store.state.value.temperament}',
                      ].map((text) {
                        return Center(
                          child: Text(
                            text,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              );
            }
          }),
      bottomNavigationBar: BottomAppBar(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            height: 50.0,
            color: Color.fromARGB(255, 33, 150, 243),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.arrow_back, color: Colors.white),
                Text(
                  'Voltar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
