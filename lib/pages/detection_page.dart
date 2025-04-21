import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import '../utils/tflite_service.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter_helper_plus/tflite_flutter_helper_plus.dart';

class DetectionPage extends StatefulWidget {
  const DetectionPage({super.key});

  @override
  State<DetectionPage> createState() => _DetectionPageState();
}

class _DetectionPageState extends State<DetectionPage> {
  CameraController? _cameraController;
  List<CameraDescription>? _cameras;
  bool _isCameraInitialized = false;

  late TFLiteService _tfliteService;

  @override
  void initState() {
    super.initState();
    _initCamera();
    _tfliteService = TFLiteService();
    _tfliteService.loadModel();
  }

  Future<void> _initCamera() async {
    _cameras = await availableCameras();
    if (_cameras!.isNotEmpty) {
      _cameraController = CameraController(
        _cameras![0],
        ResolutionPreset.medium,
      );
      await _cameraController!.initialize();
      if (mounted) {
        setState(() {
          _isCameraInitialized = true;
        });
      }
    }
  }

  Future<void> captureAndDetect() async {
    final picture = await _cameraController!.takePicture();
    final file = File(picture.path);
    final bytes = await file.readAsBytes();
    final image = img.decodeImage(bytes)!;
    final resized = img.copyResize(image, width: 224, height: 224);

    final tensorImage = TensorImage.fromImage(
      resized,
    ); // pastikan pakai tflite_flutter_helper

    final result = _tfliteService.runInference(tensorImage);

    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text("Deteksi Rambu"),
            content: Text(result.toString()),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("OK"),
              ),
            ],
          ),
    );
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Detection'),
        backgroundColor: Colors.redAccent,
      ),
      body:
          _isCameraInitialized
              ? Stack(
                children: [
                  CameraPreview(_cameraController!),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: FloatingActionButton.extended(
                        onPressed: captureAndDetect,
                        icon: const Icon(Icons.search),
                        label: const Text("Deteksi Sekarang"),
                        backgroundColor: Colors.redAccent,
                      ),
                    ),
                  ),
                ],
              )
              : const Center(child: CircularProgressIndicator()),
    );
  }
}
