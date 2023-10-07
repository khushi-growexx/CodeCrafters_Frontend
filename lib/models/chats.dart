class Chats {
  Chats({this.id, this.input, this.output});

  final int? id;
  final String? input;
  final String? output;

  factory Chats.fromJson(Map<String, dynamic> json) {
    return Chats(
        id: json["chat_id"],
        input: json["input"],
        output: json["output"]);
  }

  Map<String, dynamic> toJson() => {
        "chat_id": id,
        "input": input,
        "output": output
      };
}
