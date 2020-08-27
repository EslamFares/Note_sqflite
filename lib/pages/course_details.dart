import 'package:flutter/material.dart';
import 'package:sql_flutter/model/course.dart';

// ignore: must_be_immutable
class CourseDetails extends StatefulWidget {
  Course course;
  CourseDetails(this.course);

  @override
  _CourseDetailsState createState() => _CourseDetailsState();
}

class _CourseDetailsState extends State<CourseDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Note'),
      ),
      body: Column(
        children: <Widget>[
          TextFormField(
            style: TextStyle(fontSize: 25),
            decoration: InputDecoration(
                hintText: ' Title . . .',
                border: InputBorder.none,
                hintStyle: TextStyle(fontSize: 20)),
            onChanged: (value) {
              // setState(() {
              //   course.name = value;
              // });
            },
          ),
        ],
      ),
    );
  }
}
