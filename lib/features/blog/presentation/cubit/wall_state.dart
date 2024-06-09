part of 'wall_cubit.dart';

@immutable
sealed class WallState {}

final class WallInitial extends WallState {}

final class WallChanged extends WallState {
  final String wall;

  WallChanged(this.wall);
}
