
import 'package:flutter/material.dart';

class InfoScreen extends StatefulWidget {
  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 20,),
          Text('About Covid-19 :',style: TextStyle( fontSize: 18,fontWeight: FontWeight.bold),),
          SizedBox(height: 20,),
          Text('Coronavirus disease (COVID-19) is an infectious disease caused by a newly discovered coronavirus.'),
          SizedBox(height: 10,),
          Text('Most people who fall sick with COVID-19 will experience mild to moderate symptoms and recover without special treatment.'),
          SizedBox(height: 40,child: Divider(color: Colors.grey,),),
          Text('How it spreads :',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
          SizedBox(height: 20,),
          Text('The virus that causes COVID-19 is mainly transmitted through droplets generated when an infected person coughs, sneezes, or exhales. These droplets are too heavy to hang in the air, and quickly fall on floors or surfaces.'),
          SizedBox(height: 10,),
          Text('You can be infected by breathing in the virus if you are within close proximity of someone who has COVID-19, or by touching a contaminated surface and then your eyes, nose or mouth.')

        ],
      ),
    );
  }
}
