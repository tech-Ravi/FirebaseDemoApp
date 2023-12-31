import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo_application/Screens/UserScreen/login.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => SignInScreen()),
    );
  }

  /*Widget _buildImage(String assetName) {
    return Align(
      child: Image.asset('assets/$assetName.jpg', width: 256.0),
      alignment: Alignment.bottomCenter,
    );
  }*/

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      //  descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          title: "Basic Demo App",
          body: "This is test description, it can be change in production.",
          image: Image(
            image: AssetImage('assets/test.png'),
            height: 100,
            width: 100,
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Firebase",
          body: "This is test description, it can be change in production.",
          image: Image(
            image: AssetImage('assets/test.png'),
            height: 100,
            width: 100,
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Manage Profiles",
          body: "This is test description, it can be change in production.",
          image: Image(
            image: AssetImage('assets/test.png'),
            height: 100,
            width: 100,
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Admin",
          body: "This is test description, it can be change in production.",
          image: const Image(
            image: AssetImage('assets/test.png'),
            height: 100,
            width: 100,
          ),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      //  skipFlex: 0,
      nextFlex: 0,
      skip: const Text('Skip'),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
