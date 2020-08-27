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
  @override
  void initState() {
    super.initState();
    helper = DbHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NOTE'),
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
      body: FutureBuilder(
        future: helper.allCourses(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: Text('Loading  Data . . .'));
          } else {
            return ListView.builder(
              padding: EdgeInsets.only(top: 5),
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                Course course = Course.fromMap(snapshot.data[index]);
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NewCourse(
                                  modifay: true,
                                  course: Course.fromMap(snapshot.data[index]),
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
                            Text(
                                '${course.name == null ? ' ' : course.name}  ${course.selcolornum}',
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
            );
          }
        },
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
