abstract class StringValidator {
  bool isValid(String value);
  bool isValidEmail(String email);
  bool isValidPassword(String password);
}

class NotEmptyStringValidator implements StringValidator {
  @override
  bool isValid(String value) {
    if (value == null) {
      return false;
    }
    return value.isNotEmpty;
  }

  final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );
  final RegExp _passwordRegExp = RegExp(
    r'^.{4,8}$',
  );

  @override
  bool isValidEmail(String email) {
    return _emailRegExp.hasMatch(email);
  }

  bool isValidPassword(String password) {
    return _passwordRegExp.hasMatch(password);
  }
}

// this class is uses as Mixin
class EmailAndPasswordValidators {
  final StringValidator emailValidator = NotEmptyStringValidator();
  final StringValidator passwordValidator = NotEmptyStringValidator();
  final StringValidator confirmPasswordValidator = NotEmptyStringValidator();

  final String invalidEmailErrorText = 'Email can\'t be empty';
  final String invalidPasswordErrorText = 'Email can\'t be empty';
}
