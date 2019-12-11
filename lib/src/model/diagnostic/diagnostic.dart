import 'package:json_annotation/json_annotation.dart';

part 'diagnostic.g.dart';

@JsonSerializable()
class Diagnostic {
  int status;
  String message;
  @JsonKey(name: 'unix_timestamp')
  int unixTimestamp;
  @JsonKey(ignore: true)
  String error;

  Diagnostic(this.status, this.message, this.unixTimestamp);

  factory Diagnostic.fromJson(Map<String, dynamic> json) => _$DiagnosticFromJson(json);

  Diagnostic.withError(this.error);

  Map<String, dynamic> toJson() => _$DiagnosticToJson(this);

  @override
  String toString() {
    return 'Diagnostic{status: $status, message: $message, unixTimestamp: $unixTimestamp}';
  }
}
