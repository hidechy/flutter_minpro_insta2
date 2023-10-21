class LocationModel {
//<editor-fold desc="Data Methods">
  const LocationModel({
    required this.latitude,
    required this.longitude,
    required this.country,
    required this.state,
    required this.city,
  });

  factory LocationModel.fromMap(Map<String, dynamic> map) {
    return LocationModel(
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
      country: map['country'] as String,
      state: map['state'] as String,
      city: map['city'] as String,
    );
  }

  final double latitude;
  final double longitude;
  final String country;
  final String state;
  final String city;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocationModel &&
          runtimeType == other.runtimeType &&
          latitude == other.latitude &&
          longitude == other.longitude &&
          country == other.country &&
          state == other.state &&
          city == other.city);

  @override
  int get hashCode => latitude.hashCode ^ longitude.hashCode ^ country.hashCode ^ state.hashCode ^ city.hashCode;

  @override
  String toString() {
    return 'Location{ latitude: $latitude, longitude: $longitude, country: $country, state: $state, city: $city,}';
  }

  LocationModel copyWith({
    double? latitude,
    double? longitude,
    String? country,
    String? state,
    String? city,
  }) {
    return LocationModel(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      country: country ?? this.country,
      state: state ?? this.state,
      city: city ?? this.city,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'country': country,
      'state': state,
      'city': city,
    };
  }

//</editor-fold>
}
