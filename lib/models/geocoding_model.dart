class Geocoding {
  final String? name;
  final double? lat;
  final double? lon;
  final String? country;
  final String? state;

  Geocoding({
    this.name,
    this.lat,
    this.lon,
    this.country,
    this.state,
  });

  factory Geocoding.fromJson(Map<String, dynamic> json) {
    return Geocoding(
      // This part will error out without the curly braces in the constructor above
      // because these are named optional parameters and the names are called
      name: json['name'],
      lat: json['lat'],
      lon: json['lon'],
      country: json['country'],
      state: json['state'],
    );
  }
}
