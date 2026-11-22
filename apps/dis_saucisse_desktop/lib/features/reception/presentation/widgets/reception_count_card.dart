import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_desktop/core/i18n/translations.g.dart';
import 'package:dis_saucisse_desktop/features/pairing/presentation/bloc/reception_cubit.dart';
import 'package:dis_saucisse_desktop/features/reception/domain/rules/remaining_time.dart';
import 'package:dis_saucisse_desktop/features/reception/presentation/remaining_time_label.dart';
import 'package:dis_saucisse_desktop/features/reception/presentation/widgets/reception_safety_note.dart';
import 'package:dis_saucisse_desktop/features/reception/presentation/widgets/reception_stat_box.dart';
import 'package:flutter/material.dart';

class ReceptionCountCard extends StatelessWidget {
  const ReceptionCountCard({super.key, required this.progress});

  final ReceptionInProgress progress;

  @override
  Widget build(BuildContext context) => DsCard(
    padding: const EdgeInsets.all(DsSpacing.xl),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            spacing: DsSpacing.m,
            children: <Widget>[
              const DsMascot(width: 104),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text.rich(
                      TextSpan(
                        text: '${progress.received}',
                        style: DsTextStyles.number,
                        children: <InlineSpan>[
                          TextSpan(
                            text: ' / ${progress.expected}',
                            style: DsTextStyles.titleL.copyWith(color: DsColors.textSoft),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      receivedPhotosLabel(
                        remainingTime(
                          startedAt: progress.startedAt,
                          lastReceivedAt: progress.lastReceivedAt,
                          received: progress.received,
                          expected: progress.expected,
                        ),
                      ),
                      style: DsTextStyles.caption,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: DsSpacing.l),
          DsProgressBar(
            value: progress.expected == 0 ? 0 : progress.received / progress.expected,
            trackColor: DsColors.surfaceStrong,
          ),
          const SizedBox(height: DsSpacing.l),
          Row(
            spacing: DsSpacing.s,
            children: <Widget>[
              Expanded(
                child: ReceptionStatBox(
                  value: '${progress.received}',
                  label: t.reception.countCard.verified,
                  dot: DsColors.mustard,
                ),
              ),
              Expanded(
                child: ReceptionStatBox(
                  value: '${progress.rejected}',
                  label: progress.rejected > 1 ? t.reception.countCard.errorSeveral : t.reception.countCard.errorSingle,
                  dot: progress.rejected == 0 ? DsColors.success.withValues(alpha: 0.4) : DsColors.sausage,
                ),
              ),
              Expanded(
                child: ReceptionStatBox(
                  value: byteSizeLabel(progress.byteCount),
                  label: t.reception.countCard.received,
                  dot: DsColors.surfaceStrong,
                ),
              ),
            ],
          ),
          const SizedBox(height: DsSpacing.l),
          const ReceptionSafetyNote(),
        ],
      ),
    ),
  );
}
