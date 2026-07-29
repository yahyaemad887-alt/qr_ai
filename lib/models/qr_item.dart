class QRItem {
  final String id;
  final String data;
  final String type;
  final DateTime timestamp;

  QRItem({
    required this.id,
    required this.data,
    required this.type,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'data': data,
    'type': type,
    'timestamp': timestamp.toIso8601String(),
  };

  factory QRItem.fromJson(Map<String, dynamic> json) => QRItem(
    id: json['id'],
    data: json['data'],
    type: json['type'],
    timestamp: DateTime.parse(json['timestamp']),
  );
}