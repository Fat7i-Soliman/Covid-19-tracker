
import 'package:covid19_tracker/models/country.dart';
import 'package:covid19_tracker/models/globalCountry.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:connectivity/connectivity.dart';

class CountryScreen extends StatefulWidget {
  @override
  _CountryScreenState createState() => _CountryScreenState();
}

class _CountryScreenState extends State<CountryScreen> {

  String url = 'https://disease.sh/v3/covid-19/countries';
  List<Country> countryList ;
  List<Country> countryListDisplay ;
  var selected = GlobalCountry.instance;


  Future<String> getCountry() async {
    var response = await http.get(Uri.encodeFull(url),headers: {'Accept': 'application/json'});

    if(response.statusCode==200){
      var data = jsonDecode(response.body);

      setState(() {
        countryList = extractList(data);
        countryListDisplay = countryList ;
      });

    }


  }

  List<Country> extractList(List list){
    List<Country> countries = List();
    for(int i=0; i<list.length;i++){
      countries.add(new Country(list[i]));
    }

    return countries ;
  }

  searchCountry(String txt){
    txt=txt.toLowerCase();

    setState(() {
      countryListDisplay = countryList.where((element) {
        String title = element.country.toLowerCase();
        return title.contains(txt);
      }).toList();
    });
  }

  @override
  void initState() {
    getCountry();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8,right: 8,top: 5, bottom: 3),
          child: Container(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent ,width:1),
                  borderRadius: BorderRadius.all(Radius.circular(30))
                ),
                focusedBorder:OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent ,width:12),
                    borderRadius: BorderRadius.all(Radius.circular(30))
                       ) ,
                prefixIcon:Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[300],

              ),
              autofocus: false,
              onChanged:(txt) => searchCountry(txt) ,


            ),
          ),
        ),
        Expanded(
          child:
          countryList==null? Center(child: CircularProgressIndicator())
              : ListView.builder(
              itemCount: countryListDisplay==null ? 0 : countryListDisplay.length,
              itemBuilder: (context, index){
                return ListTile(
                  title: Text(countryListDisplay[index].country,style: TextStyle(fontSize: 18),),
                  subtitle: Text(' total cases : ${countryListDisplay[index].cases}'),
                  leading: Image.network(countryListDisplay[index].countryInfo.flag,height: 50,width: 60,),
                  onTap: ()=>{
                    navigate(countryListDisplay[index])
                  },
                );
              }
          ),
        )

      ],
    );
  }

  navigate(Country country) {
    Navigator.pushNamed(context, 'SingleCountry');
    selected.set('country',country);
  }
}