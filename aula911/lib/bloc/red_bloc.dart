import 'package:flutter_bloc/flutter_bloc.dart';


//flutter pub add flutter_bloc

class RedBloc extends Bloc<RedEvent, RedState>{
  RedBloc(super.initialState){

  on<SemRed>((event, emit) => emit(RedState(amount: 0)));
  on<PoucoRed>((event, emit) => emit(RedState(amount: 50)));
  on<NormalRed>((event, emit) => emit(RedState(amount: 150)));
  on<MuitoRed>((event, emit) => emit(RedState(amount: 255)));
  }
}

abstract class RedEvent{}

//Definindo eventos
class MuitoRed extends RedEvent {}
class NormalRed extends RedEvent {}
class PoucoRed extends RedEvent {}
class SemRed extends RedEvent {}

class RedState{
  int amount;

  RedState({required this.amount});
}