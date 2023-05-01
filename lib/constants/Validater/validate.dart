String? validateEmail(String? formEmail) {
  if (formEmail == null || formEmail.isEmpty)
    return 'E-mail address is required.';

  String pattern = r'\w+@\w+\.\w+';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(formEmail)) return 'Invalid E-mail Address format.';

  return null;
}
String? validatePassword(String? password) {
  if (password == null || password.isEmpty) return 'Password is required.';
  if (password.length < 6) {
    return "password must be grater then 6 characters";
  }

  return null;
}
String? Comfrompassword(String? confrompassword) {
  if (confrompassword == null || confrompassword.isEmpty) {
    return "Confirm Password";
  } else if (validatePassword != Comfrompassword) {
    return ("Password can't same");
  }
  return null;
}
String? validatename(String? formname) {
  if (formname == null || formname.isEmpty) return 'Name is required.';

  return null;
}

String? phonevalidata(String? password) {
  if (password == null || password.isEmpty)
    return 'Phone is required.';
  else if (password.length > 12) {
    return "Phone number must be grater then 12 characters";
  }
}