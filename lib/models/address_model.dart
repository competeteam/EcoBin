class AddressModel {
  String? secondaryText;
  String? humanReadableAddress;
  double? latitudePosition;
  double? longitudePosition;
  double? dist;
  String? types;
  String? tid;

  AddressModel(
      {this.humanReadableAddress,
      this.latitudePosition,
      this.longitudePosition,
      this.secondaryText,
      this.dist = 0,
      this.types,
      this.tid});

  AddressModel.fromJson(Map<String, dynamic> json) {
    latitudePosition = json["properties"]["lat"];
    longitudePosition = json["properties"]["lon"];
    humanReadableAddress = json["properties"]["formatted"];
    secondaryText = json["properties"]["address_line2"];
    dist = 0;
  }
}
