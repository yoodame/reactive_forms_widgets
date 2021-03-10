// Copyright 2020 Joan Pablo Jiménez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'datetime_range_value_accessor.dart';

/// A builder that builds a widget responsible to decide when to show
/// the picker dialog.
///
/// It has a property to access the [FormControl]
/// that is bound to [ReactiveDateRangePickerField].

/// This is a convenience widget that wraps the function
/// [showDatePicker] and [showTimePicker] in a [ReactiveDateRangePickerField].
///
/// The [formControlName] is required to bind this [ReactiveDateRangePickerField]
/// to a [FormControl].
///
/// For documentation about the various parameters, see the [showDatePicker]
/// and [showTimePicker] function parameters.
///
/// ## Example:
///
/// ```dart
/// ReactiveDateRangePickerField(
///   formControlName: 'birthday',
/// )
/// ```
class ReactiveDateRangePicker extends ReactiveFormField<DateTimeRange> {
  /// Creates a [ReactiveDateRangePickerField] that wraps the function [showDatePicker].
  ///
  /// Can optionally provide a [formControl] to bind this widget to a control.
  ///
  /// Can optionally provide a [formControlName] to bind this ReactiveFormField
  /// to a [FormControl].
  ///
  /// Must provide one of the arguments [formControl] or a [formControlName],
  /// but not both at the same time.
  ///
  /// The parameter [transitionBuilder] is the equivalent of [builder]
  /// parameter in the [showTimePicker].
  ///
  /// For documentation about the various parameters, see the [showTimePicker]
  /// function parameters.
  ReactiveDateRangePicker({
    Key key,
    String formControlName,
    FormControl formControl,
    TextStyle style,
    ControlValueAccessor valueAccessor,
    ValidationMessagesFunction validationMessages,
    InputDecoration decoration,
    bool showClearIcon = true,
    Widget clearIcon = const Icon(Icons.clear),

    // date range picker params
    TransitionBuilder builder,
    bool useRootNavigator = true,
    String cancelText,
    String confirmText,
    String helpText,
    String saveText,
    String errorFormatText,
    String errorInvalidText,
    String errorInvalidRangeText,
    String fieldStartHintText,
    String fieldEndHintText,
    String fieldStartLabelText,
    String fieldEndLabelText,
    DateTime firstDate,
    DateTime lastDate,
    DateTime currentDate,
    DatePickerEntryMode initialEntryMode = DatePickerEntryMode.calendar,
    Locale locale,
    TextDirection textDirection,
    RouteSettings routeSettings,
  }) : super(
          key: key,
          formControl: formControl,
          formControlName: formControlName,
          validationMessages: validationMessages,
          builder: (ReactiveFormFieldState<dynamic> field) {
            Widget suffixIcon = decoration?.suffixIcon;
            final isEmptyValue =
                field.value == null || field.value.toString().isEmpty;

            if (showClearIcon && !isEmptyValue) {
              suffixIcon = InkWell(
                borderRadius: BorderRadius.circular(25),
                child: clearIcon,
                onTap: () => field.didChange(null),
              );
            }

            final InputDecoration effectiveDecoration =
                (decoration ?? const InputDecoration())
                    .applyDefaults(Theme.of(field.context).inputDecorationTheme)
                    .copyWith(suffixIcon: suffixIcon);

            DateTimeRangeValueAccessor effectiveValueAccessor = valueAccessor;

            if (effectiveValueAccessor == null) {
              effectiveValueAccessor = DateTimeRangeValueAccessor();
            }

            final effectiveLastDate = lastDate ?? DateTime(2100);

            return IgnorePointer(
              ignoring: !field.control.enabled,
              child: GestureDetector(
                onTap: () async {
                  final dateRange = await showDateRangePicker(
                    context: field.context,
                    initialDateRange: field.control.value as DateTimeRange,
                    firstDate: firstDate ?? DateTime(1900),
                    lastDate: effectiveLastDate,
                    currentDate: currentDate,
                    initialEntryMode: initialEntryMode,
                    helpText: helpText,
                    cancelText: cancelText,
                    confirmText: confirmText,
                    saveText: saveText,
                    errorFormatText: errorFormatText,
                    errorInvalidText: errorInvalidText,
                    errorInvalidRangeText: errorInvalidRangeText,
                    fieldStartHintText: fieldStartHintText,
                    fieldEndHintText: fieldEndHintText,
                    fieldStartLabelText: fieldStartLabelText,
                    fieldEndLabelText: fieldEndLabelText,
                    locale: locale,
                    useRootNavigator: useRootNavigator,
                    routeSettings: routeSettings,
                    textDirection: textDirection,
                    builder: builder,
                  );

                  field.control.markAsTouched();
                  field.didChange(dateRange);
                },
                child: InputDecorator(
                  decoration: effectiveDecoration.copyWith(
                    errorText: field.errorText,
                    enabled: field.control.enabled,
                  ),
                  isEmpty: isEmptyValue && effectiveDecoration.hintText == null,
                  child: Text(
                    effectiveValueAccessor
                        .modelToViewValue(field.value as DateTimeRange)
                        .toString(),
                    style: Theme.of(field.context)
                        .textTheme
                        .subtitle1
                        .merge(style),
                  ),
                ),
              ),
            );
          },
        );
}