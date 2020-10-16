import 'package:flutter/material.dart';
import 'blocs/calc_provider.dart';



void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CalcBlocProvider(   /// [BlocProviderでwrap]全体からtreeアクセスすべくhome:
        child: CalcScreen(),   /// f[main_3.dart]t[screen_3.dart]。CalcScreen作成->BlocProvider投入へ全erap
      ),
    );
  }
}



/// f[main_3.dart]t[screen_3.dart]
class CalcScreen extends StatelessWidget {
  /// [--- build() ---]
  @override
  Widget build(BuildContext context) {
    final bloc = CalcBlocProvider.of(context).bloc;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _text(bloc),
            _button(bloc),
          ],
        ),
      ),
    );
  }


  /// [--- sup ---]
  Widget _text(CalcBloc bloc) {
    return StreamBuilder<String>(   /// [StreamBuilder]
      stream: bloc.onAdd,
      builder: (context, snapshot) {   /// [snapshot.dataにデータ格納]
        return Text(
          snapshot.hasData ? snapshot.data : '',   /// バリデ[snapshot.hasData ? TRUE : FALSE,]
          style: const TextStyle(fontSize:36),
        );
      },
    );
  }

  /// [--- sup ---]
  Widget _button(CalcBloc bloc) {
    return StreamBuilder<bool>(   /// [StreamBuilder]
      stream: bloc.onToggle,
      builder: (context, snapshot) {   /// [snapshot.dataにデータ格納]
        return Opacity(
          opacity: snapshot.hasData && snapshot.data ? 1.0 : 0.0,   /// バリデ[hasData かつ snapshot.data ? opacity1 : opacity0,]
          child: RaisedButton(
            child: const Text('Start'),
            onPressed: () => bloc.start.add(null),
          ),
        );
      },
    );
  }
}