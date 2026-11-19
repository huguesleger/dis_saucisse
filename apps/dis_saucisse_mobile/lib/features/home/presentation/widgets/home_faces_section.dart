import 'package:core_ui/core_ui.dart';
import 'package:dis_saucisse_mobile/features/home/presentation/widgets/home_face_avatar.dart';
import 'package:flutter/widgets.dart';

class HomeFacesSection extends StatelessWidget {
  const HomeFacesSection({super.key, required this.names});

  final List<String> names;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: DsSpacing.s,
    children: <Widget>[
      const DsSectionHeader(title: 'Les visages', trailing: 'Tout voir'),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          for (final (int index, String name) in names.indexed) HomeFaceAvatar(name: name, placeholderIndex: index),
        ],
      ),
    ],
  );
}
