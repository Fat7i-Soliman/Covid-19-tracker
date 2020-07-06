import 'package:covid19_tracker/models/country.dart';
import 'package:covid19_tracker/models/globalCountry.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'homeScreen.dart';

class SingleCountry extends StatefulWidget {
  @override
  _SingleCountryState createState() => _SingleCountryState();
}

class _SingleCountryState extends State<SingleCountry> {
  List<Cases> sections;
  List<charts.Series<Cases, String>> _chartdata;
  Country selected = GlobalCountry.instance.get('country');

  @override
  void initState() {
    sections = List<Cases>();
    _chartdata = new List<charts.Series<Cases, String>>();
    countryData(selected);
    super.initState();
  }

  void countryData(Country obj) {
    sections = [
      new Cases(
          obj.cases, 'All Cases', charts.MaterialPalette.red.shadeDefault),
      new Cases(obj.recovered, 'Recovered',
          charts.MaterialPalette.yellow.shadeDefault),
      new Cases(
          obj.deaths, 'Deaths', charts.MaterialPalette.green.shadeDefault),
      new Cases(
          obj.active, 'Active cases', charts.MaterialPalette.blue.shadeDefault),
    ];

    setState(() {
      _chartdata.add(new charts.Series(
        id: 'cases',
        data: sections,
        colorFn: (Cases sales, _) => sales.color,
        domainFn: (Cases sales, _) => sales.title,
        measureFn: (Cases sales, _) => sales.num,
      ));
    });
  }

  Widget statistics() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.white,
                ),
                child: Column(
                  children: <Widget>[
                    Text('Cases OverAll',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple),
                        textAlign: TextAlign.center),
                    Divider(),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        singleView('all cases', selected.cases),
                        singleView('recovered', selected.recovered),
                        singleView('deaths', selected.deaths)
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        singleView('active', selected.active),
                        singleView('critical', selected.critical),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.white,
                ),
                child: Column(
                  children: <Widget>[
                    Text(
                      'Today',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple),
                    ),
                    SizedBox(
                      height: 10,
                      child: Divider(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        singleView('cases', selected.todayCases),
                        singleView('recovered', selected.todayRecovered),
                        singleView('deaths', selected.todayDeaths)
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget singleView(String title, int count) {
    return Center(
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            '$title',
            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            textAlign: TextAlign.start,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            '$count',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }

  Widget body() {
    return Container(
      color: Colors.grey[200],
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Colors.white,
              ),
              child: Center(
                  child: Column(
                children: <Widget>[
                  Image.network(
                    '${selected.countryInfo.flag}',
                    height: 80,
                    width: 100,
                  ),
                  Text(
                    '${selected.country}',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${selected.continent}',
                    style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'popularity: ${selected.population}',
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  )
                ],
              )),
            ),
          ),
          Expanded(
              child: new charts.PieChart<dynamic>(
//new version
                  _chartdata,
                  animate: true,
                  animationDuration: new Duration(seconds: 2),
                  behaviors: [
                new charts.DatumLegend(
                    position: charts.BehaviorPosition.top,
                    outsideJustification: charts.OutsideJustification.start,
                    desiredMaxRows: 2,
                    cellPadding:
                        EdgeInsets.symmetric(horizontal: 5, vertical: 5.0),
                    horizontalFirst: false,
                    entryTextStyle: charts.TextStyleSpec(
                      color: charts.MaterialPalette.black,
                      fontSize: 14,
                    )),
              ])),
          Expanded(
              child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Container(
              child: statistics(),
            ),
          ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text('${selected.countryInfo.iso3}'),
        ),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverFixedExtentList(
                delegate: SliverChildListDelegate([body()]), itemExtent: 850)
          ],
        ));
  }
}
