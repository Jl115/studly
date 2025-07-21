class ModelConfigEntity {
  final String provider;
  final String modelName;
  final double temperature;
  final int? maxTokens;
  final double? topP;
  final double? frequencyPenalty;
  final double? presencePenalty;

  const ModelConfigEntity({
    required this.provider,
    required this.modelName,
    required this.temperature,
    this.maxTokens,
    this.topP,
    this.frequencyPenalty,
    this.presencePenalty,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ModelConfigEntity &&
          runtimeType == other.runtimeType &&
          provider == other.provider &&
          modelName == other.modelName &&
          temperature == other.temperature &&
          maxTokens == other.maxTokens &&
          topP == other.topP &&
          frequencyPenalty == other.frequencyPenalty &&
          presencePenalty == other.presencePenalty;

  @override
  int get hashCode =>
      provider.hashCode ^
      modelName.hashCode ^
      temperature.hashCode ^
      maxTokens.hashCode ^
      topP.hashCode ^
      frequencyPenalty.hashCode ^
      presencePenalty.hashCode;

  @override
  String toString() {
    return 'ModelConfigEntity{provider: $provider, modelName: $modelName, temperature: $temperature, maxTokens: $maxTokens, topP: $topP, frequencyPenalty: $frequencyPenalty, presencePenalty: $presencePenalty}';
  }
}
