import 'package:cst2335_summer24/ToDoDatabase.dart';
import 'package:cst2335_summer24/ToDoItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';


import 'package:cached_network_image/cached_network_image.dart';

import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';

import 'ToDoDAO.dart'; // kIsWeb


void main() {
  // Or, use a predicate getter.
  // if (Platform.isMacOS) {
  //   print('is a Mac');
  // } else {
  //   print('is not a Mac');
  // }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //list all the pages:
      routes: {
        //Keys:         //values
        '/pageOne': (context) => MyHomePage(title: 'Week 9 Lecture: SQL Floor'),
        // '/pageTwo'  :    (context) { return OtherPage(); }

      },
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/pageOne',
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

  late TextEditingController _controller; // late means initialize later, but not null
  var listObjects = <String>[];

  String? selectedItem = null; // Either a string or null

  @override
  void initState() {
    // initialize object, onloaded in HTML
    super.initState();

    _controller = TextEditingController();
  }

  @override
  void dispose() {
    //unloading the page
    super.dispose();
    _controller.dispose();
  }

  Widget ToDoList() {
    return Column( mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(children: [
          ElevatedButton(child: Text("Add this"), onPressed: () {
            setState(() {
              var whatWasTyped = _controller.value.text;
              listObjects.add(whatWasTyped); //insert to ArrayList
                // clear the text
                _controller.text = "";
            },);
          },),
            // SizedBox(width: 20),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 10),),
          Expanded(child: TextField(controller: _controller,
              decoration: InputDecoration(
                hintText: "Type here",
                border: OutlineInputBorder(),
                labelText: "Add message"
              ),),
            ),
        ],),
        if(listObjects.isEmpty)
          Column( children: [
            SizedBox(height: 20), // Add some space above the Text
            Text('There are no items in the List.'),
            ],)
        else
          Expanded(  // makes the child as large as possible, taking up whole screen
            child:
              ListView.builder(
                itemCount: listObjects.length,// length of array as row number
                itemBuilder: (context, rowNumber) {
                  return
                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: 100.0), // leftside
                        child:Text(
                          "Row ${rowNumber} : " + listObjects[rowNumber],
                          style:TextStyle(fontSize: 20),
                        ),
                      ),
                      onTap:() {
                        setState(() {
                          selectedItem = listObjects[rowNumber];  // make it selected
                        });
                      },
                      onLongPress: (){
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Confirm Deletion'),
                              content: Text('Are you sure you want to delete Row ${rowNumber}?'),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('No'),
                                  onPressed: () {
                                    Navigator.of(context).pop(); // Close the dialog
                                  },
                                ),
                                TextButton(
                                  child: Text('Yes'),
                                  onPressed: () {
                                    var snackBar = SnackBar(
                                        content: Text('Row: ${rowNumber} you tapped has been deleted.'),
                                        duration: Duration(seconds: 1),
                                      );
                                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                    setState(() {
                                        listObjects.removeAt(rowNumber); // Remove the object
                                    });
                                    Navigator.of(context).pop(); // Close the dialog
                                  },
                                ),
                              ],
                            );
                        },);
                    });
                }),
          )
        ]);
    }

    Widget DetailsPage(){
      if (selectedItem == null)
        return Text("");  // so this compiles, nothing shows
      else
        return Column(children: [ Text("Selected item = ${selectedItem}"),
                      // OutlinedButton(onPressed: () {
                      //   setState(() { selectedItem=null;  // redraw the GUI
                      //   });
                      // }, child: Text("Go back")) // line 171-174 replaced by 222-224

        ]);
    }

    Widget responsiveLayout(){
      var size = MediaQuery.of(context).size;
      var height = size.height;
      var width = size.width;

      //landscape or tablet layout
      if ((width>height) && (width > 720)) //screen is wide enough (1920 * 1024
      //room to put list on left side:
        {
          return Row(children: [
            Expanded(flex: 1, child: ToDoList()),  // takes 1/(1+3) of available width
            Expanded(flex: 3, child: DetailsPage()),    // takes 3/(1+3) of available width
          ]);
      }
      else //portrait
        {
          if(selectedItem == null)
            return ToDoList();
          else
            return DetailsPage();
      }
    }


    @override
    Widget build(BuildContext context) {

    // var size = MediaQuery.of(context).size;
    // var height = size.height;
    // var width = size.width;
    //
    // var myBody = ((width>height) && (width > 720))? //screen is wide enough (1920 * 1024
    //   //room to put list on left side:
    //     Row(children: [ Expanded(flex: 1, child: ToDoList()),
    //                     Expanded(flex: 3, child: DetailsPage()) ])
    // : // portrait
    //     ToDoList();  // List is the whole page

      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
          actions: [
            OutlinedButton(onPressed: (){
              setState(() {selectedItem = null; });
            }, child: Text("Clear"))
          ]
        ),
        // body:  myBody  // if landscape mode:
        body: responsiveLayout(),
        bottomNavigationBar: BottomNavigationBar(items: [
          BottomNavigationBarItem(icon: Icon(Icons.camera), label: 'Camera'),
          BottomNavigationBarItem(icon: Icon(Icons.add_call), label: 'Phone'),

        ], onTap: (btnIndex){ },),
      );
    }

    //This function gets run when you click the button
    void buttonClicked(){

    }


    }

// flutter pub add floor_generator
// flutter pub add -d build_runner

// flutter pub get  // after modified the pubspec.yaml

// <uses-permission android:name="android.permission.INTERNET" />  // add to android/app/src/main/AndroidMainfest.xml

