class Message {
  bool? isFirstInSequence;

  String? username;
  String message;

  bool isMe;

  Message.first({
    required this.username,
    required this.message,
    required this.isMe,
  }) : isFirstInSequence = true;

  Message.next({
    required this.message,
    required this.isMe,
  })  : isFirstInSequence = false,
        username = null;

  Message(
      {this.isFirstInSequence,
      this.username,
      required this.message,
      required this.isMe});
}
