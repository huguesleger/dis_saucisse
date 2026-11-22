import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class EventNameSheet extends StatefulWidget {
  const EventNameSheet({super.key, required this.initialName, required this.placeholder});

  final String initialName;
  final String placeholder;

  @override
  State<EventNameSheet> createState() => _EventNameSheetState();
}

class _EventNameSheetState extends State<EventNameSheet> {
  late final TextEditingController _controller = TextEditingController(text: widget.initialName);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() => Navigator.of(context).pop(_controller.text);

  @override
  Widget build(BuildContext context) => DsBottomSheet(
    title: "Nomme l'événement",
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: DsSpacing.m,
      children: <Widget>[
        TextField(
          controller: _controller,
          autofocus: true,
          textCapitalization: TextCapitalization.sentences,
          textInputAction: TextInputAction.done,
          onSubmitted: (_) => _submit(),
          decoration: InputDecoration(hintText: widget.placeholder),
        ),
        DsButton(label: 'Enregistrer', onPressed: _submit),
      ],
    ),
  );
}
