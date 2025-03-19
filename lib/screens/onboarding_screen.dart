import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "title": "Welcome to Our App",
      "description":
          "Discover amazing features that will make your life easier.",
      "image": "assets/onboarding1.png",
    },
    {
      "title": "Easy to Use",
      "description": "Our app is designed to be simple and intuitive.",
      "image": "assets/onboarding2.png",
    },
    {
      "title": "Get Started",
      "description": "Join us and start your journey today!",
      "image": "assets/onboarding3.png",
    },
  ];

  void _skipOnboarding() {
    // Navigate to the Login Screen
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: onboardingData.length,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemBuilder: (context, index) {
              return OnboardingPage(
                title: onboardingData[index]["title"]!,
                description: onboardingData[index]["description"]!,
                image: onboardingData[index]["image"]!,
              );
            },
          ),
          // Skip Button (Visible on all pages except the last one)
          if (_currentPage != onboardingData.length - 1)
            Positioned(
              top: 40.0,
              right: 20.0,
              child: TextButton(
                onPressed: _skipOnboarding,
                child: Text(
                  "Skip",
                  style: TextStyle(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          // Page Indicator and Get Started Button
          Positioned(
            bottom: 100.0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                SmoothPageIndicator(
                  controller: _pageController,
                  count: onboardingData.length,
                  effect: WormEffect(
                    activeDotColor: const Color.fromARGB(255, 0, 0, 0),
                    dotColor: Colors.grey,
                    dotHeight: 10,
                    dotWidth: 10,
                  ),
                ),
                SizedBox(height: 10),
                if (_currentPage == onboardingData.length - 1)
                  ElevatedButton(
                    onPressed: _skipOnboarding, // Navigate to Login Screen
                    child: Text(
                      "Get Started",
                      style: TextStyle(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final String image;

  OnboardingPage({
    required this.title,
    required this.description,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image, height: 200),
          SizedBox(height: 20),
          Text(
            title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
