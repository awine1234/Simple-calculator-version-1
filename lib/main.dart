import 'dart:ui';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


void main() => runApp(
  DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => MyApp(), // Wrap your app
  ),
);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: DevicePreview.locale(context), // Add the locale here
      builder: DevicePreview.appBuilder,
      title: 'cals',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({ Key? key }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
final CustomColor _customColor =CustomColor();
Widget keypadButton(String btntxt, Color btncolor, Color txtcolor){
  return Container(
    height: 80.0,
    width: 80.0,
    child: ElevatedButton(
      onPressed: () {
        calculation(btntxt);
      }, 
      child: Text(
        btntxt, 
        style: TextStyle(
          fontSize: 35.0, 
          color: txtcolor,
          ),
  ),
  style: ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0)
      ),
      primary: _customColor.keypadColor,
      padding: EdgeInsets.all(20.0)
      ),
      
    
  )
  );
  
  
}
Widget keypadSymbolsButton(String btntxt, Color btncolor, Color txtcolor){
  return Container(
    height: 80.0,
    width: 80.0,
    child: ElevatedButton(
      onPressed: () {
        
        calculation(btntxt);
      }, 
      child: Text(
        btntxt, 
        style: TextStyle(
          fontSize: 35.0, 
          color: txtcolor,
          ),
  ),
  style: ElevatedButton.styleFrom(
    shape:CircleBorder(),
      
      primary: _customColor.keypadsymbolsColor,
      padding: EdgeInsets.all(20.0)
      ),
      
    
  )
  );
  
  
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _customColor.backgroundcolor,
      body: SafeArea(
        child: 
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text("$text",
                textAlign:TextAlign.left,
                style: TextStyle(color: Colors.white,
                fontSize: 100,
                fontWeight: FontWeight.bold,
                
                ),
                )  
              ),
            
          ]
            ),
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              keypadButton("AC", Colors.black, Colors.white),
              keypadButton("+/-", Colors.black, Colors.white),
              keypadButton("%", Colors.black, Colors.white),
              keypadSymbolsButton("÷", Colors.black, Colors.white),
            
          ]
            ),
            SizedBox(
              height: 20.0,
            ),
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              keypadButton("7", Colors.black, Colors.white),
              keypadButton("8", Colors.black, Colors.white),
              keypadButton("9", Colors.black, Colors.white),
              keypadSymbolsButton("x", Colors.black, Colors.white),
            
          ]
            ),
            SizedBox(
              height: 20.0,
            ),
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              keypadButton("4", Colors.black, Colors.white),
              keypadButton("5", Colors.black, Colors.white),
              keypadButton("6", Colors.black, Colors.white),
              keypadSymbolsButton("-", Colors.black, Colors.white),
            
          ]
            ),
            SizedBox(
              height: 20.0,
            ),
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              keypadButton("1", Colors.black, Colors.white),
              keypadButton("2", Colors.black, Colors.white),
              keypadButton("3", Colors.black, Colors.white),
              keypadSymbolsButton("+", Colors.black, Colors.white),
            
          ]
            ),
            SizedBox(
              height: 20.0,
            ), Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              keypadButton("0", Colors.black, Colors.white),
              keypadButton(".", Colors.black, Colors.white),
              keypadButton("=", Colors.black, Colors.white),
              keypadSymbolsButton("/", Colors.black, Colors.white),
            
          ]
            ),
            SizedBox(
              height: 20.0,
            )
            
            ],
            
    )));
          
            
          
   
  }
  
//Calculator logic
  dynamic text = '0';
  double numOne = 0;
  double numTwo = 0;

  dynamic result = '';
  dynamic finalResult = '';
  dynamic opr = '';
  dynamic preOpr = '';
  void calculation(btnText) {
    if (btnText == 'AC') {
      text = '0';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '0';
      opr = '';
      preOpr = '';
    } else if (opr == '=' && btnText == '=') {
      if (preOpr == '+') {
        finalResult = add();
      } else if (preOpr == '-') {
        finalResult = sub();
      } else if (preOpr == 'x') {
        finalResult = mul();
      } else if (preOpr == '/') {
        finalResult = div();
      }
    } else if (btnText == '+' ||
        btnText == '-' ||
        btnText == 'x' ||
        btnText == '/' ||
        btnText == '=') {
      if (numOne == 0) {
        numOne = double.parse(result);
      } else {
        numTwo = double.parse(result);
      }

      if (opr == '+') {
        finalResult = add();
      } else if (opr == '-') {
        finalResult = sub();
      } else if (opr == 'x') {
        finalResult = mul();
      } else if (opr == '/') {
        finalResult = div();
      }
      preOpr = opr;
      opr = btnText;
      result = '';
    } else if (btnText == '%') {
      result = numOne / 100;
      finalResult = doesContainDecimal(result);
    } else if (btnText == '.') {
      if (!result.toString().contains('.')) {
        result = result.toString() + '.';
      }
      finalResult = result;
    } else if (btnText == '+/-') {
      result.toString().startsWith('-')
          ? result = result.toString().substring(1)
          : result = '-' + result.toString();
      finalResult = result;
    } else {
      result = result + btnText;
      finalResult = result;
    }

    setState(() {
      text = finalResult;
    });
  }

  String add() {
    result = (numOne + numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String mul() {
    result = (numOne * numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String div() {
    result = (numOne / numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String doesContainDecimal(dynamic result) {
    if (result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if (!(int.parse(splitDecimal[1]) > 0))
        return result = splitDecimal[0].toString();
    }
    return result;
  }
}

class CustomColor {
  final Color backgroundcolor = Color.fromRGBO(30, 38, 53, 1);
  final keypadColor = Color.fromRGBO(40, 51, 71, 1);
  final Color keypadsymbolsColor = Color.fromRGBO(43, 102, 206, 1);
}
