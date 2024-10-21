class Shift {
  final int id;
  final String type;
  final String inTime;
  final String outTime;
  final String patternName;

  Shift({
    required this.id,
    required this.type,
    required this.inTime,
    required this.outTime,
    required this.patternName,
  });

  factory Shift.fromJson(Map<String, dynamic> json) {
    return Shift(
      id: json['id'],
      type: json['type'],
      inTime: json['in'],
      outTime: json['out'],
      patternName: json['patternName'],
    );
  }
}
