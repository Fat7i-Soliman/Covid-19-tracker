class GlobalCountry {
  final Map<dynamic,dynamic> country = <dynamic,dynamic>{};

  static GlobalCountry instance = new GlobalCountry();

  set(dynamic key, dynamic value)=> country[key] = value ;
  get(dynamic key)=> country[key];

}