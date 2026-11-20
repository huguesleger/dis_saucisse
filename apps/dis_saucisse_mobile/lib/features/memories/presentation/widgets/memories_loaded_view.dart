import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/features/memories/domain/entities/memory_month.dart';
import 'package:dis_saucisse_mobile/features/memories/presentation/bloc/memories_cubit.dart';
import 'package:dis_saucisse_mobile/features/memories/presentation/widgets/memories_header.dart';
import 'package:dis_saucisse_mobile/features/memories/presentation/widgets/memories_recap_card.dart';
import 'package:dis_saucisse_mobile/features/memories/presentation/widgets/memories_year_filters.dart';
import 'package:dis_saucisse_mobile/features/memories/presentation/widgets/memory_month_card.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MemoriesLoadedView extends StatelessWidget {
  const MemoriesLoadedView({super.key, required this.state});

  final MemoriesLoaded state;

  static const EdgeInsets _gutter = EdgeInsets.symmetric(horizontal: DsSpacing.l);

  @override
  Widget build(BuildContext context) {
    final List<MemoryMonth> months = state.visibleMonths;
    return SafeArea(
      bottom: false,
      child: ListView(
        padding: const EdgeInsets.only(top: DsSpacing.m, bottom: 140),
        children: <Widget>[
          Padding(
            padding: _gutter,
            child: MemoriesHeader(photoCount: state.photoCount),
          ),
          const SizedBox(height: DsSpacing.m),
          MemoriesYearFilters(
            years: state.years,
            selectedYear: state.selectedYear,
            onSelected: context.read<MemoriesCubit>().selectYear,
          ),
          const SizedBox(height: DsSpacing.xl),
          Padding(
            padding: _gutter,
            child: MemoriesRecapCard(memory: months.first),
          ),
          const SizedBox(height: DsSpacing.xl),
          Padding(
            padding: _gutter,
            child: DsSectionHeader(
              title: 'Mois rangés',
              trailing: months.length == 1 ? '1 mois' : '${months.length} mois',
            ),
          ),
          for (final MemoryMonth memory in months)
            Padding(
              padding: const EdgeInsets.fromLTRB(DsSpacing.l, DsSpacing.s, DsSpacing.l, 0),
              child: MemoryMonthCard(memory: memory),
            ),
        ],
      ),
    );
  }
}
