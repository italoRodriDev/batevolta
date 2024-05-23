class AddressGoogleMaps {
  final String formattedAddress;
  final double latitude;
  final double longitude;
  final String? neighborhood;
  final String? city;
  final String? state;
  final String? country;

  AddressGoogleMaps({
    required this.formattedAddress,
    required this.latitude,
    required this.longitude,
    this.neighborhood,
    this.city,
    this.state,
    this.country,
  });

  factory AddressGoogleMaps.fromJson(Map<String, dynamic> json) {
    String? getComponent(List<dynamic> components, String type) {
      for (var component in components) {
        if (component['types'].contains(type)) {
          return component['long_name'];
        }
      }
      return null;
    }

    var addressComponents = json['address_components'] as List;
    return AddressGoogleMaps(
      formattedAddress: json['formatted_address'],
      latitude: json['geometry']['location']['lat'],
      longitude: json['geometry']['location']['lng'],
      neighborhood: getComponent(addressComponents, 'sublocality') ?? '',
      city: getComponent(addressComponents, 'locality') ?? '',
      state: getComponent(addressComponents, 'administrative_area_level_1') ?? '',
      country: getComponent(addressComponents, 'country') ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'formatted_address': formattedAddress,
      'geometry': {
        'location': {
          'lat': latitude,
          'lng': longitude,
        },
      },
      'address_components': [
        if (neighborhood != null) {'long_name': neighborhood, 'types': ['sublocality']},
        if (city != null) {'long_name': city, 'types': ['locality']},
        if (state != null) {'long_name': state, 'types': ['administrative_area_level_1']},
        if (country != null) {'long_name': country, 'types': ['country']},
      ],
    };
  }
}