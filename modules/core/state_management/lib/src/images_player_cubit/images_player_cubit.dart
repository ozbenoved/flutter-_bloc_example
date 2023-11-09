import 'package:common_dependencies/common_dependencies.dart';

class ImagesPlayerCubit extends Cubit<bool> {
  ImagesPlayerCubit({required bool initialState}) : super(initialState);

  void toggle() {
    emit(!state);
  }
}
