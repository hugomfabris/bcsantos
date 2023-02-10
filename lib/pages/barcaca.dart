import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:bcsantos/models/hive_models.dart';
import 'package:bcsantos/inspection_tile.dart';

main() async {
  runApp(const BarcacaPage());
}

class BarcacaPage extends StatefulWidget {
  const BarcacaPage({super.key});

  @override
  State<BarcacaPage> createState() => _BarcacaPageState();
}

class _BarcacaPageState extends State<BarcacaPage> {
  String? planPath;
  late Box historybox = Hive.box<Inspection>('historyBox');
  late Box barcacabox;
  final String barcaca = 'CD Inga';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CD INGA'),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
          valueListenable: historybox.listenable(),
          builder: (context, box, widget) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: ListView.builder(
                  itemCount: box.length,
                  itemBuilder: (context, index) {
                    final bc = historybox.getAt(index);
                    print(bc.name);
                  },
                ))
              ],
            );
          }),
    );
  }
}
