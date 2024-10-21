class FormalEducation {
  final int id;
  final int userId;
  final String institution;
  final String majors;
  final double score;
  final String start;
  final String finish;
  final String description;
  final bool certification;

  FormalEducation({
    required this.id,
    required this.userId,
    required this.institution,
    required this.majors,
    required this.score,
    required this.start,
    required this.finish,
    required this.description,
    required this.certification,
  });

  factory FormalEducation.fromJson(Map<String, dynamic> json) {
    return FormalEducation(
      id: json['id'],
      userId: json['userId'],
      institution: json['institution'],
      majors: json['majors'],
      score: (json['score'] as num).toDouble(),
      start: json['start'],
      finish: json['finish'],
      description: json['description'],
      certification: json['certification'] == 1,
    );
  }
}

class InformalEducation {
  final int id;
  final int userId;
  final String name;
  final String start;
  final String finish;
  final String expired;
  final String type;
  final int duration;
  final int fee;
  final String description;
  final bool certification;

  InformalEducation({
    required this.id,
    required this.userId,
    required this.name,
    required this.start,
    required this.finish,
    required this.expired,
    required this.type,
    required this.duration,
    required this.fee,
    required this.description,
    required this.certification,
  });

  factory InformalEducation.fromJson(Map<String, dynamic> json) {
    return InformalEducation(
      id: json['id'],
      userId: json['userId'],
      name: json['name'],
      start: json['start'],
      finish: json['finish'],
      expired: json['expired'],
      type: json['type'],
      duration: json['duration'],
      fee: json['fee'],
      description: json['description'],
      certification: json['certification'] == 1,
    );
  }
}

class WorkExperience {
  final int id;
  final int userId;
  final String company;
  final String position;
  final String from;
  final String to;
  final String lengthOfService;

  WorkExperience({
    required this.id,
    required this.userId,
    required this.company,
    required this.position,
    required this.from,
    required this.to,
    required this.lengthOfService,
  });

  factory WorkExperience.fromJson(Map<String, dynamic> json) {
    return WorkExperience(
      id: json['id'],
      userId: json['userId'],
      company: json['company'],
      position: json['position'],
      from: json['from'],
      to: json['to'],
      lengthOfService: json['lengthOfService'],
    );
  }
}
