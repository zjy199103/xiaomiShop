///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class FocusModelResult {
/*
{
  "_id": "59f6ef443ce1fb0fb02c7a43",
  "title": "米家智能空气炸烤箱",
  "status": "1",
  "pic": "public\\upload\\zon0TTXnXUs1z5meqZhP5aNF.png",
  "url": "12",
  "position": 1
} 
*/

  String? sId;
  String? title;
  String? status;
  String? pic;
  String? url;
  int? position;

  FocusModelResult({
    this.sId,
    this.title,
    this.status,
    this.pic,
    this.url,
    this.position,
  });
  FocusModelResult.fromJson(Map<String, dynamic> json) {
    sId = json['_id']?.toString();
    title = json['title']?.toString();
    status = json['status']?.toString();
    pic = json['pic']?.toString();
    url = json['url']?.toString();
    position = json['position']?.toInt();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['status'] = status;
    data['pic'] = pic;
    data['url'] = url;
    data['position'] = position;
    return data;
  }
}

class FocusModel {
/*
{
  "result": [
    {
      "_id": "59f6ef443ce1fb0fb02c7a43",
      "title": "米家智能空气炸烤箱",
      "status": "1",
      "pic": "public\\upload\\zon0TTXnXUs1z5meqZhP5aNF.png",
      "url": "12",
      "position": 1
    }
  ]
} 
*/

  List<FocusModelResult?>? result;

  FocusModel({
    this.result,
  });
  FocusModel.fromJson(Map<String, dynamic> json) {
  if (json['result'] != null) {
  final v = json['result'];
  final arr0 = <FocusModelResult>[];
  v.forEach((v) {
  arr0.add(FocusModelResult.fromJson(v));
  });
    result = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (result != null) {
      final v = result;
      final arr0 = [];
  for (var v in v!) {
  arr0.add(v!.toJson());
  }
      data['result'] = arr0;
    }
    return data;
  }
}
