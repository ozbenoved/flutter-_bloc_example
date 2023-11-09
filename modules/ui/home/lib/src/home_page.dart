import 'package:common_dependencies/common_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:state_management/state_management.dart';

import 'home_page_content.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<CounterBloc>(create: (BuildContext context) => CounterBloc(initialState: 0)),
      BlocProvider<ThemeCubit>(
          create: (BuildContext context) => ThemeCubit(initialState: ThemeData())),
      BlocProvider<ImagesPlayerCubit>(
          create: (BuildContext context) => ImagesPlayerCubit(initialState: true)),
      BlocProvider<ImageBloc>(
          create: (BuildContext context) => ImageBloc(
              initialState:
                  'https://megatron.co.il/en/wp-content/uploads/sites/2/2016/01/default-placeholder.png'))
    ], child: HomePageContent());
  }
}
