import 'package:flutter/material.dart';
import 'package:sql_flutter/model/course.dart';
import '../dbhelper.dart';
import 'home.dart';

// ignore: must_be_immutable
class NewCourse extends StatefulWidget {
  final bool modifay;
  Course course;
  NewCourse({@required this.modifay, this.course});
  @override
  _NewCourseState createState() => _NewCourseState();
}

class _NewCourseState extends State<NewCourse> {
  TextEditingController noteName = TextEditingController();
  TextEditingController noteContant = TextEditingController();
  TextEditingController notehoure = TextEditingController();
  String name, content;
  String hours;
  int color; //ThemeData.dark().scaffoldBackgroundColor.value;
  int colorSelected; //= 0;
  DbHelper helper;

  saveNote() async {
    Course course = Course({
      'name': name,
      'content': content,
      'hours': hours,
      'color': color,
      'selcolornum': colorSelected,
    });
    // ignore: unused_local_variable
    int id = await helper.createCourse(course);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(),
      ),
      (Route<dynamic> route) => false,
    );
    print('course id is =  $id is added');
  }

  updateNote() {
    var updateNote = Course({
      'id': widget.course.id,
      'name': noteName.text,
      'content': noteContant.text,
      'hours': notehoure.text,
      'color': color,
      'selcolornum': colorSelected,
    });
    helper.upDate(updateNote);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(),
      ),
      (Route<dynamic> route) => false,
    );
  }

  @override
  void initState() {
    super.initState();
    helper = DbHelper();
    noteName.text = widget.modifay ? widget.course.name : null;
    noteContant.text = widget.modifay ? widget.course.content : null;
    notehoure.text = widget.modifay ? widget.course.hours : null;
    colorSelected = widget.modifay ? widget.course.selcolornum : 0;
    color = widget.modifay
        ? widget.course.color
        : ThemeData.dark().scaffoldBackgroundColor.value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(color),
      appBar: AppBar(
        title: widget.modifay ? Text('Update Note') : Text('New Note'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              widget.modifay ? Icons.check : Icons.save,
              size: 25,
            ),
            onPressed: widget.modifay ? updateNote : saveNote,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height + 100,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Form(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: TextFormField(
                        controller: widget.modifay ? noteName : null,
                        style: TextStyle(fontSize: 25),
                        decoration: InputDecoration(
                            hintText: ' Title . . .',
                            border: InputBorder.none,
                            hintStyle: TextStyle(fontSize: 20)),
                        onChanged: (value) {
                          setState(() {
                            name = value;
                          });
                        },
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: widget.modifay ? noteContant : null,
                    keyboardType: TextInputType.multiline,
                    minLines: 25,
                    maxLines: 30,
                    decoration: InputDecoration(
                      // counterText: widget.modifay ? widget.course.content : null,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.amber,
                        width: 2,
                      )),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 3,
                          )),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 3,
                          )),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 3,
                          )),
                      hintText: 'Content . . .',
                    ),
                    onChanged: (value) {
                      setState(() {
                        content = value;
                      });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width - 110,
                          height: 50,
                          decoration: BoxDecoration(
                              color: colorSelected == 3
                                  ? ThemeData.dark().scaffoldBackgroundColor
                                  : ThemeData.dark().cardColor,
                              borderRadius: BorderRadius.circular(15)),
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: <Widget>[
                              colorCircle(
                                  colorselected:
                                      ThemeData.dark().scaffoldBackgroundColor,
                                  num: 0),
                              colorCircle(
                                  colorselected: Color(0xff243447), num: 1),
                              colorCircle(
                                  colorselected: Colors.pink.withOpacity(.8),
                                  num: 7),
                              colorCircle(
                                  colorselected: ThemeData.dark().cardColor,
                                  num: 3),
                              colorCircle(colorselected: Colors.teal, num: 6),
                              colorCircle(colorselected: Colors.orange, num: 5),
                              colorCircle(
                                  colorselected: Colors.yellow.withOpacity(.8),
                                  num: 4),
                              colorCircle(colorselected: Colors.green, num: 2),
                              colorCircle(colorselected: Colors.grey, num: 8),
                              colorCircle(
                                  colorselected:
                                      Colors.lightBlue.withOpacity(.6),
                                  num: 9),
                            ],
                          ),
                        ),
                        Container(
                          width: 80,
                          child: TextFormField(
                            controller: widget.modifay ? notehoure : null,
                            maxLength: 5,
                            style: TextStyle(letterSpacing: 2),
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              hintText: 'Status',
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.greenAccent, width: 3)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.greenAccent, width: 3)),
                              disabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.greenAccent, width: 3)),
                            ),
                            onChanged: (value) {
                              setState(() {
                                hours = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  // RaisedButton(child: Text('Save'), onPressed: saveNote)
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: widget.modifay ? updateNote : saveNote,
        tooltip: 'Save Note',
        backgroundColor: Colors.amber,
        child: new Icon(
          widget.modifay ? Icons.check : Icons.save,
          color: Colors.black,
          size: 30,
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

  Widget colorCircle({@required colorselected, @required int num}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: InkWell(
        onTap: () {
          color = colorselected.value;
          setState(() {
            colorSelected = num;
          });
          print(colorSelected);
        },
        child: Container(
          child: colorSelected == num
              ? Center(
                  child: Icon(
                    Icons.check,
                    size: 30,
                    color: Colors.white,
                  ),
                )
              : Center(),
          width: 35,
          height: 35,
          decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                color: Colors.white,
              ),
              color: colorselected,
              shape: BoxShape.circle),
        ),
      ),
    );
  }
}
