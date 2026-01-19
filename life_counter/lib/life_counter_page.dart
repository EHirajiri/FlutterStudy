import 'package:flutter/material.dart';
import 'package:life_counter/add_life_event_page.dart';
import 'package:life_counter/life_event.dart';
import 'package:life_counter/objectbox.g.dart';

class LifeCounterPage extends StatefulWidget {
  const LifeCounterPage({super.key});

  @override
  State<LifeCounterPage> createState() => _LifeCounterPageState();
}

class _LifeCounterPageState extends State<LifeCounterPage> {
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

  void putAndFetchLifeEvent(LifeEvent? lifeEvent) {
    if (lifeEvent != null) {
      lifeEventBox?.put(lifeEvent);
      fetchLifeEvents();
    }
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
                SizedBox(width: 200, child: Text(lifeEvent.title)),
                IconButton(
                  onPressed: () {
                    lifeEvent.count--;
                    putAndFetchLifeEvent(lifeEvent);
                  },
                  icon: Icon(Icons.exposure_minus_1),
                ),
                Text('${lifeEvent.count}'),
                IconButton(
                  onPressed: () {
                    lifeEvent.count++;
                    putAndFetchLifeEvent(lifeEvent);
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
                return const AddLifeEventPage();
              },
            ),
          );
          putAndFetchLifeEvent(newLifeEvent);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
