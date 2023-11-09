import 'package:common_dependencies/common_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:state_management/state_management.dart';

import 'widgets/image_container.dart';

class HomePageContent extends StatelessWidget {
  const HomePageContent({super.key});

  @override
  Widget build(BuildContext context) {
    print('main built');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('A block pattern Demo'),
        actions: [
          InkWell(
            onTap: () => context.read<ImagesPlayerCubit>().toggle(),
            child: Container(
              width: 100,
              child: StreamBuilder<bool>(
                stream: context.read<ImagesPlayerCubit>().stream,
                builder: (context, snap) {
                  return Container(
                      width: 50,
                      height: 50,
                      child: Icon(
                        snap.data == null || snap.data!
                            ? Icons.pause_circle
                            : Icons.play_circle,
                        size: 50,
                      ));
                },
              ),
            ),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BlocBuilder<ThemeCubit, ThemeData>(
              builder: (_, theme) {
                print('Bloc - ThemeCubit child built');
                return Container(
                  height: 100,
                  alignment: Alignment.center,
                  color: theme.scaffoldBackgroundColor,
                  child: Text(
                    'Click on the buttons and see what happens',
                    style:
                        theme.textTheme.headlineLarge?.copyWith(fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                );
              },
            ),
            Expanded(
              child: ImageContainer(),
            ),
            BlocBuilder<CounterBloc, int>(
              builder: (context, count) {
                print('CounterBloc child built');
                context.read<ThemeCubit>().toggleTheme(count % 2 == 0);
                return Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  width: 50,
                  height: 50,
                  child: Text(
                    '$count',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        alignment: Alignment.bottomCenter,
        padding: EdgeInsets.only(left: 30),
        // width: MediaQuery.of(context).size.width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(
              onPressed: () => context.read<CounterBloc>().add(Increment()),
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
            FloatingActionButton(
              onPressed: () => context.read<CounterBloc>().add(Decrement()),
              tooltip: 'Decrement',
              child: const Icon(Icons.remove),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
