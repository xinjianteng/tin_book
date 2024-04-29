import 'package:flutter/cupertino.dart';

/// 组件分页 request
///
class PageListRequestEntity {
  int size = 20;
  int current = 1;

  PageListRequestEntity({
    Key? key,
    required this.size,
    required this.current,
  }) {
    assert(size > 0, "Size must be positive");
    assert(current > 0, "Current must be positive");
  }

  Map<String, dynamic> toJson() => {
        "size": size,
        "current": current,
      };
}

class PageListResponseEntity<T> {
  String? msg;
  int? code;
  String? sign;
  String? nonce;
  Datas? data;

  PageListResponseEntity({
    this.msg,
    this.code,
    this.sign,
    this.nonce,
    this.data,
  });

  factory PageListResponseEntity.fromJson(Map<String, dynamic> json, {required List Function(dynamic x) onDataFormat}) =>
      PageListResponseEntity(
        msg: json["msg"],
        code: json["code"],
        sign: json["sign"],
        nonce: json["nonce"],
        data: Datas.fromJson(json["data"], onDataFormat),
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
        "code": code,
        "sign": sign,
        "nonce": nonce,
        "data": data,
      };
}


class Datas {
  int? total ;
  int? current = 0;
  int? pages = 0;
  int? size = 0;
  List<dynamic>? records = [];

  Datas({
     this.total,
     this.current,
     this.pages,
     this.size,
     this.records,
  }) ;

  factory Datas.fromJson(Map<String, dynamic> json, List Function(dynamic p1) onDataReceived) => Datas(
    total: json["total"] as int,
    current: json["current"]==null? 0: json["current"] as int,
    pages: json["pages"]==null? 0: json["pages"] as int,
    size: json["size"]==null? 0: json["size"] as int,
    records: json["records"] == null
        ? []
        : onDataReceived(json["records"] as List<dynamic>),
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "current": current,
    "pages": pages,
    "size": size,
    "records": records!.map((x) => x.toJson()).toList(),
  };
}
