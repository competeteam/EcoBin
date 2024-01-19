class AddressModel {
  String? secondary_text;
  String? humanReadableAddress;
  double? latitudePosition;
  double? longitudePosition;
  double? dist;
  String? types;

  AddressModel(
      {this.humanReadableAddress,
      this.latitudePosition,
      this.longitudePosition,
      this.secondary_text,
      this.dist = 0,
      this.types});

  AddressModel.fromJson(Map<String, dynamic> json) {
    latitudePosition = json["properties"]["lat"];
    longitudePosition = json["properties"]["lon"];
    humanReadableAddress = json["properties"]["formatted"];
    secondary_text = json["properties"]["address_line2"];
    dist = 0;
  }
}
