

enum Role {
  system,
  user,
  assistant,
}

class Message {
  int? id;
  String ? conversationId;
  Role role;
  String text;
  Message(
      {this.id,
         this.conversationId,
        required this.text,
        required this.role});
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uuid': conversationId,
      'role': role.index,
      'text': text,
    };
  }

  @override
  String toString() {
    return 'Message{id: $id, conversationId: $conversationId, role: $role, text: $text}';
  }
}