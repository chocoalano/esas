class Branch {
  int? id;
  String? name;
  String? latitude;
  String? longitude;
  String? fullAddress;

  Branch({
    this.id,
    this.name,
    this.latitude,
    this.longitude,
    this.fullAddress,
  });

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        id: json["id"],
        name: json["name"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        fullAddress: json["fullAddress"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "latitude": latitude,
        "longitude": longitude,
        "fullAddress": fullAddress,
      };
}
