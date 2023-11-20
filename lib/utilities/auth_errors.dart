String checkLoginAuthError({required e}) {
  String error = e.toString();
  if (error ==
      '[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.') {
    return 'User is not found';
  } else if (error ==
      '[firebase_auth/wrong-password] The password is invalid or the user does not have a password.') {
    return 'Password is incorrect';
  } else if (error ==
      '[firebase_auth/invalid-email] The email address is badly formatted.') {
    return 'Looks like your email is invalid.';
  } else if (error ==
      '[firebase_auth/network-request-failed] A network error (such as timeout, interrupted connection or unreachable host) has occurred.') {
    return 'Internet unavailable. Please connect your mobile to a internet connection';
  } else {
    print(error);
    return error;
  }
}

String checkRegisterAuthError({required e}) {
  String error = e.toString();
  if (error ==
      '[firebase_auth/email-already-in-use] The email address is already in use by another account.') {
    return 'Email already in use, Login instead?';
  } else if (error ==
      '[firebase_auth/network-request-failed] A network error (such as timeout, interrupted connection or unreachable host) has occurred.') {
    return 'Internet unavailable. Please connect your mobile to a internet connection';
  } else {
    return error;
  }
}
