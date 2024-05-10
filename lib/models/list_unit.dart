class UnitsResponse {
  final String status;
  final String message;
  final Map<String, String> unitList;

  UnitsResponse({
    required this.status,
    required this.message,
    required this.unitList,
  });

  factory UnitsResponse.fromJson(Map<String, dynamic> json) {
    return UnitsResponse(
      status: json['status'],
      message: json['message'],
      unitList: Map<String, String>.from(json['data']),
    );
  }
}

// import 'dart:convert';

// GetListUnitModel getListUnitModelFromJson(String str) =>
//     GetListUnitModel.fromJson(json.decode(str));

// String getListUnitModelToJson(GetListUnitModel data) =>
//     json.encode(data.toJson());

// class GetListUnitModel {
//   final String? status;
//   final String? message;
//   final UnitList? data;

//   GetListUnitModel({
//     this.status,
//     this.message,
//     this.data,
//   });

//   factory GetListUnitModel.fromJson(Map<String, dynamic> json) =>
//       GetListUnitModel(
//         status: json["status"],
//         message: json["message"],
//         data: json["data"] == null ? null : UnitList.fromJson(json["data"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "message": message,
//         "data": data?.toJson(),
//       };
// }

// class UnitList {
//   final String? kg;
//   final String? pc;
//   final String? pk;
//   final String? dz;
//   final String? lt;

//   UnitList({
//     this.kg,
//     this.pc,
//     this.pk,
//     this.dz,
//     this.lt,
//   });

//   factory UnitList.fromJson(Map<String, dynamic> json) => UnitList(
//         kg: json["KG"],
//         pc: json["PC"],
//         pk: json["PK"],
//         dz: json["DZ"],
//         lt: json["LT"],
//       );

//   Map<String, dynamic> toJson() => {
//         "KG": kg,
//         "PC": pc,
//         "PK": pk,
//         "DZ": dz,
//         "LT": lt,
//       };
// }
