class CategoryModel {
  String? name;
  String? slug;
  int? parentId;
  String? description;
  int? sort;
  String? languageId;
  String? urlPicture;
  String? urlIcon;
  bool? isPrestige;
  int? iD;

  CategoryModel.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    slug = json['Slug'];
    parentId = json['ParentId'];
    description = json['Description'];
    sort = json['Sort'];
    languageId = json['LanguageId'];
    urlPicture = json['UrlPicture'];
    urlIcon = json['UrlIcon'];
    isPrestige = json['IsPrestige'];
    iD = json['ID'];
  }
}
