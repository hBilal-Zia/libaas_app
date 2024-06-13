class Recommendation {
  final String bottomwearId;
  final String bottomwearImageUrl;
  final String footwearId;
  final String footwearImageUrl;
  final String topImageUrl;
  final String topwearId;

  Recommendation({
    required this.bottomwearId,
    required this.bottomwearImageUrl,
    required this.footwearId,
    required this.footwearImageUrl,
    required this.topImageUrl,
    required this.topwearId,
  });

  factory Recommendation.fromJson(Map<String, dynamic> json) {
    return Recommendation(
      bottomwearId: json['bottomwearId'] ?? '',
      bottomwearImageUrl: json['bottomwearImageUrl'] ?? '',
      footwearId: json['footwearId'] ?? '',
      footwearImageUrl: json['footwearImageUrl'] ?? '',
      topImageUrl: json['topImageUrl'] ?? '',
      topwearId: json['topwearId'] ?? '',
    );
  }
}
