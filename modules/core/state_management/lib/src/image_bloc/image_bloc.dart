import 'package:common_dependencies/common_dependencies.dart';

import 'image_bloc_events.dart';

class ImageBloc extends Bloc<ImageEvent, String> {
  ImageBloc({required String initialState}) : super(initialState) {
    on<ImageEvent>((event, emit) => emit(event.url));
  }
}
