class Mekan {
  final int mekanID;
  final String mekanAdi;
  final String sehir;
  final double ziyaretciPuani;

  Mekan({
    required this.mekanID,
    required this.mekanAdi,
    required this.sehir,
    required this.ziyaretciPuani,
  });

  factory Mekan.fromJson(Map<String, dynamic> json) {
    return Mekan(
      mekanID: json['mekanID'] ?? json['MekanID'] ?? 0,
      mekanAdi: json['mekanAdi'] ?? json['MekanAdi'] ?? '',
      sehir: json['sehir'] ?? json['Sehir'] ?? '',
      ziyaretciPuani: (json['ziyaretciPuani'] ?? json['ZiyaretciPuani'] ?? 0.0)
          .toDouble(),
    );
  }
}
