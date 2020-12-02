class Account {
  Account(
      {this.email,
      this.sid,
      this.lastName,
      this.sex,
      this.password,
      this.job,
      this.address,
      this.birthday,
      this.firstName,
      this.phone,
      this.isAdmin});

  final int sid;
  final String lastName;
  final String firstName;
  final String sex;
  final String address;
  final String birthday;
  final String password;
  final String job;
  final String phone;
  final String email;
  final bool isAdmin;

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
        email: json['email_add'] as String,
        sid: json['sid'] as int,
        lastName: json['last_name'] as String,
        firstName: json['first_name'] as String,
        sex: json['sex'] as String,
        address: json['address'] as String,
        birthday: json['birthday'] as String,
        password: json['password'] as String,
        phone: json['phone'] as String,
        job: json['job'] as String);
  }
}
