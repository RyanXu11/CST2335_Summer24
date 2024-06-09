import 'package:cst2335_summer24/DataRepository.dart';
import 'package:cst2335_summer24/OtherPage.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(  // this is where we put the routes/page trasitions;
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      routes: {
        '/OtherPage' : (context) => OtherPage(),
        '/': (context) => MyHomePage(title: 'Flutter Demo Home Page By Ryan Xu'),
      },
      initialRoute: '/', //initial is the home page
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page By Ryan Xu'), // this line replaced by initialRoute
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
  int _counter = 0;
  bool isChecked = false;
  late TextEditingController _controller; // for user Strings
  // late TextEditingController _controller2; // for user Strings
  // late SharedPreferences storedData;
  late EncryptedSharedPreferences storedData;
    //initialize later, but not null


  //Asynchronous
  // void loadSavedVariables() async{
  //   // This is asynchronous, await is used with asynchronous operations
  //   //prefs should be a map of key -value
  //   final prefs = await SharedPreferences.getInstance();
  //   // Asynchronous
  //   var otherPrefs = await SharedPreferences.getInstance()
  //     .then((thePrefs){
  //       // thePrefs have been loaded
  //   });// at this point, the file has been loaded
  // }


  // void loadSavedVariables() { // Not asynchronous
  //   var otherPrefs = SharedPreferences.getInstance()
  //       .then((thePrefs){
  //     // thePrefs have been loaded
  //   });// at this point, the file has been loaded
  // }

  void loadSavedVariables() { // Not asynchronous

    // at this point, the file has been loaded
  }


  @override
  void initState() {  //loading page
    super.initState();
    _controller = TextEditingController(); // Initialize the controller here
    // _controller2 = TextEditingController();

    DataRepository.loadVariables();
    // storedData = SharedPreferences();
    storedData = EncryptedSharedPreferences();
    storedData.getString("UserName").then((savedUserName){
      if(savedUserName != null){
        _controller.text = savedUserName;
      }
    });

    // SharedPreferences.getInstance().then((thePrefs){
    //   // at this point, the file (thePrefs) have been loaded
    //   storedData = thePrefs;
    //
    //   var savedUserName = storedData.getString("UserName"); //Nullable string
    //
    //   if(savedUserName != null){
    //     _controller.text = savedUserName;
    //   }
    // });

  }

  @override
  void dispose() {  // unloading page
    _controller.dispose();  // Dispose the controller to free up resources
    super.dispose();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }


  // flutter pub outdated
  // flutter pub upgrade --major-versions
  // flutter pub add shared_preferences
  // flutter pub add encrypted_shared_preferences



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        backgroundColor: Colors.yellowAccent,
        // title: Text(widget.title),
          title: Text("Week 5 Lectures"),
        actions:[
          OutlinedButton(onPressed:(){ }, child:Text("Save"),
              style: OutlinedButton.styleFrom(backgroundColor: Colors.blue)),
          OutlinedButton(onPressed:(){ }, child:Text("Delete"),
              style: OutlinedButton.styleFrom(backgroundColor: Colors.red)),
        ]
      ),
      drawer:Drawer(child:
       Column ( mainAxisAlignment: MainAxisAlignment.spaceAround,
       children: <Widget> [
         Text("Hi, there"),
         Text("Test line 2"),
         Text("Test line 3"),
        ])),
      bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem( icon: Icon(Icons.camera), label: 'Camera'  ),
            BottomNavigationBarItem( icon: Icon(Icons.add_call), label: 'Phone' ),
            BottomNavigationBarItem( icon: Icon(Icons.add_card_rounded), label: 'Pay' ),],
          onTap:(btnIndex){  }  ),
      body: Center(
        child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              getText(),
              getOtherText(),
              Text("Click the button below", style: TextStyle(fontSize: 30.0, color: Colors.redAccent),),
              ElevatedButton( onPressed: buttonClicked, child: Text("Click here"),),
              Padding(padding: EdgeInsets.fromLTRB(10, 100, 100, 10)),
              TextField(controller: _controller,
                decoration: InputDecoration(
                hintText: "Type here",
                border: OutlineInputBorder(),
                labelText: "Login name"
              ),)

        ])
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  // function for checkBoxClicked
  void checkBoxClicked(bool? newVal) // ? newVal is potentially null
  {
    if(newVal != null) {
      setState((){
        isChecked = newVal;  // update the GUI, ! assert not null
      });
    }
  }

  Widget getText() {
    return Text("I'm a text"); //simple retrun /getter funtion
  }
  Widget getOtherText() => Text("I'm another Text");

  // function for buttonClicked
  void buttonClicked(){
      var userTyped = _controller.value.text;
      // _controller.text = "You typed: " + userTyped;


    Navigator.pushNamed( context,"/OtherPage" ); //This NamedRoute string must be one of the named states
      // var mySB = SnackBar( content:
      //   Row(
      //     children: [Image.asset("images/algonquin.jpg", width: 100, height: 100),
      //     Text('Yay! A SnackBar!'), ],
      //   ),
      //     action:SnackBarAction( label:'Ok', onPressed: () {  } ),
      // );
      // ScaffoldMessenger.of(context).showSnackBar(mySB); // This show the SnackBAr

    // showDialog<String>(
    //   context: context,
    //   builder: (BuildContext context) =>
    //       AlertDialog(
    //         title: const Text('Save data'),
    //         content: const Text('Do you want to save your information?'),
    //         actions: <Widget>[
    //           ElevatedButton(child:Text("Ok"), onPressed: (){
    //             var userTyped = _controller.value.text;
    //             storedData.setString("UserName", userTyped);
    //
    //             Navigator.pop(context);
    //
    //           },),
    //           // ElevatedButton(onPressed: (){ Navigator.pop(context);}, child: Text("Ok")),
    //           FilledButton(onPressed: (){ Navigator.pop(context);}, child: Text("Cancel")),
    //           OutlinedButton(onPressed: (){ Navigator.pop(context);}, child: Text("Delete")),
    //           Image.asset("images/algonquin.jpg", width:100, height: 100),
    //       ],
    //   ),
    // );
  }

  // function to set NewValue
  // void setNewValue(double newVal){
  //   setState(){
  //
  //   }
  // }



}
