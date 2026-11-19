import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/core/router/routes.dart';
import 'package:dis_saucisse_mobile/features/photo_library/presentation/sorting_start/bloc/sorting_start_cubit.dart';
import 'package:dis_saucisse_mobile/features/photo_library/presentation/sorting_start/widgets/sorting_start_footer.dart';
import 'package:dis_saucisse_mobile/features/photo_library/presentation/sorting_start/widgets/sorting_start_header.dart';
import 'package:dis_saucisse_mobile/features/photo_library/presentation/sorting_start/widgets/sorting_start_options.dart';
import 'package:dis_saucisse_mobile/features/photo_library/presentation/sorting_start/widgets/sorting_start_privacy_note.dart';
import 'package:dis_saucisse_mobile/features/photo_library/presentation/sorting_start/widgets/sorting_start_status_notice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SortingStartScreen extends StatelessWidget {
  const SortingStartScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocConsumer<SortingStartCubit, SortingStartState>(
    listenWhen: (SortingStartState previous, SortingStartState current) => current is SortingStartCompleted,
    listener: (BuildContext context, SortingStartState state) => const HomePageRoute().go(context),
    builder: (BuildContext context, SortingStartState state) => Scaffold(
      body: DsMeshBackground(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(DsSpacing.l, DsSpacing.xl, DsSpacing.l, DsSpacing.l),
                  children: <Widget>[
                    const SortingStartHeader(),
                    const SizedBox(height: DsSpacing.xl),
                    SortingStartOptions(
                      choice: state.choice,
                      today: context.read<SortingStartCubit>().today,
                      onChoose: context.read<SortingStartCubit>().choose,
                    ),
                    const SizedBox(height: DsSpacing.xl),
                    const SortingStartPrivacyNote(),
                    const SizedBox(height: DsSpacing.m),
                    SortingStartStatusNotice(state: state),
                  ],
                ),
              ),
              SortingStartFooter(state: state),
            ],
          ),
        ),
      ),
    ),
  );
}
