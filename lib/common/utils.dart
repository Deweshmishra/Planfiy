String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return "Enter email";
  }
  if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
    return "Invalid email";
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return "Enter password";
  }
  return null;
}

String? validateName(String? value) {
  if (value == null || value.isEmpty) {
    return "Enter full name";
  }
  return null;
}


String? validateMobile(String? value) {
  if (value == null || value.isEmpty) {
    return "Enter mobile number";
  }
  return null;
}



