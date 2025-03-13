import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: SplashScreen());
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => OnboardingScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset('assets/images/uth_logo.png', width: 200),
          ),
          SizedBox(height: 10),
          Text(
            'UTH SmartTasks',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF167BEA),
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  bool isLastPage = false;
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                isLastPage = index == 2;
                currentPage = index;
              });
            },
            children: [
              OnboardingPage(
                image: 'assets/images/image1.png',
                title: 'Easy Time Management',
                description: 'With management based on priority and daily tasks, it will give you convenience in managing and determining the tasks that must be done first ',
              ),
              OnboardingPage(
                image: 'assets/images/image2.png',
                title: 'Increase Work Effectiveness',
                description: 'Time management and the determination of more important tasks will give your job statistics better and always improve',
              ),
              OnboardingPage(
                image: 'assets/images/image3.png',
                title: 'Reminder Notification',
                description: "The advantage of this application is that it also provides reminders for you so you don't forget to keep doing your assignments well and according to the time you have set",
              ),
            ],
          ),
          Positioned(
            top: 40,
            left: 16,
            child: SmoothPageIndicator(
              controller: _controller,
              count: 3,
              effect: WormEffect(),
            ),
          ),
          Positioned(
            top: 40,
            right: 16,
            child: TextButton(
              onPressed: () => _controller.jumpToPage(2),
              child: Text('Skip', style: TextStyle(fontSize: 16)),
            ),
          ),
          Positioned(
            bottom: 40,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: currentPage == 0 ? MainAxisAlignment.center : MainAxisAlignment.spaceBetween,
              children: [
                if (currentPage > 0)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF2196F3),
                      minimumSize: Size(50, 50),
                      shape: CircleBorder(),
                    ),
                    onPressed: () {
                      _controller.previousPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    },
                    child: Icon(Icons.arrow_back, size: 24, color: Colors.white),
                  ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF2196F3),
                    minimumSize: Size(280, 50),
                  ),
                  onPressed: () {
                    if (isLastPage) {
                      // Điều hướng sang màn hình chính
                    } else {
                      _controller.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    }
                  },
                  child: Text(
                    isLastPage ? 'Get Started' : 'Next',
                    style: TextStyle(color: Colors.white),
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
  final String image;
  final String title;
  final String description;

  OnboardingPage({required this.image, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image, height: 250),
          SizedBox(height: 20),
          Text(
            title,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Text(
            description,
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
