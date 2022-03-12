import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqlite_database/helpers/helpers.dart';
import 'package:sqlite_database/provider/note_provider.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with Helpers {

  @override
  void initState(){
    super.initState();
    Provider.of<NoteProvider>(context,listen: false).read();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Notes',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black
        ),
        actions: [
          IconButton(onPressed: (){
            Navigator.pushNamed(context, '/add_note_screen');
          }, icon: Icon(Icons.note_add_rounded))
        ],
      ),
      body: Consumer<NoteProvider>(
        builder: (context, value, child) {
          if(value.notes.isEmpty){
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Divider(
                  height: 0,
                  thickness: 0,
                  color: Colors.transparent,
                ),
                Icon(Icons.speaker_notes_off_outlined,size: 60,color: Colors.grey,),
                Text('No notes yet.',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),),

              ],
            );
          }else {
            return ListView.builder(
              itemCount: value.notes.length,
              itemBuilder: (context, index) => ListTile(
                leading: Icon(Icons.notes),
                title: Text(value.notes[index].content),
                trailing: IconButton(
                    onPressed: () {
                       deleteNote(value.notes[index].id);
                    },
                    icon: Icon(Icons.delete)),
              ),
            );
          }
        },
      )
    );
  }

  void deleteNote(int id) async {
    bool deleted = await Provider.of<NoteProvider>(context,listen: false).delete(id: id);
    print('Note id : $id');
    showSnackBar(context: context, message: deleted ? 'Deleted successfully' :'Delete failed', error: !deleted);
  }

}
