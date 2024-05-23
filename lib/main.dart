import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page By Ryan Xu'),
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
    //initialize later, but not null

  @override
  void initState() {  //loading page
    super.initState();
    _controller = TextEditingController(); // Initialize the controller here
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        backgroundColor: Colors.yellowAccent,
        // title: Text(widget.title),
          title: Text("Demo by Ryan Xu"),
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
        child:
        Stack(
          alignment: AlignmentDirectional.bottomCenter,
            children: <Widget>[
              Image.asset("images/algonquin.jpg"),
              Text("This is Algonquin College", style: TextStyle(fontSize: 30.0, backgroundColor:Colors.white ),)
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

  // function for buttonClicked
  void buttonClicked(){
      var userTyped = _controller.value.text;
      _controller.text = "You typed: " + userTyped;
  }

  // function to set NewValue
  void setNewValue(double newVal){
    setState(){

    }
  }



}
