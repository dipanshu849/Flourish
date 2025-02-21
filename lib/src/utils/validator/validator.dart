class Validator {
  /// Checks if the given [value] is a valid email address
  ///
  /// Uses a very strict regular expression to validate the email address.
  /// The regular expression is taken from the [W3C](https://www.w3.org/TR/html5/forms.html#valid-e-mail-address)
  /// and matches the [RFC 5322](https://tools.ietf.org/html/rfc5322#section-3.4.1) specification.
  ///
  /// Returns `null` if the email address is valid, otherwise returns an error message.
  static String? validateEmail(String value) {
    const pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";
    final RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  static String? validatePassword(String value) {
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    if (value.isEmpty) {
      return 'Password cannot be empty';
    }

    // LATER ADD MORE CHECKS
    return null;
  }
}
