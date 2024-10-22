# Aula 18 de setembro

Uso de await, Future.delayed e StreamController

## await:

O que é: Uma palavra-chave usada para esperar a conclusão de uma operação assíncrona, como uma Future.

Exemplo: await Future.delayed(Duration(seconds: 3)); - Espera 3 segundos antes de continuar.

## Future.delayed

O que é: Uma função que cria um Future que é concluído após um atraso especificado.

Exemplo: Future.delayed(Duration(seconds: 3), () => print("Executado após 3 segundos"));

## StreamController

O que é: Uma classe que permite criar e gerenciar um fluxo (Stream) de dados. Pode adicionar dados ao fluxo e controlar quando o fluxo é encerrado.

Exemplo:

StreamController<int> controller = StreamController<int>();
controller.sink.add(1); // Adiciona o valor 1 ao fluxo.
controller.stream.listen((data) => print(data)); // Escuta e imprime os dados do fluxo.
