import 'package:flutter/material.dart';
import 'app/prox.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

    return MaterialApp(
      navigatorKey: navigatorKey,
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll<Color>(Color.fromARGB(255, 33, 150, 243)),
            ),
            onPressed: () {
              navigatorKey.currentState!.push(
                MaterialPageRoute(builder: (context) => NextPage()),
              );
            },
            child: Text('Iniciar aplicativo', style: TextStyle(color: Colors.white),),
          ),
        ),
      ),
    );
  }
}