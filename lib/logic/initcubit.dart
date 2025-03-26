library initcubit;

import 'package:malabis_app/logic/init_state.dart';
import 'package:bloc/bloc.dart';
import 'package:malabis_app/logic/repository/initrepository.dart';

class InitCubit extends Cubit<InitState> {
  InitCubit() : super(InitInitial());

  static final InitRepository repository = InitRepository();

  get client => repository.getClient();
}
