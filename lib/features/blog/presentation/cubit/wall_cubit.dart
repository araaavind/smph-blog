import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'wall_state.dart';

class WallCubit extends Cubit<WallState> {
  WallCubit() : super(WallInitial());

  void loadWall(String wall) {
    emit(WallChanged(wall));
  }

  void resetWall() {
    emit(WallInitial());
  }
}
