import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter/cupertino.dart' show Icon, State;
import 'package:flutter/material.dart' show Colors, Icons;
import 'package:english_words/english_words.dart' as w;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold(
      body: Column(
        children: [
          Text('A random idea:'),
          Text(appState.current.asLowerCase),
        ],
      ),
    );
  }
}


class WordPair {
  WordPair(this.state);
  final State state;
  final suggestions = <w.WordPair>[];
  final Set<w.WordPair> saved = <w.WordPair>{};
  int index;
  void build(int i) {
    index = i ~/ 2;
    if (index >= suggestions.length) {
      suggestions.addAll(w.generateWordPairs().take(10));
    }
  }
  String get current => suggestions[index].asPascalCase;
  Icon get icon {
    bool alreadySaved = saved.contains(suggestions[index]);
    return Icon(
      alreadySaved ? Icons.favorite : Icons.favorite_border,
      color: alreadySaved ? Colors.red : null,
    );
  }
  void onTap(int i) => state.setState(() {
    int index = i ~/ 2;
    w.WordPair pair = suggestions[index];
    if (pair == null) return;
    if (saved.contains(suggestions[index])) {
      saved.remove(pair);
    } else {
      saved.add(pair);
    }
  });
}