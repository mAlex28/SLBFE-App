class AuthRelatedExceptions implements Exception {
  const AuthRelatedExceptions();
}

class CouldNotSignin extends AuthRelatedExceptions {}

class CouldNotSignup extends AuthRelatedExceptions {}
