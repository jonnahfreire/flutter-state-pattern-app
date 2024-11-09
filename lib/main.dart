import 'package:flutter/material.dart';
import 'package:state_management_app/state-pattern/person_state.dart';
import 'package:state_management_app/state-pattern/person_store.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final store = PersonStore.instance;

  @override
  void initState() {
    super.initState();
    store.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListenableBuilder(
        listenable: store,
        builder: (context, child) {
          final state = store.state;

          if (state is LoadingPeopleState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ErrorPeopleState) {
            return Text(state.error);
          }

          if (state is FetchedPeopleState) {
            return Center(
              child: ListView(
                children: <Widget>[
                  ...state.people.map(
                    (person) => Row(
                      children: [
                        Text(person.id.toString()),
                        const SizedBox(width: 10),
                        Text(person.name),
                      ],
                    ),
                  )
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await store.getAll();
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
