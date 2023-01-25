import 'package:bcsantos/add_history_page.dart';
import 'package:bcsantos/inspection_tile.dart';
import 'package:bcsantos/model/historico.dart';
import 'package:flutter/material.dart';
import 'package:bcsantos/inspection_controller.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:bcsantos/model/historico.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  // Registering the adapter
  Hive.registerAdapter(HistoryAdapter());
  // Opening the box
  await Hive.openBox<History>('historicoBox');


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BC SANTOS',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.indigo,
      ),
      home: const MyHomePage(title: 'BC SANTOS'),
    );
  }
}

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
  
  late Box<History> historicoBox;

  @override
  void initState() {
    historicoBox = Hive.box('historicoBox');
    super.initState();
  }

  void _addHistory(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const AddHistoryPage(), fullscreenDialog: true));

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
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
          valueListenable: historicoBox.listenable(),
          builder: (context, box, widget) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: ListView.builder(
                  itemCount: historicoBox.length,
                  itemBuilder: (context, index) {
                    final history = historicoBox.getAt(index);
                    return Card(
                      child: ListTile(
                      title: Text(history!.inspector!),
                      subtitle: Text('${history.inspectionDate.day.toString()}-${history.inspectionDate.month.toString()}-${history.inspectionDate.year.toString()}'),
                      leading: CircleAvatar(
                        child: Text(history.inspector![0]),
                      ),
                      trailing: IconButton(
                        icon: const Icon((Icons.cloud_upload)),
                        onPressed: () {
                          historicoBox.deleteAt(index);
                        },
                      ),
                    ));
                  },
                )),
              ],
            );
          }),
      floatingActionButton: FloatingActionButton(

        onPressed: () => _addHistory(context),

        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
