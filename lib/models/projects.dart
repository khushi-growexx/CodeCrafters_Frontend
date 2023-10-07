import 'package:intl/intl.dart';

class Projects {
  Projects({this.id, this.name, this.createdAt, this.updatedAt});

  final int? id;
  final String? name;
  final String? createdAt;
  final String? updatedAt;

  factory Projects.fromJson(Map<String, dynamic> json) {
    DateTime created = DateTime.parse(json["created_at"]).toLocal();
    DateFormat outputFormat = DateFormat("dd MMMM y, hh:mm a");
    return Projects(
        id: json["id"],
        name: json["name"],
        createdAt: outputFormat.format(created),
        updatedAt: json["updated_at"]);
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt,
        "updated_at": updatedAt
      };
}
