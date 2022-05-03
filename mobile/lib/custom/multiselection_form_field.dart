import 'package:flutter/material.dart';

import 'multiselection_field.dart';

class MyMultiSelectionFormField<T> extends FormField<List<T>> {
  final InputDecoration decoration;

  MyMultiSelectionFormField({
    Key? key,
    this.decoration = const InputDecoration(),
    FormFieldSetter<List>? onSaved,
    FormFieldValidator<List>? validator,
  }) : super(
            key: key,
            onSaved: onSaved,
            validator: validator,
            builder: (FormFieldState<List> field) {
              final InputDecoration effectiveDecoration =
                  decoration.applyDefaults(
                Theme.of(field.context).inputDecorationTheme,
              );
              return InputDecorator(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide.none,
                  ),
                  hintText: "Qualifications",
                  floatingLabelStyle: const TextStyle(
                      height: 4, color: Color.fromARGB(255, 32, 156, 223)),
                  filled: true,
                  fillColor: Colors.grey[300],
                ),
                isEmpty: field.value?.isEmpty ?? true,
                child: MyMultiSelectionField(
                  values: field.value?.map((e) => e.toString()).toList() ?? [],
                  onChanged: field.didChange,
                ),
              );
            });
}
