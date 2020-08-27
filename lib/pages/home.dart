import 'package:flutter/material.dart';
import 'package:sql_flutter/dbhelper.dart';
import 'package:sql_flutter/model/course.dart';
import 'package:sql_flutter/widgets/showAlertDialog.dart';
import 'new_course.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DbHelper helper;

  TextEditingController noteSearch = TextEditingController();
  var allNote = [];
  var items = List();
  @override
  void initState() {
    super.initState();
    helper = DbHelper();
    helper.allCourses().then((notes) {
      setState(() {
        allNote = notes;
        items = allNote;
      });
    });
  }

  void filterSearch(String query) async {
    var dummySearchList = allNote;
    if (query.isNotEmpty) {
      var dummyListData = List();
      dummySearchList.forEach((item) {
        var course = Course.fromMap(item);
        if (course.name.toLowerCase().contains(query.toLowerCase()) ||
            course.content.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items = [];
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items = [];
        items = allNote;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Row(
          children: <Widget>[
            Text('NOTE '),
            Icon(
              Icons.event_note,
              color: Colors.amber,
            )
          ],
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.add,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NewCourse(
                              modifay: false,
                            )));
              }),
        ],
      ),
      body: Column(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 15, bottom: 5),
              child: Material(
                shape: StadiumBorder(),
                color: Colors.transparent,
                elevation: 1,
                child: TextField(
                  autofocus: false,
                  onChanged: (value) {
                    setState(() {
                      filterSearch(value);
                    });
                  },
                  controller: noteSearch,
                  decoration: InputDecoration(
                    fillColor: Colors.transparent,
                    filled: true,
                    hintText: 'Search',
                    labelText: 'Search',
                    labelStyle: TextStyle(color: Colors.white),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 2,
                        )),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 2,
                        )),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 2,
                        )),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 2,
                        )),
                  ),
                ),
              )),
          Expanded(
              child: ListView.builder(
            padding: EdgeInsets.only(top: 5),
            itemCount: items.length,
            itemBuilder: (context, index) {
              Course course = Course.fromMap(items[index]);
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NewCourse(
                                modifay: true,
                                course: Course.fromMap(items[index]),
                              )));
                },
                child: Card(
                  color: course.color == null
                      ? ThemeData.dark().cardColor
                      : Color(course.color),
                  elevation: 10,
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  child: ListTile(
                    isThreeLine: true,
                    title: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('${course.name == null ? ' ' : course.name}',
                              style: TextStyle(fontSize: 20)),
                          Text('${course.hours == null ? ' ' : course.hours}',
                              style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                    subtitle: Text(
                        '${course.content == null ? ' ' : course.content.length <= 50 ? course.content : "${course.content.substring(1, 50)}  . . . . . "}'),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        showAlertDialog(
                            context: context,
                            title: 'Delete',
                            subtitle: ' delete note ?',
                            RButtonName: 'OK',
                            RbuttonOnClock: () {
                              setState(() {
                                helper.delete(course.id);
                              });
                              Navigator.pop(context);
                            },
                            LButtonName: 'Cancel',
                            LbuttonOnClock: () {
                              Navigator.pop(context);
                            });
                      },
                    ),
                  ),
                ),
              );
            },
          ))
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NewCourse(
                        modifay: false,
                      )));
        },
        tooltip: 'ADD Note',
        backgroundColor: Colors.amber,
        child: new Icon(
          Icons.note_add,
          size: 30,
          color: Colors.black,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        clipBehavior: Clip.antiAlias,
        shape: CircularNotchedRectangle(),
        child: Material(
          elevation: 20,
          child: Container(
            width: double.infinity,
            height: 50.0,
          ),
          color: Theme.of(context).cardColor,
        ),
      ),
    );
  }
}
