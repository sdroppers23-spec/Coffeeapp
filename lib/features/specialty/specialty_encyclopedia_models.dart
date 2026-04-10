class SpecialtyModule {
  final SpecialtyModuleMetadata metadata;
  final List<Map<String, dynamic>> content;

  const SpecialtyModule({required this.metadata, required this.content});

  factory SpecialtyModule.fromJson(Map<String, dynamic> json) {
    final meta = json['module_metadata'];
    if (meta is! Map<String, dynamic>) {
      throw const FormatException('module_metadata missing');
    }
    final raw = json['content'];
    if (raw is! List) {
      throw const FormatException('content must be a list');
    }
    return SpecialtyModule(
      metadata: SpecialtyModuleMetadata.fromJson(meta),
      content: raw.map((e) => Map<String, dynamic>.from(e as Map)).toList(),
    );
  }
}

class SpecialtyModuleMetadata {
  final String moduleId;
  final String moduleName;
  final int totalPartsEstimate;
  final int currentPart;

  const SpecialtyModuleMetadata({
    required this.moduleId,
    required this.moduleName,
    required this.totalPartsEstimate,
    required this.currentPart,
  });

  factory SpecialtyModuleMetadata.fromJson(Map<String, dynamic> json) {
    return SpecialtyModuleMetadata(
      moduleId: json['module_id']?.toString() ?? '',
      moduleName: json['module_name']?.toString() ?? '',
      totalPartsEstimate: _asInt(json['total_parts_estimate']),
      currentPart: _asInt(json['current_part']),
    );
  }

  static int _asInt(dynamic v) {
    if (v is int) return v;
    if (v is num) return v.toInt();
    return int.tryParse(v?.toString() ?? '') ?? 0;
  }
}

class SpecialtyEncyclopediaRoot {
  final List<SpecialtyModule> modules;

  const SpecialtyEncyclopediaRoot({required this.modules});

  factory SpecialtyEncyclopediaRoot.fromJson(Map<String, dynamic> json) {
    final raw = json['modules'];
    if (raw is! List) {
      throw const FormatException('root.modules missing');
    }
    return SpecialtyEncyclopediaRoot(
      modules: raw
          .map(
            (e) =>
                SpecialtyModule.fromJson(Map<String, dynamic>.from(e as Map)),
          )
          .toList(),
    );
  }
}
