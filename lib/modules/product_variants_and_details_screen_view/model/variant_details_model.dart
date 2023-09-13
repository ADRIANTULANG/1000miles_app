import 'dart:convert';

VariantDetailsModel variantDetailsModelFromJson(String str) =>
    VariantDetailsModel.fromJson(json.decode(str));

String variantDetailsModelToJson(VariantDetailsModel data) =>
    json.encode(data.toJson());

class VariantDetailsModel {
  VariantDetailsModel({
    required this.id,
    this.name,
    required this.cellValues,
  });

  int id;
  String? name;
  List<CellValue> cellValues;

  factory VariantDetailsModel.fromJson(Map<String, dynamic> json) =>
      VariantDetailsModel(
        id: json["id"],
        name: json["name"] == null ? "" : json["name"],
        cellValues: List<CellValue>.from(
            json["cell_values"].map((x) => CellValue.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "cell_values": List<dynamic>.from(cellValues.map((x) => x.toJson())),
      };
}

class CellValue {
  CellValue({
    required this.id,
    required this.variantRow,
    required this.value,
    required this.createdBy,
    required this.active,
    required this.dateCreate,
    required this.dateWrite,
  });

  int id;
  VariantRow variantRow;
  String value;
  int createdBy;
  bool active;
  DateTime dateCreate;
  DateTime dateWrite;

  factory CellValue.fromJson(Map<String, dynamic> json) => CellValue(
        id: json["id"],
        variantRow: VariantRow.fromJson(json["variant_row"]),
        value: json["value"],
        createdBy: json["created_by"],
        active: json["active"],
        dateCreate: DateTime.parse(json["date_create"]),
        dateWrite: DateTime.parse(json["date_write"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "variant_row": variantRow.toJson(),
        "value": value,
        "created_by": createdBy,
        "active": active,
        "date_create": dateCreate.toIso8601String(),
        "date_write": dateWrite.toIso8601String(),
      };
}

class VariantRow {
  VariantRow({
    required this.id,
    required this.name,
    required this.createdBy,
    required this.product,
    required this.variants,
    required this.isPrice,
    required this.custom,
    required this.isSupplier,
    this.currency,
    required this.dateCreate,
    required this.dateWrite,
    required this.active,
  });

  int id;
  String name;
  int createdBy;
  int product;
  List<int> variants;
  bool isPrice;
  bool custom;
  bool isSupplier;
  int? currency;
  DateTime dateCreate;
  DateTime dateWrite;
  bool active;

  factory VariantRow.fromJson(Map<String, dynamic> json) => VariantRow(
        id: json["id"],
        name: json["name"],
        createdBy: json["created_by"],
        product: json["product"],
        variants: List<int>.from(json["variants"].map((x) => x)),
        isPrice: json["is_price"],
        custom: json["custom"],
        isSupplier: json["is_supplier"],
        currency: json["currency"] == null ? null : json["currency"],
        dateCreate: DateTime.parse(json["date_create"]),
        dateWrite: DateTime.parse(json["date_write"]),
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_by": createdBy,
        "product": product,
        "variants": List<dynamic>.from(variants.map((x) => x)),
        "is_price": isPrice,
        "custom": custom,
        "is_supplier": isSupplier,
        "currency": currency == null ? null : currency,
        "date_create": dateCreate.toIso8601String(),
        "date_write": dateWrite.toIso8601String(),
        "active": active,
      };
}
