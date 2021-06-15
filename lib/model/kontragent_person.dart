class KontragentPerson {
  int? id;
  int? userId;
  String? fullName;
  int? status;
  int? ishonch;
  String? address;
  int? omborId;
  dynamic bonus;
  dynamic mfo;
  dynamic oked;
  dynamic inn;
  dynamic shot;
  dynamic bank;
  int? balans;
  int? type;
  String? telNumber1;
  dynamic telNumber2;
  dynamic telNumber3;
  String? description;
  String? createDate;
  String? connectingDate;
  dynamic passport;
  int? kontragent;
  String? birthday;
  dynamic masul;
  String? telNumber;

  KontragentPerson(
      {this.id,
      this.userId,
      this.fullName,
      this.status,
      this.ishonch,
      this.address,
      this.omborId,
      this.bonus,
      this.mfo,
      this.oked,
      this.inn,
      this.shot,
      this.bank,
      this.balans,
      this.type,
      this.telNumber1,
      this.telNumber2,
      this.telNumber3,
      this.description,
      this.createDate,
      this.connectingDate,
      this.passport,
      this.kontragent,
      this.birthday,
      this.masul,
      this.telNumber});

  KontragentPerson.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    fullName = json['full_name'];
    status = json['status'];
    ishonch = json['ishonch'];
    address = json['address'];
    omborId = json['ombor_id'];
    bonus = json['bonus'];
    mfo = json['mfo'];
    oked = json['oked'];
    inn = json['inn'];
    shot = json['shot'];
    bank = json['bank'];
    balans = json['balans'];
    type = json['type'];
    telNumber1 = json['tel_number1'];
    telNumber2 = json['tel_number2'];
    telNumber3 = json['tel_number3'];
    description = json['description'];
    createDate = json['create_date'];
    connectingDate = json['connecting_date'];
    passport = json['passport'];
    kontragent = json['kontragent'];
    birthday = json['birthday'];
    masul = json['masul'];
    telNumber = json['tel_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['full_name'] = this.fullName;
    data['status'] = this.status;
    data['ishonch'] = this.ishonch;
    data['address'] = this.address;
    data['ombor_id'] = this.omborId;
    data['bonus'] = this.bonus;
    data['mfo'] = this.mfo;
    data['oked'] = this.oked;
    data['inn'] = this.inn;
    data['shot'] = this.shot;
    data['bank'] = this.bank;
    data['balans'] = this.balans;
    data['type'] = this.type;
    data['tel_number1'] = this.telNumber1;
    data['tel_number2'] = this.telNumber2;
    data['tel_number3'] = this.telNumber3;
    data['description'] = this.description;
    data['create_date'] = this.createDate;
    data['connecting_date'] = this.connectingDate;
    data['passport'] = this.passport;
    data['kontragent'] = this.kontragent;
    data['birthday'] = this.birthday;
    data['masul'] = this.masul;
    data['tel_number'] = this.telNumber;
    return data;
  }
}
