class BitcoinPriceIndex {
  final String updatedTime;
  final Map<String, dynamic> bpi;

  BitcoinPriceIndex({required this.updatedTime, required this.bpi});

  factory BitcoinPriceIndex.fromJson(Map<String, dynamic> json) {
    return BitcoinPriceIndex(
      updatedTime: json['time']['updatedISO'],
      bpi: json['bpi'],
    );
  }
}