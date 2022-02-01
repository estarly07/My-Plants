import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_plants/Plant_local/repository/services/database_service.dart';
import 'package:my_plants/User/model/User.dart';
import 'package:my_plants/Utils/services/services.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  DataBaseService dataBaseService = DataBaseService();

  UserBloc() : super(UserInitial()) {
    on<LoginEvent>((event, emit) async {
      User user = await dataBaseService.login(event.name, event.pass);

      emit(Login(user));
    });
    on<RegisterEvent>((event, emit) async {
      User user = await dataBaseService
          .register(User(user: event.name, pass: event.pass, age: event.age));
      emit(Register(user));
    });
    on<SearchEvent>((event, emit) async {
      emit(Login(await dataBaseService.searchUser(Preferences().id)));
    });
  }
}
