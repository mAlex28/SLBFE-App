import 'package:flutter/material.dart';
import 'package:mobile/custom/chip_list.dart';

class MyMultiSelectionField<T> extends StatelessWidget {
  MyMultiSelectionField({
    Key? key,
    required this.onChanged,
    required this.values,
  }) : super(key: key);

  ValueChanged<List> onChanged;
  List<String> values;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          onSubmitted: (String value) {
            values.add(value);
            onChanged(values);
          },
        ),
        MyChipList(
            values: values,
            chipBuilder: (String value) {
              return Chip(
                label: Text(value),
                onDeleted: () {
                  values.remove(value);
                  onChanged(values);
                },
              );
            })
      ],
    );
  }
}
