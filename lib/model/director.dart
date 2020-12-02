class Director {
  Director(
      {this.name, this.did, this.birthDay, this.passedDay, this.profileImage});
  final name;
  final did;
  final birthDay;
  final passedDay;
  final profileImage;

  factory Director.fromJson(Map<String, dynamic> json) {
    return Director(
        name: json['name'] as String,
        did: json['director_id'] as int,
        birthDay: json['birth_day'] as int,
        passedDay: json['passed_day'] as int,
        profileImage: json['profile_image'] as String);
  }
}
