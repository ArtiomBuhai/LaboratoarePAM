import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator Viteză Medie',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        brightness: Brightness.dark,
      ),
      home: SpeedCalculator(),
    );
  }
}

class SpeedCalculator extends StatefulWidget {
  @override
  _SpeedCalculatorState createState() => _SpeedCalculatorState();
}

class _SpeedCalculatorState extends State<SpeedCalculator> with SingleTickerProviderStateMixin {
  final _distanceController = TextEditingController();
  final _timeController = TextEditingController();
  String _result = '';
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..addListener(() {
      setState(() {});
    });
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _distanceController.dispose();
    _timeController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _calculateSpeed() {
    setState(() {
      final distance = double.tryParse(_distanceController.text.replaceAll(',', '.')) ?? 0.0;
      final time = double.tryParse(_timeController.text.replaceAll(',', '.')) ?? 0.0;

      if (distance <= 0 || time <= 0) {
        _result = 'Distanța și timpul trebuie să fie mai mari decât 0';
      } else if (distance.isNaN || time.isNaN) {
        _result = 'Introduceți valori numerice valide';
      } else {
        final speed = distance / time;
        _result = 'Viteza medie: ${speed.toStringAsFixed(2)} km/h';
        _controller.forward(from: 0.0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.teal[800]!, Colors.blue[600]!],
              ),
            ),
            child: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16.0),
                child: Transform.scale(
                  scale: 1.0 + (_controller.value * 0.1),
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    color: Colors.white.withOpacity(0.9),
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Calculator Viteză Medie',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal[700],
                            ),
                          ),
                          SizedBox(height: 20),
                          TextField(
                            controller: _distanceController,
                            keyboardType: TextInputType.numberWithOptions(decimal: true),
                            style: TextStyle(color: Colors.black), // text introdus
                            decoration: InputDecoration(
                              labelText: 'Distanța (km)',
                              labelStyle: TextStyle(color: Colors.black), // label vizibil
                              hintText: 'Introdu distanța',
                              hintStyle: TextStyle(color: Colors.black54), // hint vizibil
                              border: OutlineInputBorder(),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                          SizedBox(height: 16),
                          TextField(
                            controller: _timeController,
                            keyboardType: TextInputType.numberWithOptions(decimal: true),
                            style: TextStyle(color: Colors.black), // text introdus
                            decoration: InputDecoration(
                              labelText: 'Timpul (ore)',
                              labelStyle: TextStyle(color: Colors.black),
                              hintText: 'Introdu timpul',
                              hintStyle: TextStyle(color: Colors.black54),
                              border: OutlineInputBorder(),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: _calculateSpeed,
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                            child: Text('Calculează', style: TextStyle(fontSize: 18)),
                          ),
                          SizedBox(height: 20),
                          Text(
                            _result,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: _result.contains('Viteza') ? Colors.green : Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
