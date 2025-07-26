import '../../domain/entities/model_config_entity.dart';

class ModelConfigModel extends ModelConfigEntity {
  const ModelConfigModel({
    required super.provider,
    required super.modelName,
    required super.temperature,
    super.maxTokens,
    super.topP,
    super.frequencyPenalty,
    super.presencePenalty,
  });

  factory ModelConfigModel.fromJson(Map<String, dynamic> json) {
    return ModelConfigModel(
      provider: json['provider'] as String,
      modelName: json['modelName'] as String,
      temperature: (json['temperature'] as num).toDouble(),
      maxTokens: json['maxTokens'] as int?,
      topP: json['topP'] != null ? (json['topP'] as num).toDouble() : null,
      frequencyPenalty: json['frequencyPenalty'] != null
          ? (json['frequencyPenalty'] as num).toDouble()
          : null,
      presencePenalty: json['presencePenalty'] != null
          ? (json['presencePenalty'] as num).toDouble()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'provider': provider,
      'modelName': modelName,
      'temperature': temperature,
      'maxTokens': maxTokens,
      'topP': topP,
      'frequencyPenalty': frequencyPenalty,
      'presencePenalty': presencePenalty,
    };
  }

  factory ModelConfigModel.fromEntity(ModelConfigEntity entity) {
    return ModelConfigModel(
      provider: entity.provider,
      modelName: entity.modelName,
      temperature: entity.temperature,
      maxTokens: entity.maxTokens,
      topP: entity.topP,
      frequencyPenalty: entity.frequencyPenalty,
      presencePenalty: entity.presencePenalty,
    );
  }

  @override
  String toString() {
    return 'ModelConfigModel{provider: $provider, modelName: $modelName, temperature: $temperature, maxTokens: $maxTokens, topP: $topP, frequencyPenalty: $frequencyPenalty, presencePenalty: $presencePenalty}';
  }
}
