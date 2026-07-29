import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../services/history_service.dart';
import '../models/qr_item.dart';

class QrImageScreen extends StatefulWidget {
  final String data;

  const QrImageScreen({super.key, required this.data});

  @override
  State<QrImageScreen> createState() => _QrImageScreenState();
}

class _QrImageScreenState extends State<QrImageScreen> {
  @override
  void initState() {
    super.initState();
    _saveToHistory();
  }

  Future<void> _saveToHistory() async {
    final newItem = QRItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      data: widget.data,
      type: 'Generated',
      timestamp: DateTime.now(),
    );
    await HistoryService.saveHistory(newItem); // تم تعديل اسم الدالة لتتوافق مع مشروعك
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('كود الـ QR المولّد'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.3),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: QrImageView(
                  data: widget.data,
                  version: QrVersions.auto,
                  size: 220.0,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                widget.data,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 24),
              const Text(
                'تم حفظ هذا الكود في السجل بنجاح!',
                style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}