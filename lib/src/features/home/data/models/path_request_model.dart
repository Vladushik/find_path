class PathRequestModel {
  final String id;
  final Result result;

  PathRequestModel({
    required this.id,
    required this.result,
  });

  factory PathRequestModel.fromJson(Map<String, dynamic> json) =>
      PathRequestModel(
        id: json['id'],
        result: Result.fromJson(json['result']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'result': result.toJson(),
      };
}

class Result {
  final List<Step> steps;
  final String path;

  Result({
    required this.steps,
    required this.path,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        steps: List<Step>.from(json['steps'].map((x) => Step.fromJson(x))),
        path: json['path'],
      );

  Map<String, dynamic> toJson() => {
        'steps': List<dynamic>.from(steps.map((x) => x.toJson())),
        'path': path,
      };
}

class Step {
  final String x;
  final String y;

  Step({
    required this.x,
    required this.y,
  });

  factory Step.fromJson(Map<String, dynamic> json) => Step(
        x: json['x'],
        y: json['y'],
      );

  Map<String, dynamic> toJson() => {
        'x': x,
        'y': y,
      };
}
