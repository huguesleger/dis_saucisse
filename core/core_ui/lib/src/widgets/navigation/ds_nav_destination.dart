import 'package:flutter/widgets.dart';

/// A destination of [DsFloatingNavBar] or of the desktop sidebar.
final class DsNavDestination {
  const DsNavDestination({required this.icon, required this.label});

  final IconData icon;

  /// Read by screen readers and shown as tooltip: the floating bar has no visible labels.
  final String label;
}
