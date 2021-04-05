class RandomNumber {
  int dateTime;
  int randomNumber;
  String userId;

  RandomNumber({
    this.dateTime,
    this.randomNumber,
    this.userId,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'randomNumber': randomNumber,
      'dateTime': dateTime
    };
  }

  RandomNumber.fromJson(Map<dynamic, dynamic> json) {
    this.userId = json['userId'];
    this.randomNumber = json['randomNumber'];
    this.dateTime = json['dateTime'];
  }
}
