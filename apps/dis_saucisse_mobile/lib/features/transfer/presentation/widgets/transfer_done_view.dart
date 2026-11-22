import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/core/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:dis_saucisse_mobile/core/i18n/translations.g.dart';

class TransferDoneView extends StatelessWidget {
  const TransferDoneView({
    super.key,
    required this.computerName,
    required this.sentCount,
    required this.eventCount,
    required this.sentBytes,
  });

  final String computerName;
  final int sentCount;
  final int eventCount;
  final int sentBytes;

  @override
  Widget build(BuildContext context) => ColoredBox(
    color: DsColors.mustardLight,
    child: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(DsSpacing.l),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Spacer(),
            const Center(child: DsMascot(width: 220)),
            const SizedBox(height: DsSpacing.xl),
            Text(t.transfer.done.title, style: DsTextStyles.display, textAlign: TextAlign.center),
            const SizedBox(height: DsSpacing.s),
            Text(
              t.transfer.done.summary(
                photos: sentCount == 1 ? t.transfer.done.photosSingle : t.transfer.done.photosSeveral(count: sentCount),
                computerName: computerName,
                events: eventCount == 1
                    ? t.transfer.done.eventsSingle
                    : t.transfer.done.eventsSeveral(count: eventCount),
              ),
              style: DsTextStyles.body,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: DsSpacing.m),
            Center(
              child: DecoratedBox(
                decoration: const BoxDecoration(color: DsColors.background, borderRadius: DsRadius.pillAll),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: DsSpacing.m, vertical: DsSpacing.xs),
                  child: Text.rich(
                    TextSpan(
                      children: <InlineSpan>[
                        TextSpan(
                          text: byteSizeLabel(sentBytes),
                          style: DsTextStyles.titleM.copyWith(color: DsColors.sausage),
                        ),
                        TextSpan(text: t.transfer.done.freeable, style: DsTextStyles.bodyBold),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),
            DsButton(
              label: t.transfer.done.freeSpace,
              variant: DsButtonVariant.dark,
              onPressed: () => const FreeSpacePageRoute().pushReplacement(context),
            ),
            const SizedBox(height: DsSpacing.s),
            DsButton(
              label: t.transfer.done.keep,
              variant: DsButtonVariant.light,
              onPressed: () => Navigator.of(context).maybePop(),
            ),
          ],
        ),
      ),
    ),
  );
}
