import 'package:flutter/material.dart';
import 'dart:convert';

void main() {
  runApp(Home());
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Venus Hotel'))
        ),
        backgroundColor: Colors.grey,
        body: First(),
      ),
    );
  }
}

double w;
var rooms = ["FREE","FREE","FREE","FREE","FREE","FREE","FREE","FREE","FREE","FREE"];
var name = ["none","none","none","none","none","none","none","none","none","none"];

class First extends StatefulWidget {
  @override
  _FirstState createState() => _FirstState();
}

class _FirstState extends State<First> {
  int arrival = 0;
  int rooms_available = 10;
  int temp;

  Future<String> inDialog(BuildContext context) {
    TextEditingController customcontroller = TextEditingController();

    return showDialog(context: context, barrierDismissible: false ,builder: (context) {
      return AlertDialog(
        title: Text('Enter name and room no \n(Eg. Ron 2)'),
        content: TextField(
          controller: customcontroller
        ),
        actions: <Widget>[
          MaterialButton(
            elevation: 5.0,
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop(customcontroller.text.toString());
            },
          )
        ],
      );
    });
  }

  Future<String> outDialog(BuildContext context) {
    TextEditingController customcontroller = TextEditingController();

    return showDialog(context: context, barrierDismissible: false ,builder: (context) {
      return AlertDialog(
        title: Text('Enter room no'),
        content: TextField(
            controller: customcontroller
        ),
        actions: <Widget>[
          MaterialButton(
            elevation: 5.0,
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop(customcontroller.text.toString());
            },
          )
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {

    final h = MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.top -
              kToolbarHeight;
    w = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(height: h * 0.05,),
          Container(
            height: h * 0.2,
            width: w * 0.8,
            child: Row(
              children: <Widget>[
                SizedBox(width: w * 0.05),
                Text(
                  'ARRIVALS: $arrival',
                  style: TextStyle(
                      fontSize: w * 0.07,
                      fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(width: w * 0.05,),
                Column(
                  children: <Widget>[
                    SizedBox(
                      height: h * 0.03,
                    ),
                    RaisedButton(
                      onPressed: () {
                        inDialog(context).then((onValue) {
                          List<String> s = onValue.split(' ');
                          temp = int.parse(s[1]);
                          rooms[temp-1] = "OCCUPIED";
                          name[temp-1] = s[0];
                        });
                        setState(() {
                          arrival++;
                          rooms_available--;
                        });
                      },
                      color: Colors.green,
                      child: Text(
                        '+',
                        style: TextStyle(
                            fontSize: w * 0.07,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),

                    RaisedButton(
                      onPressed: () {
                        outDialog(context).then((onValue) {
                          temp = int.parse(onValue);
                          rooms[temp-1] = "FREE";
                          name[temp-1] = "none";
                        });
                        setState(() {
                          arrival--;
                          rooms_available++;
                        });
                      },
                      color: Colors.red,
                      child: Text(
                        '-',
                        style: TextStyle(
                            fontSize: w * 0.07,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    )
                  ],

                ),

              ],
            ),
          ),
          SizedBox(height: h * 0.05,),
          Container(
            width: w * 1,
            child: Row(
              children: <Widget>[
                SizedBox(width: w * 0.1,),
                Text(
                  'ROOMS AVAILABLE: $rooms_available',
                  style: TextStyle(
                      fontSize: w * 0.07,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: h * 0.1,),
          /*RaisedButton(
              onPressed: () {},
              color: Colors.amber,
              child: Text(
                'MANAGE ROOMS',
                textScaleFactor: 2.0,
              )
          ),*/
          //SizedBox(height: 30.0,),
          RaisedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Rooms()),
                );
              },
              color: Colors.green[800],
              child: Text(
                'ROOM STATUS',
                style: TextStyle(
                    fontSize: w * 0.07,
                    fontWeight: FontWeight.bold
                ),
              )
          ),
          SizedBox(height: h * 0.2,),
          Row(
            children: <Widget>[
              SizedBox(width: w * 0.1,),
              FlatButton(
                  color: Colors.white,
                  onPressed: () {},
                  child: Text(
                    'UPDATE',
                    style: TextStyle(
                        fontSize: w * 0.07,
                        fontWeight: FontWeight.bold
                    ),
                  )
              ),
              SizedBox(width: w * 0.2,),
              FlatButton(
                  color: Colors.white,
                  onPressed: () {
                  	exit(0);
                  },
                  child: Text(
                    'EXIT',
                    style: TextStyle(
                        fontSize: w * 0.07,
                        fontWeight: FontWeight.bold
                    ),
                  )
              ),
            ],
          ),
        ],
      ),
    );
  }
}
  
//Rooms
class Rooms extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: roomlist(),
    );
  }
}

//Listview for Rooms
Widget roomlist()  {
  var listview = ListView(
    children: <Widget>[
      ListTile(
        contentPadding: EdgeInsets.only(top: 20.0, left: w * 0.1),
        title: Text('Room 1: ${rooms[0]}',
          style: TextStyle(
              fontSize: w * 0.07,
              fontWeight: FontWeight.bold
          ),
        ),
        subtitle: Text('In: ${name[0]}',
          style: TextStyle(
            fontSize: w * 0.07,
          ),
        ),
      ),
      Divider(color: Colors.black,
        thickness: 2.0,
      ),
      ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: w * 0.1),
        title: Text(
            'Room 2: ${rooms[1]}',
          style: TextStyle(
              fontSize: w * 0.07,
              fontWeight: FontWeight.bold
          ),
        ),
        subtitle: Text('In: ${name[1]}',
          style: TextStyle(
            fontSize: w * 0.07,
          ),
        ),
      ),
      Divider(color: Colors.black,
        thickness: 2.0,
      ),
      ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: w * 0.1),
        title: Text(
          'Room 3: ${rooms[2]}',
          style: TextStyle(
              fontSize: w * 0.07,
              fontWeight: FontWeight.bold
          ),
        ),
        subtitle: Text('In: ${name[2]}',
          style: TextStyle(
            fontSize: w * 0.07,
          ),
        ),
      ),
      Divider(color: Colors.black,
        thickness: 2.0,
      ),
      ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: w * 0.1),
        title: Text(
          'Room 4: ${rooms[3]}',
          style: TextStyle(
              fontSize: w * 0.07,
              fontWeight: FontWeight.bold
          ),
        ),
        subtitle: Text('In: ${name[3]}',
          style: TextStyle(
            fontSize: w * 0.07,
          ),
        ),
      ),
      Divider(color: Colors.black,
        thickness: 2.0,
      ),
      ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: w * 0.1),
        title: Text(
          'Room 5: ${rooms[4]}',
          style: TextStyle(
              fontSize: w * 0.07,
              fontWeight: FontWeight.bold
          ),
        ),
        subtitle: Text('In: ${name[4]}',
          style: TextStyle(
            fontSize: w * 0.07,
          ),
        ),
      ),
      Divider(color: Colors.black,
        thickness: 2.0,
      ),
      ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: w * 0.1),
        title: Text(
          'Room 6: ${rooms[5]}',
          style: TextStyle(
              fontSize: w * 0.07,
              fontWeight: FontWeight.bold
          ),
        ),
        subtitle: Text('In: ${name[5]}',
          style: TextStyle(
            fontSize: w * 0.07,
          ),
        ),
      ),
      Divider(color: Colors.black,
        thickness: 2.0,
      ),
      ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: w * 0.1),
        title: Text(
          'Room 7: ${rooms[6]}',
          style: TextStyle(
              fontSize: w * 0.07,
              fontWeight: FontWeight.bold
          ),
        ),
        subtitle: Text('In: ${name[6]}',
          style: TextStyle(
            fontSize: w * 0.07,
          ),
        ),
      ),
      Divider(color: Colors.black,
        thickness: 2.0,
      ),
      ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: w * 0.1),
        title: Text(
          'Room 8: ${rooms[7]}',
          style: TextStyle(
              fontSize: w * 0.07,
              fontWeight: FontWeight.bold
          ),
        ),
        subtitle: Text('In: ${name[7]}',
          style: TextStyle(
            fontSize: w * 0.07,
          ),
        ),
      ),
      Divider(color: Colors.black,
        thickness: 2.0,
      ),
      ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: w * 0.1),
        title: Text(
          'Room 9: ${rooms[8]}',
          style: TextStyle(
              fontSize: w * 0.07,
              fontWeight: FontWeight.bold
          ),
        ),
        subtitle: Text('In: ${name[8]}',
          style: TextStyle(
            fontSize: w * 0.07,
          ),
        ),
      ),
      Divider(color: Colors.black,
        thickness: 2.0,
      ),
      ListTile(
        contentPadding: EdgeInsets.only(left: w * 0.1),
        title: Text(
          'Room 10: ${rooms[9]}',
          style: TextStyle(
              fontSize: w * 0.07,
              fontWeight: FontWeight.bold
          ),
        ),
        subtitle: Text('In: ${name[9]}',
          style: TextStyle(
            fontSize: w * 0.07,
          ),
        ),
      )
    ],
  );

  return listview;
}



