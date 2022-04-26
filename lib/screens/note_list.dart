import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/models/note.dart';
import 'package:todo_app/utils/database_helper.dart';
import 'package:todo_app/screens/note_detail.dart';
import 'package:sqflite/sqflite.dart';


class NoteList extends StatefulWidget {

	@override
  State<StatefulWidget> createState() {

    return NoteListState();
  }
}

class NoteListState extends State<NoteList> {

	DatabaseHelper databaseHelper = DatabaseHelper();
	List<Note> noteList;
	int count = 0;
	//String now = DateFormat.yMMMd().format(DateTime.now());
	//DateTime now = DateTime.now();


	@override
  Widget build(BuildContext context) {

		if (noteList == null) {
			noteList = List<Note>();
			updateListView();
		}

    return Scaffold(

	    appBar: AppBar(
		    title: Text('Notes '),
	    ),

	    body: getNoteListView(),

	    floatingActionButton: FloatingActionButton(
		    onPressed: () {
		      debugPrint('FAB clicked');
		      navigateToDetail(Note('', '', 2, ''), 'Add Note');
		    },

		    tooltip: 'Add Note',

		    child: Icon(Icons.add),

	    ),
    );
  }

  ListView getNoteListView() {

// ignore: deprecated_member_use
		TextStyle titleStyle = Theme.of(context).textTheme.bodyText2;

		return ListView.builder(
			itemCount: count,
			itemBuilder: (BuildContext context, int position) {
				return Card(
					//color: Colors.white,
					elevation: 3.0,
					child: ListTile(

						leading: CircleAvatar( //GestureDetector( - for date test
							backgroundColor: getPriorityColor(this.noteList[position].priority,this.noteList[position].date1),
							child: getPriorityIcon(this.noteList[position].priority),
							// onTap: () {
							// 	_late(context, noteList[position]); //(this.noteList[position].date1);
							// 	_toLate(this.noteList[position].date1);
							// 	_toLate1(this.noteList[position].date1);
							// },
						),

						title: Text(this.noteList[position].title, style: titleStyle,),
						//subtitle: Text(this.noteList[position].date),
						subtitle: Text(this.noteList[position].date1 + ' - ' + this.noteList[position].description), //.substring(0,1) + '...'),

						trailing: GestureDetector(
							child: Icon(Icons.delete, color: Colors.red,),
							onTap: () {
								_delete(context, noteList[position]);
							},
						),
						isThreeLine: true,

						onTap: () {
							debugPrint("ListTile Tapped");
							navigateToDetail(this.noteList[position],'Edit Note');
						},

					),
				);
			},
		);
  }

  // Returns the priority color
	Color getPriorityColor(int priority, var date01) {
		switch (priority) {
			case 1:
				return Colors.red;
				break;
			case 2:
				if (_toLate1(date01) == 1) {
					return Colors.orange;
				}
				else {
					return Colors.yellow;
				}
				break;
			default:
				return Colors.yellow;
		}
	}

	// Returns the priority icon
	Icon getPriorityIcon(int priority) {
		switch (priority) {
			case 1:
				return Icon(Icons.label_important);
				break;
			case 2:
				return Icon(Icons.label_outline);
				break;
			default:
				return Icon(Icons.label_outline);
		}
	}

	void _late(BuildContext context, Note noteList) {
		var now = DateTime.now();
		// debugPrint(DateFormat().format(now)); // This will return date using the default locale
		// debugPrint(DateFormat('yyyy-MM-dd hh:mm:ss').format(now));
		debugPrint(DateFormat('yyyy/MM/dd').format(now));
		// debugPrint(DateFormat.yMMMMd().format(now)); // print long date
		// debugPrint(DateFormat.yMd().format(now)); // print short date
		// debugPrint(DateFormat.jms().format(now)); // print time

		//debugPrint(this.noteList[BuildContext].date1);
		// initializeDateFormatting('es'); // This will initialize Spanish locale
		// debugPrint(DateFormat.yMMMMd('es').format(now)); // print long date in Spanish format
		// debugPrint(DateFormat.yMd('es').format(now)); // print short date in Spanish format
		// debugPrint(DateFormat.jms('es').format(now)); // print time in Spanish format
	}

	void _toLate(String date01) {
		//String result = '';
		debugPrint(date01);
		//return result;
	}

	int _toLate1(var date01) {
		int result = 0;
		var now = DateTime.now();
		var nowTxt = DateFormat('yyyy/MM/dd').format(now);
		var nowParse = DateFormat('yyyy/MM/dd').parse(nowTxt);
		var date01Parse = DateFormat('yyyy/MM/dd').parse(date01);
		var dateDiff = (date01Parse.difference(nowParse));
		if ((date01Parse.isBefore(nowParse)) || (date01Parse == nowParse)) {
			debugPrint(date01);
			debugPrint(nowTxt);
			debugPrint('Date late');
			result = 1;
		}
		return result;
	}


	void _delete(BuildContext context, Note note) async {

		int result = await databaseHelper.deleteNote(note.id);
		if (result != 0) {
			_showSnackBar(context, 'Note Deleted Successfully');
			updateListView();
		}
	}

	void _showSnackBar(BuildContext context, String message) {

		final snackBar = SnackBar(content: Text(message));
		Scaffold.of(context).showSnackBar(snackBar);
		//ScaffoldMessenger.of(context).showSnackBar;
	}

  void navigateToDetail(Note note, String title) async {
	  bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
		  return NoteDetail(note, title);
	  }));

	  if (result == true) {
	  	updateListView();
	  }
  }

  void updateListView() {

		final Future<Database> dbFuture = databaseHelper.initializeDatabase();
		dbFuture.then((database) {

			Future<List<Note>> noteListFuture = databaseHelper.getNoteList();
			noteListFuture.then((noteList) {
				setState(() {
				  this.noteList = noteList;
				  this.count = noteList.length;
				});
			});
		});
  }
}







