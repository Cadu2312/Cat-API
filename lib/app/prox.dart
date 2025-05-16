import 'package:cat_app/app/cat_description.dart';
import 'package:cat_app/app/data/repositories/cat_reportory.dart';
import 'package:flutter/material.dart';
import 'package:cat_app/app/data/http/http_client.dart';
import 'package:cat_app/app/store/cat_store.dart'; // Importe a nova página onde exibirá os detalhes do gato

class NextPage extends StatefulWidget {
  @override
  _NextPageState createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  final CatStore store = CatStore(
    repository: CatRepository(
      client: HttpClient(),
    ),
  );

  @override
  void initState() {
    super.initState();
    store.getCats();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Removendo appBar e definindo o título diretamente no corpo do Scaffold
      body: Column(
        children: [
          SizedBox(height: 25),
          Container(
            padding: EdgeInsets.all(16),
            alignment: Alignment.centerLeft,
            child: Text(
              'Cats',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: AnimatedBuilder(
              animation: Listenable.merge([
                store.isLoading,
                store.erro,
                store.state,
              ]),
              builder: (context, child) {
                if (store.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }

                if (store.erro.value.isNotEmpty) {
                  return Center(
                    child: Text(
                      store.erro.value,
                      style: const TextStyle(color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  );
                }

                if (store.state.value.isEmpty) {
                  return Center(
                    child: Text(
                      'Nenhum item na lista',
                      style: const TextStyle(color: Colors.black54),
                      textAlign: TextAlign.center,
                    ),
                  );
                } else {
                  return ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(height: 32),
                    padding: const EdgeInsets.all(16),
                    itemCount: store.state.value.length,
                    itemBuilder: (_, index) {
                      final item = store.state.value[index];
                      return GestureDetector(
                        onTap: () {
                          // Navegar para a página de detalhes do gato
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CatPage(cat: item),
                            ),
                          );
                        },
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            item.name!,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 24,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            height: 50.0,
            color: Colors.blue,
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
