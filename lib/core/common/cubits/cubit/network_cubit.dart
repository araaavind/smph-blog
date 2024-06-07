import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'network_state.dart';

class NetworkCubit extends Cubit<NetworkState> {
  NetworkCubit() : super(NetworkConnected());

  void updateNetworkStatus(bool isConnected) {
    if (isConnected) {
      emit(NetworkConnected());
    } else {
      emit(NetworkDisconnected());
    }
  }
}
