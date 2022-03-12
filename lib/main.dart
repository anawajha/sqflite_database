import 'package:provider/provider.dart';
import 'package:sqlite_database/provider/bottom_nav_bar_provider.dart';
import 'package:sqlite_database/provider/note_provider.dart';
import 'package:sqlite_database/screens/app/add_note_screen.dart';
import 'package:sqlite_database/screens/app/launch_screen.dart';
import 'package:sqlite_database/screens/app/main_screen.dart';
import 'package:sqlite_database/storage/db/db_provider.dart';
import 'package:flutter/material.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DBProvider().initDB();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<NoteProvider>(create: (_) => NoteProvider()),
        ChangeNotifierProvider<BNBProvider>(create: (_) => BNBProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Notes',
        initialRoute: '/launch_screen',
        routes: {
          '/launch_screen' : (context) => LaunchScreen(),
          '/main_screen' : (context) => MainScreen(),
          '/add_note_screen' : (context) => AddNoteScreen(),
        },
      ),
    );
  }
}

