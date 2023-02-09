import 'package:flutter/material.dart';
import 'pages/barcaca.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
              child: ListTile(
                title: const Center( child: Text('CD INGA')),
                mouseCursor: MouseCursor.defer,
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const BarcacaPage(),
                      fullscreenDialog: true));
                },
              ),
        )],
        ),
      ),
    );
  }

}