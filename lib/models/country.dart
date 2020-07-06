class Country{
String country,continent	;
CountryInfo countryInfo	;
int updated	,
cases	,
todayCases	,
deaths	,
todayDeaths	,
recovered	,
    todayRecovered,
active	,
    population,
critical	;

Country(Map<String,dynamic> json){
  country = json['country'];
  continent=json['continent'];
  updated = json['updated'];
  cases = json['cases'];
  todayCases = json['todayCases'];
  todayRecovered= json['todayRecovered'];
  deaths = json['deaths'];
  todayDeaths = json['todayDeaths'];
  recovered = json['recovered'];
  active = json['active'];
  critical = json['critical'];
  population= json['population'];
  countryInfo = CountryInfo(json['countryInfo']);

}

}


class CountryInfo{
String iso3, flag	;
int _id	;

CountryInfo(Map<String,dynamic> json){
  _id = json['_id'];
  iso3 = json['iso3'];
  flag = json['flag'];

}

}