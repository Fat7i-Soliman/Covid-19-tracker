import 'package:covid19_tracker/models/overView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class Cases {
  int num;
  String title;
  charts.Color color;
  Cases(this.num, this.title, this.color);
}

class _HomeScreenState extends State<HomeScreen> {
  List<Cases> sections;
  List<charts.Series<Cases, String>> _chartdata;
  final url = 'https://disease.sh/v3/covid-19/all';
  OverView overall;

  Future<String> getOverall() async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {'Accept': 'application/json'});
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        overall = OverView(data);
      });

      print('response ${response.body}');
      print('object ${overall.cases}');

      setData(overall);
    }
  }

  void setData(OverView obj) {
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

  @override
  void initState() {
    sections = List<Cases>();
    _chartdata = new List<charts.Series<Cases, String>>();
    getOverall();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return overall == null
        ? Center(child: CircularProgressIndicator())
        : Column(
            children: <Widget>[
              Expanded(
                  child: new charts.PieChart<dynamic>(
                      //new version
                      _chartdata,
                      animate: true,
                      animationDuration: new Duration(seconds: 2),
                      behaviors: [
                    new charts.DatumLegend(
                        position: charts.BehaviorPosition.top,
                        outsideJustification:
                            charts.OutsideJustification.endDrawArea,
                        desiredMaxColumns: 1,
                        cellPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 5.0),
                        horizontalFirst: false,
                        entryTextStyle: charts.TextStyleSpec(
                          color: charts.MaterialPalette.black,
                          fontSize: 14,
                        )),
                  ])),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                child: Container(
                  child: statistics() ,
                ),
              ))
            ],
          );
  }

  Widget statistics() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text('Cases overview',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.purple),
            textAlign: TextAlign.center),
        Divider(),
        SizedBox(
          height: 10,
        ),
        Text(
          'OverAll',
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: Colors.purple),

        ),
        SizedBox(
          height: 10,
          child: Divider(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[singleView('all cases',overall.cases),
            singleView('recovered',overall.recovered),
            singleView('deaths',overall.deaths)],
        ),
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[singleView('active',overall.active),
            singleView('critical',overall.critical),
            singleView('countries',overall.affectedCountries)],
        ),
        SizedBox(height: 20),
        Text(
          'Today',
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: Colors.purple),
          textAlign: TextAlign.justify,
        ),
        SizedBox(
          height: 10,
          child: Divider(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[singleView('cases',overall.todayCases),
            singleView('recovered',overall.todayRecovered),
            singleView('deaths',overall.todayDeaths)],
        )
      ],
    );
  }

  Widget singleView(String title,int count) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '$title',
             style: TextStyle(fontSize: 14,color: Colors.grey[700]),
            textAlign: TextAlign.start,
          ),
          SizedBox(
            height: 5,
          ),
          Text('$count',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17))
        ],
      ),
    );
  }
}
