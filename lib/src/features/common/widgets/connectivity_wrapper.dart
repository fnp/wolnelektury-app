import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolnelektury/src/features/common/cubits/connectivity/connectivity_cubit.dart';

class ConnectivityWrapper extends StatelessWidget {
  final Widget Function(BuildContext context, bool hasConnection) builder;
  const ConnectivityWrapper({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectivityCubit, ConnectivityState>(
      buildWhen: (previous, current) {
        return previous.isConnected != current.isConnected;
      },
      builder: (context, state) {
        return builder(context, state.isConnected);
      },
    );
  }
}
