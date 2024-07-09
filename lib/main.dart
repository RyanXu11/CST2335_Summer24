import 'package:cst2335_summer24/ToDoDatabase.dart';
import 'package:cst2335_summer24/ToDoItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';


import 'package:cached_network_image/cached_network_image.dart';

import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';

import 'ToDoDAO.dart';  // kIsWeb


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
        '/pageOne'   :   (context) => MyHomePage(title: 'Week 9 Lecture: SQL Floor'),
        // '/pageTwo'  :    (context) { return OtherPage(); }

      },
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute : '/pageOne'  ,
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
  var words = <ToDoItem>[];
  var isChecked = false;
  late TextEditingController _controller; // late means initialize later, but not null
  late TextEditingController _controller2;
  late ToDoDAO myDAO;

  @override
  void initState() {
    // initialize object, onloaded in HTML
    super.initState();

    $FloorToDoDatabase.databaseBuilder('app_database.db').build().then( (database) async {

      myDAO = database.getDao; // now you can query;
      // List<ToDoItem> items = await myDAO.getAllItems();

      myDAO.getAllItems().then ( (listOfItems) {

        setState(() {
          words.addAll( listOfItems ); // add all items from listOfItems into words
        });
      });
    });  // read the database


    _controller = TextEditingController();
    _controller2 = TextEditingController();

  }

  @override
  void dispose() { //unloading the page
    super.dispose();
    _controller.dispose();
    _controller2.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Theme.of(context).colorScheme.inversePrimary,title: Text(widget.title)),
      body: Center(
        child:
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              // Flexible(child: // or Expanded
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(child: Text("Add"), onPressed: (){
                    setState(() {
                      var newItem = ToDoItem(ToDoItem.ID++, _controller.value.text);

                      words.add(newItem);  // put it on the screen

                      // add to the database:
                      myDAO.insertItem(newItem);

                      _controller.text = "";
                    });
                  },),
                Expanded(child: TextField(controller: _controller, decoration: InputDecoration(border: OutlineInputBorder(), hintText: 'Enter a todo item'),)),

              ],),

              Expanded(child:
              (words.isNotEmpty)?
              ListView.builder(
                itemCount: words.length,
                itemBuilder: (context, rowNum) {
                  return
                    GestureDetector(child:
                    Row( mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [Text("Row number: $rowNum"), Text(words[rowNum].toDoMesage)]
                    ),
                      onLongPress: () {
                        showDialog<void>(
                          context: context,
                          barrierDismissible: false, // user must tap button!
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('AlertDialog Title'),
                              content: const SingleChildScrollView(
                                child: ListBody(
                                  children: <Widget>[
                                    Text('Delete'),
                                    Text('Would you like to delete this message?'),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(child:const Text('Cancel'), onPressed: (){
                                  Navigator.of(context).pop();
                                }),
                                TextButton(
                                  child: const Text('Ok'),
                                  onPressed: () {
                                    setState(() {

                                      var itm = words[rowNum];
                                      myDAO.deleteItem(itm);

                                      words.removeAt(rowNum); // it's gone after this line

                                    });
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                            );
                          },
                        );},
                    ); }
            )
                :const Center(child: Text("There are no items") )
            )
          ],
         ),
      )
    );
  }

  //This function gets run when you click the button
  void buttonClicked(){
    // DataRepository.firstName  = _controller.value.text;
    Navigator.pushNamed(context, '/pageTwo'); //'/pageTwo' is one of your routes above

  }


}

// flutter pub add floor_generator
// flutter pub add -d build_runner

// flutter pub get  // after modified the pubspec.yaml

// <uses-permission android:name="android.permission.INTERNET" />  // add to android/app/src/main/AndroidMainfest.xml

