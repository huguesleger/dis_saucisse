import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/core/i18n/translations.g.dart';
import 'package:dis_saucisse_mobile/core/presentation/failure_message.dart';
import 'package:flutter/widgets.dart';

class FailureView extends StatelessWidget {
  const FailureView({
    super.key,
    required this.failure,
    required this.onRetry,
    this.secondaryAction,
    this.showBackButton = false,
    this.placement = DsMessagePlacement.page,
  });

  final AppFailure failure;
  final VoidCallback onRetry;
  final DsMessageAction? secondaryAction;
  final bool showBackButton;
  final DsMessagePlacement placement;

  @override
  Widget build(BuildContext context) {
    final FailureMessage content = failureMessage(failure);
    return DsMessageView(
      title: content.title,
      message: content.message,
      primaryAction: DsMessageAction(label: t.failures.retry, onPressed: onRetry),
      secondaryAction: secondaryAction,
      showBackButton: showBackButton,
      placement: placement,
    );
  }
}
