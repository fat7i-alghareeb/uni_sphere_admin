class GlobalPatch {
  List<Patch> patches;

  GlobalPatch({required this.patches});

  List<Map<String, dynamic>> toJson() {
    return patches.map((patch) => patch.toJson()).toList();
  }
}

class Patch {
  String path;
  String op;
  String from;
  dynamic value;

  Patch({
    required this.path,
    required this.op,
    required this.from,
    required this.value,
  });

  Map<String, dynamic> toJson() {
    return {
      'path': path,
      'op': op,
      'from': from,
      'value': value,
    };
  }
}
