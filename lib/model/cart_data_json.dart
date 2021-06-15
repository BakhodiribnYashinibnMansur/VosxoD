class CartDataJson {
  int? id;
  String? name;
  int? parentId;
  int? bobo;
  int? status;
  int? omborId;
  int? foiz;
  int? position;
  int? type;

  CartDataJson(
      {this.id,
      this.name,
      this.parentId,
      this.bobo,
      this.status,
      this.omborId,
      this.foiz,
      this.position,
      this.type});

  CartDataJson.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    parentId = json['parent_id'];
    bobo = json['bobo'];
    status = json['status'];
    omborId = json['ombor_id'];
    foiz = json['foiz'];
    position = json['position'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['parent_id'] = this.parentId;
    data['bobo'] = this.bobo;
    data['status'] = this.status;
    data['ombor_id'] = this.omborId;
    data['foiz'] = this.foiz;
    data['position'] = this.position;
    data['type'] = this.type;
    return data;
  }
}
