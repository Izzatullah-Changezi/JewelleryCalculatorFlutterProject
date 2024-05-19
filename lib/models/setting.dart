const String tableSetting = 'settings';

class SettingFields {
  static const String id = "_id";
  static const String sname = "sname";
  static const String name = "name";
  static const String types = "types";
  static const String val = "val";
  static const String isPure = "isPure";
}

class Setting {
  final int? id;
  final String sname, name;
  final String types;
  final double val;
  final int isPure;

  const Setting(
      {this.id,
      required this.sname,
      required this.name,
      required this.types,
      required this.val,
      this.isPure = 0});

  Map<String, Object?> toJson() => {
        SettingFields.id: id,
        SettingFields.sname: sname,
        SettingFields.name: name,
        SettingFields.types: types,
        SettingFields.val: val,
        SettingFields.isPure: isPure,
      };

  Setting copy(
          {int? id,
          String? sname,
          String? name,
          String? types,
          double? val,
          int? isPure}) =>
      Setting(
          id: id ?? this.id,
          sname: this.sname,
          name: this.name,
          types: this.types,
          val: this.val,
          isPure: this.isPure);
}
