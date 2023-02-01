import 'package:bcsantos/add_history_page.dart';
import 'package:bcsantos/inspection_tile.dart';
import 'package:bcsantos/model/history.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:bcsantos/model/history.dart';
import 'package:native_pdf_view/native_pdf_view.dart';
import 'package:bcsantos/shell_execute_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  // Registering the adapter
  Hive.registerAdapter(HistoryAdapter());
  // Opening the box
  await Hive.openBox<History>('historyBox');

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
  late Box<History> historyBox;

  @override
  void initState() {
    historyBox = Hive.box('historyBox');
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
          valueListenable: historyBox.listenable(),
          builder: (context, box, widget) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: ListView.builder(
                  itemCount: historyBox.length,
                  itemBuilder: (context, index) {
                    final history = historyBox.getAt(index);
                    return Card(
                        child: ListTile(
                      title: Text(history!.inspector!),
                      subtitle: Text(
                          '${history.inspectionDate.day.toString()}-${history.inspectionDate.month.toString()}-${history.inspectionDate.year.toString()}'),
                      leading: CircleAvatar(
                        child: Text(history.inspector![0]),
                      ),
                      trailing: IconButton(
                        icon: const Icon((Icons.cloud_upload)),
                        onPressed: () {
                          ShellExecuteService shellExecuteService =
                              ShellExecuteService();
                          void openFile(path) async {
                            final filePath = path;
                            final result =
                                await shellExecuteService.openFile(filePath);
                            if (result) {
                              (mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('File opened')));
                              };
                            } else {
                              (mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('File not opened')));
                              };
                            }
                          }
                          return openFile(history.archive);
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
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
