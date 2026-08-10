class ConsentData {
  final DateTime? date;

  final bool granted;

  final String? iabString;

  final String? source;

  const ConsentData({
    this.date,
    required this.granted,
    this.iabString,
    this.source,
  });

  factory ConsentData.fromMap(Map<String, dynamic> map) {
    final date = map['date'];

    return ConsentData(
      date: date is num ? DateTime.fromMillisecondsSinceEpoch(date.toInt(), isUtc: true) : null,
      granted: map['granted'] == true,
      iabString: map['iabString'] as String?,
      source: map['source'] as String?,
    );
  }
}
