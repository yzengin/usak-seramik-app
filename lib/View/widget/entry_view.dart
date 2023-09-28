import 'package:flutter/material.dart';
import '../../Model/entry.dart';
import '/Controller/extension.dart';

class EntryView extends StatelessWidget {
  const EntryView({super.key, required this.entry, this.thickness = 0.5, this.isLast = false});
  final EntryData entry;
  final double thickness;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: context.textStyle.copyWith(fontSize: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text("${entry.key}:")),
              Text(entry.data),
            ],
          ),
          if(!isLast) Divider(thickness: thickness)
        ],
      ),
    );
  }
}
