
import 'package:flutter/material.dart';

class TipsScreen extends StatefulWidget {
  @override
  _TipsScreenState createState() => _TipsScreenState();
}

Widget header(){
  return Container(

    padding: EdgeInsets.all(8),
    child: Center(
      child: Column(
        children: <Widget>[
          SizedBox(height: 10),
          Image.asset('images/safe.gif',height: 120,width: 120,),
          SizedBox(height: 20),
          Text('STAY HOME. SAVE LIVES.',style: TextStyle(fontSize: 26 ,fontWeight: FontWeight.bold),),
          Text('Help stop coronavirus',style: TextStyle( fontWeight: FontWeight.bold)),
          SizedBox(height: 20,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('1- STAY home as much as you can',),
              Text('2- KEEP a safe distance',),
              Text('3- WASH hands often'),
              Text('4- COVER your cough'),
              Text('5- SICK?  Call ahead'),
            ],
          )


        ],
      ),
    ),
  );
}


Widget body(){
  return Padding(padding: EdgeInsets.all(10),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text('Protect yourself and others around you by knowing the facts and taking appropriate precautions. Follow advice provided by your local health authority.'),
      SizedBox(height: 15,),
      Text('To prevent the spread of COVID-19: ',style: TextStyle(fontWeight: FontWeight.bold),),
      SizedBox(height: 15,),

      Text('- Clean your hands often. Use soap and water, or an alcohol-based hand rub. '),
      SizedBox(height: 5,),

      Text('- Maintain a safe distance from anyone who is coughing or sneezing. '),
      SizedBox(height: 5,),

      Text('- Wear a mask when physical distancing is not possible.'),
      SizedBox(height: 5,),

      Text('- Don’t touch your eyes, nose or mouth.'),
      SizedBox(height: 5,),

      Text('- Cover your nose and mouth with your bent elbow or a tissue when you cough or sneeze.'),
      SizedBox(height: 5,),

      Text('- Stay home if you feel unwell.'),
      SizedBox(height: 5,),

      Text('- If you have a fever, cough and difficulty breathing, seek medical attention.'),
      SizedBox(height: 15)

    ],
  ),
  );
  
}

Widget last(){
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Calling in advance allows your healthcare provider to quickly direct you to the right health facility. This protects you, and prevents the spread of viruses and other infections.'),
        SizedBox(height: 15,),
        Text('Masks :',style: TextStyle(fontWeight: FontWeight.bold),),
        SizedBox(height: 10,),
        Text('Masks can help prevent the spread of the virus from the person wearing the mask to others. Masks alone do not protect against COVID-19, and should be combined with physical distancing and hand hygiene. Follow the advice provided by your local health authority.')

      ],
    ),
  );
}
class _TipsScreenState extends State<TipsScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
       slivers: <Widget>[
         SliverFixedExtentList(
           itemExtent: 370,
           delegate: SliverChildListDelegate([
             header(),
             body(),
             last()
             
           ]),
         )
       ],
    );
  }
}
