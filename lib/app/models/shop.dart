class ShopModel {
  String? sId;

  ShopModel.formJson(Map<String,dynamic> json) {
    sId = json['_id'];
  }
 
}