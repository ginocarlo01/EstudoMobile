import 'package:aula07_flutter_stream_parte2/provider/counter_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterBloc extends Bloc<CounterEvent, int>{
  CounterBloc() : super(0){

    CounterProvider.helper.stream.listen(
      (event){ //nao emite estado
        if(event){
          add(CounterEvent.increment);
        } else {
          add(CounterEvent.decrement);
        }
      }
    );

    on<CounterEvent>( //soh aqui que tem enter, por isso tem emissao de estado
      (CounterEvent event, Emitteremit){
        switch(event){
          case CounterEvent.increment:
            emit(state + 1);
            break;
          case CounterEvent.decrement:
            emit(state - 1);
            break;
        }
        
      }
    );
  }
}

enum CounterEvent {increment, decrement}