import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:tflite_flutter_helper_plus/tflite_flutter_helper_plus.dart';

class TFLiteService {
  late Interpreter _interpreter;
  late List<String> _labels;
  late ImageProcessor _imageProcessor;

  final int inputSize = 224; // Disesuaikan dengan model kamu

  Future<void> loadModel() async {
    _interpreter = await Interpreter.fromAsset(
      'assets/model/rambu_model.tflite',
    );
    _labels = await FileUtil.loadLabels('assets/model/labels.txt');
  }

  TensorImage preprocessImage(CameraImage image) {
    // Di sini harus konversi dari format kamera ke TensorImage
    // untuk demo, asumsi pakai gambar dari file sementara
    // Ini placeholder
    return TensorImage.fromTensorBuffer(
      TensorBuffer.createFixedSize([
        1,
        inputSize,
        inputSize,
        3,
      ], TfLiteType.uint8),
    );
  }

  String runInference(TensorImage inputImage) {
    var input = inputImage.buffer;
    var output = List.filled(
      1 * _labels.length,
      0.0,
    ).reshape([1, _labels.length]);

    _interpreter.run(input, output);

    // Cari index tertinggi
    int maxIndex = 0;
    double maxConfidence = 0.0;
    for (int i = 0; i < _labels.length; i++) {
      if (output[0][i] > maxConfidence) {
        maxIndex = i;
        maxConfidence = output[0][i];
      }
    }

    return "${_labels[maxIndex]} (${(maxConfidence * 100).toStringAsFixed(1)}%)";
  }
}
