import 'package:flutter/material.dart';
import 'package:life_counter/life_event.dart';
import 'package:life_counter/objectbox.g.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Life Counter',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
      ),
      home: const LifeCounterPagState(),
    );
  }
}

class LifeCounterPagState extends StatefulWidget {
  const LifeCounterPagState({super.key});

  @override
  State<LifeCounterPagState> createState() => _LifeCounterPagStateState();
}

class _LifeCounterPagStateState extends State<LifeCounterPagState> {
  Store? store;
  Box<LifeEvent>? lifeEventBox;
  List<LifeEvent> lifeEvents = [];

  Future<void> initialize() async {
    store = await openStore();
    lifeEventBox = store?.box<LifeEvent>();
    fetchLifeEvents();
  }

  void fetchLifeEvents() {
    lifeEvents = lifeEventBox?.getAll() ?? [];
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('人生カウンター')),
      body: ListView.builder(
        itemCount: lifeEvents.length,
        itemBuilder: (context, index) {
          final lifeEvent = lifeEvents[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                SizedBox(width: 240, child: Text(lifeEvent.title)),
                Text('${lifeEvent.count}'),
                IconButton(
                  onPressed: () {
                    lifeEvent.count++;
                    lifeEventBox?.put(lifeEvent);
                    fetchLifeEvents();
                  },
                  icon: Icon(Icons.plus_one),
                ),
                IconButton(
                  onPressed: () {
                    lifeEventBox?.remove(lifeEvent.id);
                    fetchLifeEvents();
                  },
                  icon: Icon(Icons.delete),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newLifeEvent = await Navigator.of(context).push<LifeEvent>(
            MaterialPageRoute(
              builder: (context) {
                return const AddLifeEventPagState();
              },
            ),
          );
          if (newLifeEvent != null) {
            lifeEventBox?.put(newLifeEvent);
            fetchLifeEvents();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AddLifeEventPagState extends StatefulWidget {
  const AddLifeEventPagState({super.key});

  @override
  State<AddLifeEventPagState> createState() => _AddLifeEventPagStateState();
}

class _AddLifeEventPagStateState extends State<AddLifeEventPagState> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ライフイベント追加')),
      body: TextFormField(
        onFieldSubmitted: (text) {
          final lifeEvent = LifeEvent(title: text, count: 0);
          Navigator.of(context).pop(lifeEvent);
        },
      ),
    );
  }
}
