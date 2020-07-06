import 'package:covid19_tracker/screens/countries.dart';
import 'package:covid19_tracker/screens/homeScreen.dart';
import 'package:covid19_tracker/screens/infoScreen.dart';
import 'package:covid19_tracker/screens/singleCountry.dart';
import 'package:covid19_tracker/screens/tipsScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: <String,WidgetBuilder>{
        'SingleCountry': (BuildContext context)=> SingleCountry()
      },

      home: MyHomePage(),
    );
  }
}



class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<BottomNavigationBarItem> items;
  FocusNode _focusNode = new FocusNode();
  List<String> appbarTitle ;

  int index = 0;



  void makeItems() {
    items = List();

    items.add(new BottomNavigationBarItem(
        icon: Icon(Icons.home), title: Text('Home',style: TextStyle(fontSize: 12),)));
    items.add(new BottomNavigationBarItem(
        icon: Icon(Icons.flag), title: Text('Countries',style: TextStyle(fontSize: 12),)));
    items.add(new BottomNavigationBarItem(
        icon: Icon(Icons.notification_important), title: Text('Tips',style: TextStyle(fontSize: 12),)));
    items.add(new BottomNavigationBarItem(
        icon: Icon(Icons.info), title: Text('Info',style: TextStyle(fontSize: 12),)));


    appbarTitle = ['Covid-19 Tracker','Countries with cases','Safety Tips','About Covid-19'];
  }


  Widget getCurrentPage(int page){
    switch(page){
      case 0:
        return HomeScreen();
      case 1:
        return CountryScreen();
      case 2:
        return TipsScreen();
      case 3:
        return InfoScreen();
      default :
        return HomeScreen();
    }
  }
  @override
  void initState() {

    makeItems();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(appbarTitle[index]),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: ()=> FocusScope.of(context).requestFocus(_focusNode),
        child: SafeArea(
          child:getCurrentPage(index),

        ),
      ),

      bottomNavigationBar: new BottomNavigationBar(
        items: items,
        fixedColor: Colors.deepPurpleAccent,
        unselectedItemColor: Colors.grey,
        currentIndex: index,
        onTap: (int item) {
          setState(() {
            index = item;
          });

          print(item.toString());
        },
      ),
    );
  }

}
