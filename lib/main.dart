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
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
    _controller = TextEditingController();
  }

  @override
  void dispose() {  // unloading page
    _controller.dispose();
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
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',style: TextStyle(fontSize: 20)
            ),
            Text('$_counter', style: Theme.of(context).textTheme.headlineMedium, ),
            Image.asset("images/algonquin.jpg", width:300.0, height:200.0),

            // ElevatedButton(onPressed:buttonClicked, child: Text("Click me")),
            ElevatedButton(onPressed:buttonClicked, child: Image.asset("images/algonquin.jpg", width:200.0, height:150.0)),
            Checkbox(value: isChecked, onChanged: checkBoxClicked),
            Switch(value: isChecked, onChanged: checkBoxClicked),
            TextField(controller: _controller,
                decoration: InputDecoration(
                hintText:"Type here",
                border: OutlineInputBorder(),
                labelText: "First name"
            )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  // function for checkBoxClicked
  void checkBoxClicked(bool ? newVal) // ? newVal is potentially null
  {
    if(newVal != null) {
      setState((){
        isChecked = newVal!;  // update the GUI, ! assert not null
      });
    }
  }

  // function for buttonClicked
  void buttonClicked(){
      var userTyped = _controller.value.text;
  }

  // function to set NewValue
  void setNewValue(double newVal){
    setState(){

    }
  }



}
