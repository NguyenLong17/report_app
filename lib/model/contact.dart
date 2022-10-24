/// id : 1
/// name : "Cubone"
/// avatar : "https://2.pik.vn/202058b029a0-5718-4fce-99a9-6aa1d86cd94f.png"
/// createdDate : "28/02/2015 18:30:15"

class Contact {
  int? id;
  String? name;
  String? avatar;
  String? createdDate;

  Contact({
      this.id, 
      this.name, 
      this.avatar, 
      this.createdDate,});

  Contact.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    avatar = json['avatar'];
    createdDate = json['createdDate'];
  }


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['avatar'] = avatar;
    map['createdDate'] = createdDate;
    return map;
  }

}