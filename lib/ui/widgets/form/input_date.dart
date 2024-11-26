// ignore_for_file: always_specify_types

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_production_boilerplate_riverpod/utils/date.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:flutter_production_boilerplate_riverpod/config/style.dart';

class InputDate extends StatelessWidget {
  final String label;
  final DateTime? initialValue;
  final String? name;
  final List<FormFieldValidator<DateTime>>? validators;
  final String? cancelText;
  final String? confirmText;
  final DateTime? minDate;
  final DateTime? maxDate;
  final bool? autoFocus;
  final String? placeholder;
  final String? helperText;
  final bool? disabled;
  final String? error;
  final bool? obscureText;
  final bool? readOnly;
  final void Function(DateTime)? onChange;

  const InputDate({
    super.key,
    required this.label,
    this.initialValue,
    this.onChange,
    this.name,
    this.validators,
    this.minDate,
    this.maxDate,
    this.cancelText,
    this.confirmText,
    this.autoFocus,
    this.placeholder,
    this.helperText,
    this.disabled,
    this.error,
    this.obscureText,
    this.readOnly,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<DateTime>(
      name: name ?? '',
      initialValue: initialValue ?? DateTime.now(),
      validator: FormBuilderValidators.compose(
        validators ?? <String? Function(dynamic)>[],
      ),
      builder: (FormFieldState<DateTime> field) => getInput(context, field),
    );
  }

  Widget getInput(
    BuildContext context,
    FormFieldState<DateTime> field,
  ) {
    TextEditingController textController = TextEditingController(
      text: formatDateTime(
        dateTime: field.value,
        formatType: DateFormatType.ddMMyyyy,
      ),
    );

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(fontSize: Style.labelInputSize),
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          TextField(
            controller: textController,
            onTap: () async {
              DateTime? datetime = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: minDate ?? DateTime(2000),
                lastDate: maxDate ?? DateTime(2100),
                cancelText: cancelText ?? 'Cancel',
                confirmText: confirmText ?? 'Confirm',
                helpText: helperText,
              );

              if (datetime != null) {
                if (onChange != null) {
                  onChange!(datetime);
                }
                field.didChange(datetime);
              }
            },
            enabled: disabled != true,
            readOnly: true,
            autofocus: autoFocus ?? false,
            obscureText: obscureText ?? false,
            decoration: InputDecoration(
              filled: true,
              isDense: true,
              errorText: field.errorText ?? error,
              hintText: placeholder,
              helperText: helperText,
              fillColor: Colors.white.withOpacity(0.1),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            style: TextStyle(
              height: Style.inputHeight,
            ),
          ),
        ],
      ),
    );
  }
}
