import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/cubits/home_cubit/home_cubit.dart';

class HomeSlidingbar extends StatelessWidget {
  const HomeSlidingbar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: CupertinoSlidingSegmentedControl(
            children: state.slidingBarControlsMap,
            groupValue: state.selectedControl,
            onValueChanged: (SlidingBarControl? control) {
              context.read<HomeCubit>().changeControl(control!);
            },

            backgroundColor: Theme.of(context).colorScheme.secondary,
            thumbColor: Theme.of(context).colorScheme.primary,
            padding: const EdgeInsetsGeometry.symmetric(
              horizontal: 16,
              vertical: 5,
            ),
          ),
        );
      },
    );
  }
}
