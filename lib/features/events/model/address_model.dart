class AddressModel {
  final String street;
  final String number;
  final String neighborhood;
  final String city;

  AddressModel({
    required this.street,
    required this.number,
    required this.neighborhood,
    required this.city,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        street: json['street'],
        number: json['number'],
        neighborhood: json['neighborhood'],
        city: json['city'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> address = {};
    address['street'] = street;
    address['number'] = number;
    address['neighborhood'] = neighborhood;
    address['city'] = city;

    return address;

  }
}
