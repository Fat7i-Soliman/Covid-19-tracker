
class OverView{
  int cases,
      todayCases,
      deaths,
      todayDeaths,
      recovered,
      todayRecovered,
      active,
      affectedCountries,
      critical;

  OverView(Map<String,dynamic> json){
    cases= json['cases'];
    todayCases= json['todayCases'];
    deaths= json['deaths'];
    todayDeaths= json['todayDeaths'];
    recovered= json['recovered'];
    todayRecovered= json['todayRecovered'];
    active= json['active'];
    critical= json['critical'];
    affectedCountries= json['affectedCountries'];

  }
}