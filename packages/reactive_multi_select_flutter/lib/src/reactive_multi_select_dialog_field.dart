import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// A [ReactiveMultiSelectDialogField] that contains a [MultiSelectDialogField].
///
/// This is a convenience widget that wraps a [MultiSelectDialogField] widget in a
/// [ReactiveMultiSelectDialogField].
///
/// A [ReactiveForm] ancestor is required.
///
class ReactiveMultiSelectDialogField<T, V>
    extends ReactiveFormField<List<T>, List<V>> {
  /// Creates a [ReactiveMultiSelectDialogField] that contains a [MultiSelectDialogField].
  ///
  /// Can optionally provide a [formControl] to bind this widget to a control.
  ///
  /// Can optionally provide a [formControlName] to bind this ReactiveFormField
  /// to a [FormControl].
  ///
  /// Must provide one of the arguments [formControl] or a [formControlName],
  /// but not both at the same time.
  ///
  /// Can optionally provide a [validationMessages] argument to customize a
  /// message for different kinds of validation errors.
  ///
  /// Can optionally provide a [valueAccessor] to set a custom value accessors.
  /// See [ControlValueAccessor].
  ///
  /// Can optionally provide a [showErrors] function to customize when to show
  /// validation messages. Reactive Widgets make validation messages visible
  /// when the control is INVALID and TOUCHED, this behavior can be customized
  /// in the [showErrors] function.
  ///
  /// ### Example:
  /// Binds a text field.
  /// ```
  /// final form = fb.group({'email': Validators.required});
  ///
  /// ReactiveMultiSelectDialogField(
  ///   formControlName: 'email',
  /// ),
  ///
  /// ```
  ///
  /// Binds a text field directly with a *FormControl*.
  /// ```
  /// final form = fb.group({'email': Validators.required});
  ///
  /// ReactiveMultiSelectDialogField(
  ///   formControl: form.control('email'),
  /// ),
  ///
  /// ```
  ///
  /// Customize validation messages
  /// ```dart
  /// ReactiveMultiSelectDialogField(
  ///   formControlName: 'email',
  ///   validationMessages: {
  ///     ValidationMessage.required: 'The email must not be empty',
  ///     ValidationMessage.email: 'The email must be a valid email',
  ///   }
  /// ),
  /// ```
  ///
  /// Customize when to show up validation messages.
  /// ```dart
  /// ReactiveMultiSelectDialogField(
  ///   formControlName: 'email',
  ///   showErrors: (control) => control.invalid && control.touched && control.dirty,
  /// ),
  /// ```
  ///
  /// For documentation about the various parameters, see the [MultiSelectDialogField] class
  /// and [MultiSelectDialogField], the constructor.
  ReactiveMultiSelectDialogField({
    Key? key,
    GlobalKey<FormFieldState>? widgetKey,
    String? formControlName,
    FormControl<List<T>>? formControl,
    Map<String, ValidationMessageFunction>? validationMessages,
    ControlValueAccessor<List<T>, List<V>>? valueAccessor,
    ShowErrorsFunction? showErrors,

    //////////////////////////////////////////////////////////////////////////
    Widget? title,
    required List<MultiSelectItem<V>> items,
    void Function(List<V>)? onSelectionChanged,
    MultiSelectChipDisplay<V>? chipDisplay,
    bool searchable = false,
    Text? confirmText,
    Text? cancelText,
    Color? barrierColor,
    Color? selectedColor,
    double? dialogHeight,
    double? dialogWidth,
    String? searchHint,
    Color Function(V)? colorator,
    Color? backgroundColor,
    Color? unselectedColor,
    Icon? searchIcon,
    Icon? closeSearchIcon,
    TextStyle? itemsTextStyle,
    TextStyle? selectedItemsTextStyle,
    TextStyle? searchTextStyle,
    TextStyle? searchHintStyle,
    bool separateSelectedItems = false,
    Color? checkColor,
    bool isDismissible = false,
    BoxDecoration? decoration,
    Text? buttonText,
    Icon? buttonIcon,
    MultiSelectListType? listType,
    InputDecoration inputDecoration = const InputDecoration(
      border: InputBorder.none,
      contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      isDense: true,
      isCollapsed: true,
    ),
  }) : super(
          key: key,
          formControl: formControl,
          formControlName: formControlName,
          valueAccessor: valueAccessor,
          validationMessages: validationMessages,
          showErrors: showErrors,
          builder: (field) {
            final effectiveDecoration = inputDecoration
                .applyDefaults(Theme.of(field.context).inputDecorationTheme);

            return InputDecorator(
              decoration: effectiveDecoration.copyWith(
                errorText: field.errorText,
                enabled: field.control.enabled,
              ),
              child: MultiSelectDialogField<V>(
                key: widgetKey,
                items: items,
                onConfirm: field.didChange,
                title: title,
                buttonText: buttonText,
                buttonIcon: buttonIcon,
                listType: listType,
                decoration: decoration,
                onSelectionChanged: onSelectionChanged,
                chipDisplay: chipDisplay,
                searchable: searchable,
                confirmText: confirmText,
                cancelText: cancelText,
                barrierColor: barrierColor,
                selectedColor: selectedColor,
                searchHint: searchHint,
                dialogHeight: dialogHeight,
                dialogWidth: dialogWidth,
                colorator: colorator,
                backgroundColor: backgroundColor,
                unselectedColor: unselectedColor,
                searchIcon: searchIcon,
                closeSearchIcon: closeSearchIcon,
                itemsTextStyle: itemsTextStyle,
                searchTextStyle: searchTextStyle,
                searchHintStyle: searchHintStyle,
                selectedItemsTextStyle: selectedItemsTextStyle,
                separateSelectedItems: separateSelectedItems,
                checkColor: checkColor,
                isDismissible: isDismissible,
                initialValue: field.value ?? [],
              ),
            );
          },
        );
}
