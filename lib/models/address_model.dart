class AddressModel {
  String? secondary_text;
  String? humanReadableAddress;
  double? latitudePosition;
  double? longitudePosition;
  double? dist;

  AddressModel(
      {this.humanReadableAddress,
      this.latitudePosition,
      this.longitudePosition,
      this.secondary_text,
      this.dist = 0});

  AddressModel.fromJson(Map<String, dynamic> json) {
    latitudePosition = json["properties"]["lat"];
    longitudePosition = json["properties"]["lon"];
    humanReadableAddress = json["properties"]["formatted"];
    secondary_text =
        json["properties"]["city"] + ", " + json["properties"]["state"];
    dist = 0;
  }
}
