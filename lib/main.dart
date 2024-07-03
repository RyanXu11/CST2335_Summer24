import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'OtherPage.dart';
import 'DataRepository.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';  // kIsWeb


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
    // if(!kIsWeb) {
    //   // Get the operating system as a string
    //   var myOS = Platform.operatingSystem;
    //
    //   if(Platform.isWindows){
    //
    //   } else if(Platform.isAndroid) {
    //
    //   }
    // }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //list all the pages:
      routes: {
        //Keys:         //values
        '/pageOne'   :   (context) => MyHomePage(title: 'Week 7 Lecture '),
        '/pageTwo'  :    (context) { return OtherPage(); }

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
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    // initialize object, onloaded in HTML
    super.initState();

    // Create and store the VideoPlayerController. The VideoPlayerController
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
      ),
    );
    _initializeVideoPlayerFuture = _controller.initialize();
  }

  @override
  void dispose() { //unloading the page
    super.dispose();
    // Ensure the _controllerV dispose
    _controller.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Wrap the play or pause in a call to `setState`. This ensures the
          // correct icon is shown.
          setState(() {
            // If the video is playing, pause it.
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              // If the video is paused, play it.
              _controller.play();
            }
          });
        },
        // Display the correct icon depending on the state of the player.
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
      appBar: AppBar(backgroundColor: Theme.of(context).colorScheme.inversePrimary,title: Text(widget.title)),
      body: Center(
        child:
         Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // Flexible(child: // or Expanded
            Expanded(
              child:
                FutureBuilder(
                  future: _initializeVideoPlayerFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      // If the VideoPlayerController has finished initialization, use
                      // the data it provides to limit the aspect ratio of the video.
                      return AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        // Use the VideoPlayer widget to display the video.
                        child: VideoPlayer(_controller),
                      );
                    } else {
                      // If the VideoPlayerController is still initializing, show a
                      // loading spinner.
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(radius: 50,
                  backgroundImage: AssetImage('images/algonquin.jpg'),
                ),
                ClipOval(
                  child: Image.network(
                    'https://img.icons8.com/?size=48&id=gQ4NaXzMSLil&format=png',
                    width: 50,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 50),
                  child: FilledButton(onPressed:() { }, child: Text("Click me"),),),
                Expanded(
                    flex: 1,
                    child:
                    Padding(
                      padding: EdgeInsets.fromLTRB(5, 30, 20, 20),
                      child: FilledButton(onPressed: (){ }, child: Text("Click again"),),
                    ),
                ),
                Expanded(
                    flex: 1,
                    child: FilledButton(onPressed: (){ }, child: Text("Click Double")),
                ),
                Expanded(
                    flex: 2,
                    child: FilledButton(onPressed: (){ }, child: Text("Click Triple")),
                ),
                CachedNetworkImage(
                  imageUrl: 'https://img.icons8.com/?size=48&id=gQ4NaXzMSLil&format=png',
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Text("Sorry, the image is not available"),
                ),
              ],),
          ],),
        ),
    );
  }

  //This function gets run when you click the button
  void buttonClicked(){
    // DataRepository.firstName  = _controller.value.text;
    Navigator.pushNamed(context, '/pageTwo'); //'/pageTwo' is one of your routes above

  }


}

// flutter pub add flutter_launcher_icons
// flutter pub run flutter_launcher_icons
// flutter pub add video_player
// <uses-permission android:name="android.permission.INTERNET" />  // add to android/app/src/main/AndroidMainfest.xml

// https://icons8.com/icons/set/app
