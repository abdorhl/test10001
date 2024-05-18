import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:test2figma/nav_bar/search.dart';
import 'package:test2figma/screens/theme.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class HomePage extends StatefulWidget {
  final String? appName;
  final String? appIconPath;
  final Function(String)? onScanPressed;
  final Function(String)? onAppSelected;

  const HomePage({
    super.key,
    this.appName,
    this.appIconPath,
    this.onScanPressed,
    this.onAppSelected,
  });

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isModelLoaded = false;
  bool _isScanning = false;
  late Stopwatch _stopwatch;
  late Timer _timer;

  late Interpreter _interpreter; // Declare interpreter

  @override
  void initState() {
    super.initState();
    loadModel(); // Load the TFLite model when the widget initializes
  }

  @override
  void dispose() {
    // Dispose of the interpreter when the widget is disposed
    _interpreter.close();
    super.dispose();
  }

  Future<void> loadModel() async {
    try {
      final ByteData modelData = await rootBundle.load('assets/model/model.tflite');
      final Uint8List modelBytes = modelData.buffer.asUint8List();
      _interpreter = Interpreter.fromBuffer(modelBytes);
      _isModelLoaded = true;
      print('Model loaded successfully');
    } catch (e) {
      print('Failed to load model: $e');
    }
  }

  Future<void> _analyzeAPK() async {
    setState(() {
      _isScanning = true;
    });

    try {
      // Read APK file as bytes
      final ByteData apkData = await rootBundle.load('assets/apk/calculator.apk');
      final Uint8List apkBytes = apkData.buffer.asUint8List();

      // Construct multipart request
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://192.168.1.23:8000/analyze_apk'),
      );

      // Attach APK file to request
      request.files.add(http.MultipartFile.fromBytes('apk', apkBytes));

      // Send request
      var streamedResponse = await request.send();

      // Get response
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        var responseBody = response.body;
        var result = json.decode(responseBody);
        print('Analysis Result: $result');
        // Show the analysis result
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Analysis Result'),
            content: Text(result.toString()),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else {
        print('Failed to analyze APK: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error analyzing APK: $e');
      _showResultDialog(context, 'Error analyzing APK: $e');
    } finally {
      setState(() {
        _isScanning = false;
      });
    }
  }
  void _showResultDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Analysis Result'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }



  void _startScanTimer() {
    _stopwatch.reset();
    _stopwatch.start();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  void _stopScanTimer() {
    _stopwatch.stop();
    _timer.cancel();
    setState(() {
      _isScanning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final isDarkMode = themeNotifier.isDark;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: isDarkMode ? const Color(0xFF2E2E3D) : const Color.fromARGB(136, 126, 126, 122),
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage('assets/map.png'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.3),
                  BlendMode.darken,
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage('assets/mdbab.png'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  isDarkMode ? const Color(0xFF2E2E3D).withOpacity(0.8) : Colors.white.withOpacity(0.8),
                  BlendMode.darken,
                ),
              ),
            ),
          ),
          const Positioned(
            top: 50,
            left: 20,
            child: Text(
              "Defendozer",
              style: TextStyle(
                fontFamily: 'Urbanist',
                fontSize: 25,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            top: 23,
            right: -6,
            child: Image.asset(
              'assets/logo.png',
              width: 100,
              height: 100,
            ),
          ),
          Positioned(
            bottom: 500,
            left: MediaQuery.of(context).size.width / 2 - 150,
            right: MediaQuery.of(context).size.width / 2 - 150,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FavoritePage()),
                );
              },
              child: Container(
                width: 250,
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isDarkMode ? const Color(0xFF242424) : Colors.grey[300]!,
                    width: 1,
                  ),
                  color: isDarkMode ? const Color(0xFF2E2E3D) : Colors.white,
                ),
                alignment: Alignment.center,
                child: Text(
                  'Choose App',
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 200,
            left: MediaQuery.of(context).size.width / 2 - 163,
            child: GestureDetector(
              onTap: () async {
                if (!_isModelLoaded) {
                  await loadModel();
                } else {
                  print('Model is loaded. Now you can use it for scanning.');
                  // Perform the APK analysis when the circle is tapped
                  await _analyzeAPK();
                }
              },
              child: SizedBox(
                width: 326,
                height: 326,
                child: Stack(
                  children: [
                    Positioned(
                      left: -7,
                      top: -7,
                      child: Opacity(
                        opacity: 0.10,
                        child: Container(
                          width: 340,
                          height: 340,
                          decoration: const ShapeDecoration(shape: OvalBorder()),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 48.76,
                      top: 47.40,
                      child: Opacity(
                        opacity: 0.86,
                        child: Container(
                          width: 229.84,
                          height: 229.84,
                          decoration: const ShapeDecoration(
                            shape: OvalBorder(
                              side: BorderSide(
                                  width: 2.50, color: Color(0xFFD29E1A)),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 100.44,
                      top: 99.08,
                      child: Opacity(
                        opacity: 0.80,
                        child: Container(
                          width: 126.48,
                          height: 126.48,
                          decoration: const ShapeDecoration(
                            color: Color.fromARGB(255, 223, 220, 220),
                            shape: OvalBorder(
                              side: BorderSide(
                                  width: 1, color: Color(0xFFD29E1A)),
                            ),
                          ),
                          child: Center(
                            child: Image.asset(
                              'assets/scanico.png',
                              width: 100,
                              height: 100,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 130,
                      top: 300,
                      child: SizedBox(
                        width: 68,
                        height: 55.64,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              top: 0,
                              child: Text(
                                'Tap to Scan',
                                style: TextStyle(
                                  color: isDarkMode ? Colors.white : Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 100,
                      top: 330,
                      child: Container(
                        width: 149,
                        height: 122,
                        decoration: BoxDecoration(
                          color: const Color(0xFF2E2E3D),
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 260,
                      top: 330,
                      child: Container(
                        width: 149,
                        height: 122,
                        decoration: BoxDecoration(
                          color: const Color(0xFF2E2E3D),
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     if (!_isModelLoaded) {
      //       await loadModel();
      //     } else {
      //       // Start analysis
      //       await _analyzeAPK();
      //     }
      //   },
      //   child: Icon(Icons.play_arrow),
      // ),
    );
  }
}