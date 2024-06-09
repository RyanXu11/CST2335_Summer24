
import 'package:cst2335_summer24/DataRepository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class OtherPage extends StatefulWidget {  //stateful means has variables
  @override
  State<OtherPage> createState() => OtherPageState(); // or {return OtherPageState()}
}

class OtherPageState extends State<OtherPage>{
  @override
  Widget build(BuildContext context) {  // returns how this looks on screen
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text("Hello " +DataRepository.firstName),
    OutlinedButton(onPressed: () {
      canLaunch("hhhhhhh:(613) 727-4723").then( (resultItCan) {
        if(resultItCan)
        {launch("sms:(613) 727-4723");
        }else{
          //can't handle sms
    // }
    }

    } );
      // Navigator.pop(context); // go back page one

  }, child: Text( "dial Algonquin's number"))
    ])
    ));
  }
}