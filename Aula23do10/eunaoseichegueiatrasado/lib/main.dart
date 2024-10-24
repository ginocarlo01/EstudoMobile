import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/auth_bloc.dart';

import 'bloc/manage_bloc.dart';

import 'view/add_note.dart';
import 'view/list_note.dart';
import 'view/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();// soh vai passar dessa linha se tiver tudo importado
  await Firebase.initializeApp(options: const FirebaseOptions(
  apiKey: "AIzaSyDnQOz6YNYSyDBFA_M96J_srZlU8BBLcMU",
  authDomain: "si700s2.firebaseapp.com",
  databaseURL: "https://si700s2-default-rtdb.firebaseio.com",
  projectId: "si700s2",
  storageBucket: "si700s2.appspot.com",
  messagingSenderId: "261110992626",
  appId: "1:261110992626:web:1370df521db41078694a6b"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return ManageBloc(InsertState(noteList: []))
              ..add(
                GetNoteListEvent(),
              );
          },
        ),
        BlocProvider(
          create: (context) {
            return AuthBloc();
          },
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const Wrapper(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const Center(child: ListNoteScreen()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          BlocProvider.of<ManageBloc>(context).add(UpdateCancel());
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddNoteScreen()));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
