import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

/// A utility class that provides material form validators
///
/// ```dart
/// Widget build(BuildContext context) {
///   return Form(
///     key: _formKey,
///     child: TextFormField(
///       key: const ValueKey("login#email"),
///       controller: _emailController,
///       validator: FormValidation.multi([
///         FormValidation.requried("The Email is required"),
///         FormValidation.email("Please use a valid email"),
///       ]),
///       decoration: const InputDecoration(hintText: "Email"),
///     ),
///   );
/// }
/// ```
class FormValidation {
  /// Create a form validator that marks a TextField as required
  ///
  /// The form will display [errorMessage] in case the value
  static FormFieldValidator<String> requried(String errorMessage) {
    return (String? value) {
      if (value == null || value.isEmpty) return errorMessage;
      return null;
    };
  }

  /// Create a min length validator
  ///
  /// If the TextField's text length is less than [minLength]
  /// Then the form will display [errorMessage]
  static FormFieldValidator<String> min(
    String errorMessage, {
    required int minLength,
  }) {
    return (String? value) {
      if (value == null || value.isEmpty || value.length < minLength) return errorMessage;
      return null;
    };
  }

  /// Create an email validator
  ///
  /// If the value of the TextField is not an email
  /// the form will display [errorMessage]
  static FormFieldValidator<String> email(String errorMessage) {
    return (String? value) {
      if (value == null || !EmailValidator.validate(value)) return errorMessage;
      return null;
    };
  }

  /// Creates an exact value validator
  ///
  /// If the Value of the TextField is not equal to [text] or [controller.text]
  /// The form will display [error]
  ///
  /// 💡 This one is useful for confirmation inputs like *Password Confirmation*
  static FormFieldValidator<String> equals({
    required String error,
    String? text,
    TextEditingController? controller,
  }) {
    assert(
      text != null || controller != null,
      "You should provide either a text value or a ref to a TextEditingController",
    );
    return (String? value) {
      if (text != null && value != text) return error;
      if (controller != null && controller.text != value) return error;
      return null;
    };
  }

  /// This method combines multiple [validators] into a single form validator
  ///
  /// ```dart
  ///
  /// validator: FormValidation.multi([
  ///   FormValidation.requried("The Email is required"),
  ///   FormValidation.email("Please use a valid email"),
  /// ]);
  /// ```
  static FormFieldValidator<String> multi(List<FormFieldValidator<String>> validators) {
    return (String? value) {
      // List<String> errors = [];
      for (var validator in validators) {
        String? error = validator(value);
        if (error != null) {
          return error;
          // errors.add(error);
        }
      }
      // if (errors.isNotEmpty) return errors.join("\n");
      return null;
    };
  }
}
