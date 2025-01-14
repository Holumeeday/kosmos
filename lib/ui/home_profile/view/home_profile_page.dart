import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:playkosmos_v3/common_widgets/common_widgets.dart';
import 'package:playkosmos_v3/ui/logout/cubit/logout_cubit.dart';

/// The user profile in the home tab
///
/// @author: Godwin Mathias
class HomeProfilePage extends StatelessWidget {
  const HomeProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final fIsLoading = context.select(
        (LogoutCubit cubit) => cubit.state.status == LogoutStatus.loading);

    return Center(
      child: fIsLoading
          ? const CircularProgressIndicator.adaptive()
          : PrimaryGradientButton(
                fDisabled: fIsLoading,
                fOnPressed: () {
                  context.read<LogoutCubit>().logout();
                },
                fChild: const Text('Logout'),
              ),
          
    );
  }
}
