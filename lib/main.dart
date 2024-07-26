import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'AppLocalizations.dart';

void main() {
  runApp(const MyApp());
}
//chande to StatfulWidget because the language changes
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() {
    return _MyAppState();
  }

  static void setLocale(BuildContext context, Locale newLocale) async {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.changeLanguage(newLocale);
  }

}


class _MyAppState extends State<MyApp>
{

  var _locale = Locale("en", "CA"); //default is english from Canada

  void changeLanguage(Locale newLanguage)
  {
    setState(() {
      _locale = newLanguage; //set app to new language, and redraw
    });

  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //add your supported locales:
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      supportedLocales:  const<Locale> [
        Locale("en", "CA"),
        Locale("de", "DE"),//country doesn't matter in this case
        Locale("fr", "CA"),
        Locale("zh", "CN")
      ] ,

      localizationsDelegates: const[
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: _locale, //default is "en", "CA" from above
      title: AppLocalizations.of(context)?.translate('title') ?? 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  // final String title;

  @override
  State<MyHomePage> createState() => MyHomePageState();

}

// _ makes it private, not generated in documentation
class MyHomePageState extends State<MyHomePage> {

  //member variables:

  /** This holds our list of to do items */
  var words = <String>[];

  /// This lets the user type in a new to do item:
  late TextEditingController _controller; // late means initialize later, but not null

  /// This holds the item that a user selects:
  String? selectedItem = null;


  @override //this wasn't written by you
  void initState() {
    // initialize object, onloaded in HTML
    super.initState();
    _controller = TextEditingController();

  }

  @override
  void dispose() { //unloading the page
    super.dispose();
    _controller.dispose(); //delete memory of _controller
  }

  /// This function displays a list of to-do items created by the user
  Widget ToDoList(){
    return Center( child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(children: [
          ElevatedButton(child:Text(AppLocalizations.of(context)!.translate('add_key')!), onPressed: () {
            setState(() {
              var newItem = _controller.value.text;
              words.add(newItem);
              _controller.text = "";
            });
          }   ),
          Expanded(child: TextField(controller: _controller, decoration: InputDecoration(border: OutlineInputBorder(),

              hintText: AppLocalizations.of(context)!.translate('enter_todo')!   ))),

        ]),
        Expanded(child:

        (words.isNotEmpty)?
        ListView.builder(
            itemCount: words.length,
            itemBuilder: (context, rowNum) {
              return
                GestureDetector(child:
                Row( mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [Text("Row number: $rowNum"), Text(words[rowNum])]
                ),
                  onTap: (){
                    setState(() {
                      //which one was selected:
                      selectedItem =  words[rowNum]; //no longer null
                    });


                  },

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
                            TextButton(child:const Text('Cancel'), onPressed: (){ }),
                            TextButton(
                              child: const Text('Ok'),
                              onPressed: () {
                                setState(() {
                                  words.removeAt(rowNum);
                                });
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        );
                      },
                    );
                  },
                ); }
        )
            : Center(child:Column(children:
        [Text( AppLocalizations.of(context)!.translate('no_items')!)],)  )
        )

      ],
    ),
    );
  }

  /// This function returns a Widget that shows details about the selected item
  Widget DetailsPage(){
    if(selectedItem == null)
      return Column(children: [Text("Nothing is selected")],);//something that returns
    else
    {               //    !  means assert non-null
      return  Column(children: [ Text( selectedItem!  ) ,//selectedItem is String
        ElevatedButton(onPressed: () {
          setState(() {
            selectedItem = null;
          });
        }, child: Text("Go back")  )]);
    }
  }


  /// This adapts the layout according to the device screen
  Widget responsiveLayout()
  {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    if((width > height) && (width > 720)) //landscape mode
        {
      return  Row(children:[
        Expanded(flex:1,  child:ToDoList()),
        Expanded(flex:3,  child:DetailsPage() )   ]);

    }
    else //portrait mode
        {
      if(selectedItem == null)
        return ToDoList();  //nothing was selected
      else
        return DetailsPage();//show the details
    }
  }

  @override
  Widget build(BuildContext context) {
    String title = AppLocalizations.of(context)!.translate('title') ?? 'Default Title';
    return Scaffold(
        appBar: AppBar(
          actions: [
            OutlinedButton(onPressed: () {MyApp.setLocale(context, Locale("de", "DE") ); }, child:Text("Deutsch")),
            OutlinedButton(onPressed: () {MyApp.setLocale(context, Locale("fr", "CA") ); }, child:Text("Français")),
            OutlinedButton(onPressed: () {MyApp.setLocale(context, Locale("en", "CA") ); }, child:Text("English")),
            OutlinedButton(onPressed: () {MyApp.setLocale(context, Locale("zh", "CN") ); }, child:Text("中文")),
          ],
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(title),
        ),
        body:  responsiveLayout()
    );
  }


}
// flutter pub add floor_generator
// flutter pub add -d build_runner

// flutter pub get  // after modified the pubspec.yaml

// <uses-permission android:name="android.permission.INTERNET" />  // add to android/app/src/main/AndroidMainfest.xml

