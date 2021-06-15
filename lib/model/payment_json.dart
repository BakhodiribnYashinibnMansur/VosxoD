class Payment {
  String? name;
  String? id;
  int? price;
  int? index;

  Payment({this.name, this.id, this.price});

  Payment.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    price = json['price'];
    index = json['index'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['price'] = this.price;
    data['index'] = this.index;
    return data;
  }
}
