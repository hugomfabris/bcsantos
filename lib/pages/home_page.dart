import 'package:bcsantos/inspection_controller.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../inspection_tile.dart';
import '../menu.dart';
import 'add_history_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late InspectionController inspectionController;
  bool isSwitched = false;

  @override
  void initState() {
    inspectionController = InspectionController();
    super.initState();
  }

  void _addHistory(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => AddHistoryPage(
              inspectionController: inspectionController,
            ),
        fullscreenDialog: true));
  }

  void _showMenu(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const Menu(), fullscreenDialog: true));
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => _showMenu(context),
        ),
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: AnimatedBuilder(
          animation: inspectionController,
          builder: (context, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                Expanded(
                    child: ListView.builder(
                  itemCount: inspectionController.inspections.length,
                  itemBuilder: (context, index) {
                    final history = inspectionController.inspections[index];
                    return InspectionTile(
                      inspection: history,
                    );
                  },
                ))
              ],
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addHistory(context),
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
