/// Where a [DsMessageView] is shown.
enum DsMessagePlacement {
  /// A full page pushed on top of the app: it paints its own background and shows a large mascot.
  page,

  /// The content of a tab: the screen paints the background and the floating nav bar covers its bottom.
  tab,

  /// A panel of a desktop window: the window paints the background, and the message keeps a readable width.
  panel,
}
