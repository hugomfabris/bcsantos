import 'package:bcsantos/controllers/chips_controller.dart';
import 'package:bcsantos/controllers/inspection_controller.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../inspection_tile.dart';
import '../models/hive_models.dart';
import 'add_inspection_page.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:bcsantos/content.dart';


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
  late ChipsController chipsController;
  bool chipsVisibility = false;
  final box = Hive.box<Inspection>('inspectionBox');
  int tag = 10;

  // List<String> chips = [
  //   'CD ICARAI',
  //   'CD INGA',
  //   'E-240',
  //   'OMS V',
  //   'OMS XVII',
  //   'SC 42',
  //   'SC 54',
  //   'ECO MARITMO',
  //   'FLAMENGO',
  //   'PRAINHA',
  //   'THOR AMIGO',
  //   'SM VITORIA',
  // ];
  
  // List<String> chipsGenerator() {

  //   var chipsNames = <String>[];

  //   for (var element in box.values) {
  //     if (chipsNames.contains(element.name) == false) {
  //       chipsNames.add(element.name.toString());
  //     }
  //   }
  //   print(chipsNames);
  //   return chipsNames;
  // }

  @override
  void initState() {
    inspectionController = InspectionController();
    chipsController = ChipsController();
    super.initState();
  }

  void _addInspection(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => AddInspectionPage(
              inspectionController: inspectionController,
            ),
        fullscreenDialog: true));
  }

  void _showMenu(BuildContext context) {
    setState(() {});
    chipsVisibility = !chipsVisibility;
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
                Visibility(
                    visible: chipsVisibility,
                    child: Wrap(
                      children: <Widget>[
                        Content(
                          child: ChipsChoice<int>.single(
                            value: tag,
                            onChanged: (val) => setState(() => tag = val),
                            choiceItems: C2Choice.listFrom<int, String>(
                              source: chipsController.chipsNames,
                              value: (i, v) => i,
                              label: (i, v) => v,
                              tooltip: (i, v) => v,
                            ),
                            choiceStyle: C2ChipStyle.filled(
                              selectedStyle: const C2ChipStyle(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
                Expanded(
                    child: ListView.builder(
                  itemCount: inspectionController.inspections.length,
                  itemBuilder: (context, index) {
                    final inspection = inspectionController.inspections[index];
                    return InspectionTile(
                      inspection: inspection,
                    );
                  },
                ))
              ],
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addInspection(context),
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
