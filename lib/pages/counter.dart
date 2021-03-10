import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<int> {
  /* 
  O Cubit tem a responsabilidade de gerenciar o estado do nosso contador.
  - O estado é um int nesse caso!
  - Aqui vamos gerenciar esse estado (a contagem do contador, que é um int).
  */
  CounterCubit() : super(0);

  void increment() => emit(state + 1);
  void decrement() => emit(state - 1);
}

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        /*
      * O BlocProvider é responsável por juntar o cubit (que é o gerenciador do meu estado) com a view!
      * Dessa forma, ele provê acesso ao cubit para os filhos. Com isso, conseguimos ler/mudar os estados.
      */
        create: (_) => CounterCubit(), // O parametro (_) é o contexto.
        child: CounterView());
  }
}

class CounterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Contador")),
      body: Center(
        /* Aqui poderiamos acessar o estado diretamente, exemplo: context.watch<CounterCubit>().state 
        * Mas usando o BlocBuilder temos a notificação que veio do método emit de dentro do cubit. 
        * E ele redesenha apenas esse Widget!  
        * Devemos usar o BlocBuilder apenas quando queremos redesenhar o componente baseado em algum evento.
        */
        child: BlocBuilder<CounterCubit, int>(builder: (context, state) {
          return Text(
            "$state",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          );
        }),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: const Icon(Icons.add),
            /*
             * Já que o BlocProvider proveu pra gente o Cubit (que gerencia o estado), 
             * temos acesso a esse gerenciamento de estados pelo contexto!
            */
            onPressed: () => context.read<CounterCubit>().increment(),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            child: const Icon(Icons.remove),
            onPressed: () => context.read<CounterCubit>().decrement(),
          )
        ],
      ),
    );
  }
}
