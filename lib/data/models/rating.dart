class Rating {
  int id;
  int number;
  String message;

  Rating(this.id, this.number, this.message);

  Rating.zero()
      : id = 0,
        number = 0,
        message = '';

  Rating.fromMap(Map<String, dynamic> data)
      : id = data["id"],
        number = data["number"],
        message = data["message"];
}