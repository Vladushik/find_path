class PathDataModel {
  final bool error;
  final String message;
  final List<FieldData> data;

  PathDataModel({
    required this.error,
    required this.message,
    required this.data,
  });

  factory PathDataModel.fromJson(Map<String, dynamic> json) => PathDataModel(
        error: json['error'],
        message: json['message'],
        data: List<FieldData>.from(
            json['data'].map((x) => FieldData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'error': error,
        'message': message,
        'data': List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class FieldData {
  final String id;
  final List<String> field;
  final Point start;
  final Point end;

  FieldData({
    required this.id,
    required this.field,
    required this.start,
    required this.end,
  });

  factory FieldData.fromJson(Map<String, dynamic> json) => FieldData(
        id: json['id'],
        field: List<String>.from(json['field'].map((x) => x)),
        start: Point.fromJson(json['start']),
        end: Point.fromJson(json['end']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'field': List<dynamic>.from(field.map((x) => x)),
        'start': start.toJson(),
        'end': end.toJson(),
      };
}

class Point {
  final int x;
  final int y;

  Point({
    required this.x,
    required this.y,
  });

  factory Point.fromJson(Map<String, dynamic> json) => Point(
        x: json['x'],
        y: json['y'],
      );

  Map<String, dynamic> toJson() => {
        'x': x,
        'y': y,
      };
}
