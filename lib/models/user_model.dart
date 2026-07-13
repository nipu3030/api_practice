class CoordinatesModel{
  double? lat,lng;

  CoordinatesModel({
    required this.lat,
    required this.lng
  });
  factory CoordinatesModel.fromJson(Map<String,dynamic> json){
    return CoordinatesModel(
        lat: json["lat"],
        lng: json["lng"]);
  }
}

class AddressModel{
  String? address,city,country,
      postalCode,state,stateCode;
  CoordinatesModel? coordinates;

  AddressModel({
    required this.address,
    required this.city,
    required this.coordinates,
    required this.country,
    required this.postalCode,
    required this.state,
    required this.stateCode,
});

  factory AddressModel.fromJson(Map<String,dynamic> json){
    return AddressModel(
        address: json["address"],
        city: json["city"],
        coordinates: CoordinatesModel.fromJson(json["coordinates"]),
        country: json["country"],
        postalCode: json["postalCode"],
        state: json["state"],
        stateCode: json["stateCode"]);
  }
}


