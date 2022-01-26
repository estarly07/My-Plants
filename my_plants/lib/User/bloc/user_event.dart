part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class LoginEvent extends UserEvent {
  final String name;
  final String pass;

  LoginEvent(this.name, this.pass);
}

class RegisterEvent extends UserEvent {
  final String age;
  final String name;
  final String pass;

  RegisterEvent(this.age, this.name, this.pass);
}
