import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_desktop/core/i18n/translations.g.dart';
import 'package:dis_saucisse_desktop/core/presentation/failure_message.dart';
import 'package:flutter/widgets.dart';

class FailureView extends StatelessWidget {
  const FailureView({super.key, required this.failure, required this.onRetry});

  final AppFailure failure;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final FailureMessage content = failureMessage(failure);
    return DsMessageView(
      title: content.title,
      message: content.message,
      placement: DsMessagePlacement.panel,
      primaryAction: DsMessageAction(label: t.failures.retry, onPressed: onRetry),
    );
  }
}
