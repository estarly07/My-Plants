part of 'user_bloc.dart';

@immutable
abstract class UserState {
  final User? user;
  UserState(this.user);
}

class UserInitial extends UserState {
  UserInitial() : super(null);
}

class Login extends UserState {
  Login(User? user) : super(user);
}

class Register extends UserState {
  Register(User? user) : super(user);
}
