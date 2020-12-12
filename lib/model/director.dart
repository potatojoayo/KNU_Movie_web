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
        name: json['director_name'] as String,
        did: json['director_id'] as int,
        birthDay: json['birth_day'] as String,
        passedDay: json['passed_day'] as String,
        profileImage: json['profile_image'] as String);
  }
}
