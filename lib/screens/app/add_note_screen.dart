import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqlite_database/helpers/helpers.dart';
import 'package:sqlite_database/models/note.dart';
import 'package:sqlite_database/provider/note_provider.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({Key? key}) : super(key: key);

  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> with Helpers {

  late TextEditingController _noteController;

  @override
  void initState() {
    super.initState();
    _noteController = TextEditingController();
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<NoteProvider>(create: (_) => NoteProvider(),)
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Add note'),
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: ListView(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
          children: [
            TextField(
              controller: _noteController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.note),
                label: Text('Note'),
                alignLabelWithHint: true,
              ),
            ),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: (){
              creteNote(validate());
            }, child: Text('Add note'),
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 45),
              primary: Colors.blue,
            )),
          ],
        ),
      ),
    );
  }


  bool validate(){
    if(_noteController.text.isEmpty){
      showSnackBar(context: context, message: 'Note is required',error: true);
      return true;
    }
      return false;
  }


  void creteNote(bool isValid) async {
    Note note = Note(content: _noteController.text);
    bool created = await Provider.of<NoteProvider>(context,listen: false).create(note: note);
    showSnackBar(context: context, message: created ? 'Created successfully' : 'Create failed',error: !created);
    if(created) Navigator.pop(context);
  }


}
