import 'package:json_annotation/json_annotation.dart';
import 'package:path/path.dart' as path;
import 'dart:io';
import 'dart:convert';

part 'typedoc.g.dart';

@JsonSerializable()
class Node {
  /// The generated code assumes these values exist in JSON.
  final int id;
  final String name;
  final int kind;
  final String? kindString;
  final Map<String, bool> flags;
  final List<Node> children;
  final List<Group> groups;
  final List<Source>? sources;

  Node({
    required this.id,
    required this.name,
    required this.kind,
    required this.flags,
    required this.children,
    required this.groups,
    this.kindString,
    this.sources,
  });

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory Node.fromJson(Map<String, dynamic> json) => _$NodeFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$NodeToJson(this);
}

@JsonSerializable()
class Group {
  final String title;
  final int kind;
  final List<int> children;

  Group({required this.title, required this.kind, required this.children});

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$GroupToJson(this);
}

@JsonSerializable()
class Source {
  final String fileName;
  final int line;
  final List<int> character;

  Source({required this.fileName, required this.line, required this.character});

  factory Source.fromJson(Map<String, dynamic> json) => _$SourceFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$SourceToJson(this);
}

// get the typedoc.json from the repo

Future<Node> getJson() async {
  final current = Directory.current;

  final jsonPath = path.joinAll([current.path, 'docs', 'typedoc.json']);

  File typedocFile = File(jsonPath);

  String typedocString = await typedocFile.readAsString();

  Node parsed = Node.fromJson(jsonDecode(typedocString));

  return parsed;
}
// parse it
// build mdx files from it for each of the types