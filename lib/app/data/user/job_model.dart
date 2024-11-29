class Job {
  int? id;
  String? name;
  String? description;

  Job({
    this.id,
    this.name,
    this.description,
  });

  factory Job.fromJson(Map<String, dynamic> json) => Job(
        id: json["id"],
        name: json["name"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
      };
}
