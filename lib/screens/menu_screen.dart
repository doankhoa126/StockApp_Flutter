import 'package:flutter/material.dart';
import 'highest_increase_screen.dart';
import 'highest_decrease_screen.dart';
import 'highest_volume_screen.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.greenAccent, Colors.blueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildMenuButton(
                context,
                'Highest Increase Stocks',
                HighestIncreaseScreen(),
              ),
              const SizedBox(height: 20),
              _buildMenuButton(
                context,
                'Highest Decrease Stocks',
                HighestDecreaseScreen(),
              ),
              const SizedBox(height: 20),
              _buildMenuButton(
                context,
                'Highest Volume Stocks',
                HighestVolumeScreen(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context, String text, Widget screen) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: const Color.fromARGB(255, 2, 166, 7), backgroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12), 
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 5, 
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
      child: Text(text, style: const TextStyle(fontSize: 18)),
    );
  }
}
