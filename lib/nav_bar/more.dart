import 'package:flutter/material.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "More",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true, // Center the title in the AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Rating',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w800,
                height: 0.06,
              ),
            ),
            const SizedBox(height: 10),
            _buildRectangleForWriting(),
            const SizedBox(height: 20),
            const Text(
              'Support',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w800,
                height: 0.06,
              ),
            ),
            const SizedBox(height: 10),
            _buildSupportItem(
              context,
              title: 'Help',
              description: 'Get assistance for using the app.',
            ),
            const SizedBox(height: 10),
            _buildSupportItem(
              context,
              title: 'FAQ',
              description: 'Find answers to frequently asked questions.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSupportItem(BuildContext context,
      {required String title, required String description}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: () {
          // Handle onTap
        },
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 166, 166, 175),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                description,
                style: TextStyle(
                  color: Colors.black.withOpacity(0.7),
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRectangleForWriting() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: TextField(
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Write here...',
          ),
        ),
      ),
    );
  }
}
