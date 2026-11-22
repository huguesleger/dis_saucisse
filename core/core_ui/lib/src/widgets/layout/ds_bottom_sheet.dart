import 'package:core_ui/src/foundation/ds_spacing.dart';
import 'package:core_ui/src/foundation/ds_text_styles.dart';
import 'package:flutter/material.dart';

/// Content of a modal bottom sheet: a title, an optional subtitle and the [child] below.
///
/// It stays above the keyboard and never grows past 85% of the screen: give it a scrollable
/// [child] when the content may be long. Open it with [DsBottomSheet.show].
class DsBottomSheet extends StatelessWidget {
  const DsBottomSheet({super.key, required this.title, this.subtitle, required this.child});

  final String title;
  final String? subtitle;
  final Widget child;

  /// Opens a modal bottom sheet above the whole app, tab bar included, and returns the value it pops.
  static Future<T?> show<T>(BuildContext context, {required WidgetBuilder builder}) =>
      showModalBottomSheet<T>(context: context, useRootNavigator: true, isScrollControlled: true, builder: builder);

  @override
  Widget build(BuildContext context) {
    final String? caption = subtitle;
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * 0.85),
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(DsSpacing.l, 0, DsSpacing.l, DsSpacing.m),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(title, style: DsTextStyles.titleL),
                if (caption != null) ...<Widget>[
                  const SizedBox(height: DsSpacing.xxs),
                  Text(caption, style: DsTextStyles.caption),
                ],
                const SizedBox(height: DsSpacing.m),
                Flexible(child: child),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
