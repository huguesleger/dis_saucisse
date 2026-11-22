import 'package:flutter/widgets.dart';

/// Lets a fixed layout fill the screen and still be pulled down by a `DsRefresh`.
///
/// Use it for empty or error states, which do not scroll on their own.
class DsRefreshFillView extends StatelessWidget {
  const DsRefreshFillView({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => CustomScrollView(
    physics: const AlwaysScrollableScrollPhysics(),
    slivers: <Widget>[SliverFillRemaining(hasScrollBody: false, child: child)],
  );
}
