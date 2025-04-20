import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import '../utils/tflite_service.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as img;

class DetectionPage extends StatefulWidget {
  const DetectionPage({super.key});

  @override
  State<DetectionPage> createState() => _DetectionPageState();
}

class _DetectionPageState extends State<DetectionPage> {
  CameraController? _cameraController;
  List<CameraDescription>? _cameras;
  bool _isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    _initCamera();
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
                        onPressed: () {
                          // TODO: Implementasi deteksi rambu pakai AI
                        },
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


late TFLiteService _tfliteService;

@override
void initState() {
  super.initState();
  _initCamera();
  _tfliteService = TFLiteService();
  _tfliteService.loadModel();
}

Future<void> captureAndDetect() async {
  final picture = await _cameraController!.takePicture();
  final file = File(picture.path);
  final bytes = await file.readAsBytes();
  final image = img.decodeImage(bytes)!;
  final resized = img.copyResize(image, width: 224, height: 224); // disesuaikan dengan model

  // Convert to TensorImage
  final tensorImage = TensorImage.fromImage(resized);

  final result = _tfliteService.runInference(tensorImage);

  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text("Deteksi Rambu"),
      content: Text(result),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("OK"))
      ],
    ),
  );
}

FloatingActionButton.extended(
  onPressed: captureAndDetect,
  icon: const Icon(Icons.search),
  label: const Text("Deteksi Sekarang"),
  backgroundColor: Colors.redAccent,
)

