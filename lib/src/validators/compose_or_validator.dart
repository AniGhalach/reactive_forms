import 'package:reactive_forms/reactive_forms.dart';

/// Compose multiple validators into a single function.
///
/// If at least one validator returns 'null' then the compose validator
/// returns 'null', otherwise returns the union of the individual error
/// maps returned by each validator.
class ComposeOrValidator extends Validator {
  final List<ValidatorFunction> validators;

  ComposeOrValidator(this.validators);

  @override
  Map<String, dynamic> validate(AbstractControl<dynamic> control) {
    final composedError = Map<String, dynamic>();

    for (final validator in this.validators) {
      final error = validator(control);
      if (error != null) {
        composedError.addAll(error);
      } else {
        return null;
      }
    }

    return composedError.isEmpty ? null : composedError;
  }
}
