import 'package:common_dependencies/common_dependencies.dart';

import 'counter_bloc_events.dart';

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc({required int initialState}) : super(initialState) {
    on<Increment>((event, emit) => emit(state + 1));
    on<Decrement>((event, emit) => emit(state - 1));
  }
}
