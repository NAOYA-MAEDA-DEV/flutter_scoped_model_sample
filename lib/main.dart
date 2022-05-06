import 'package:flutter/material.dart';
import 'package:flutter_scoped_model_sample/model/counter.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Scoped Model Sample',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ScopedModel<Counter>(
          model: Counter(),
          child: const MyHomePage(title: 'Scoped Model Sample'),
        )
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, @required this.title}) : super(key: key);
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title!)),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: ScopedModel.of<Counter>(context).increment
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScopedModelDescendant<Counter>(
              builder: (context, child, model) =>
                  Text(
                    model.counter.toString(),
                    style: const TextStyle(
                        fontSize: 24
                    ),
                  ),
            ),
            ScopedModelDescendant<Counter>(
              builder: (context, child, model) =>
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        model.counter.toString(),
                        style: const TextStyle(
                            fontSize: 24
                        ),
                      ),
                      child ?? Container()
                    ],
                  ),
              child: const WidgetA(),
            ),
            const WidgetB()
          ],
        ),
      ),
    );
  }
}

class WidgetA extends StatelessWidget {
  const WidgetA({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Build WidgetA');
    return const Icon(Icons.android);
  }
}

class WidgetB extends StatelessWidget {
  const WidgetB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Build WidgetB');
    return Text(ScopedModel.of<Counter>(context, rebuildOnChange: true).counter.toString());
  }
}