import 'package:cubit_example/business_logic/stream_ctrl.dart';
import 'package:cubit_example/presentation/posts_page.dart';
import 'package:flutter/material.dart';

class CounterPageWithStreamBuilder extends StatefulWidget {
  const CounterPageWithStreamBuilder({super.key, required this.title});

  final String title;

  @override
  State<CounterPageWithStreamBuilder> createState() =>
      _CounterPageWithStreamBuilderState();
}

class _CounterPageWithStreamBuilderState
    extends State<CounterPageWithStreamBuilder> {
  Controller ctrl = Controller();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            StreamBuilder(
                stream: ctrl.stream,
                initialData: 0,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      snapshot.data.toString(),
                      style: Theme.of(context).textTheme.headlineMedium,
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return const Center(
                      child: Text('Error'),
                    );
                  }
                }),
            const SizedBox(height: 16),
            ElevatedButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PostsPage(),
                    )),
                child: const Text('Go to Posts'))
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'inc',
            onPressed: ctrl.increment,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            heroTag: 'dec',
            onPressed: ctrl.decrement,
            tooltip: 'Decrement',
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
