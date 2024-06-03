class Ans {
  String text;
  String photo;
  int views;
  DateTime date = DateTime.now();
  Ans({
    required this.text,
    this.photo = "assets/default.png",
    this.views = 0,
  });
}
