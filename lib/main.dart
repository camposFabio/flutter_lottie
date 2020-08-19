import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

//import 'package:fluttie/fluttie.dart';
import 'widgets/form.widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SignupPage(),
    );
  }
}

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> with TickerProviderStateMixin {
  var busy = false;
  var done = false;

  AnimationController animationCtrl;

  @override
  initState() {
    super.initState();
    animationCtrl = AnimationController(vsync: this);
  }

  @override
  dispose() {
    animationCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/done.json',
              controller: animationCtrl,
              onLoaded: (composition) {
                animationCtrl..duration = composition.duration;
              },
            ),
            Visibility(
              child: SubmitForm(busy: busy, func: submit),
              visible: !done,
            ),
          ],
        ),
      ),
    );
  }

  Future<Function> submit() async {
    setState(() {
      busy = true;
    });

    Future.delayed(
      Duration(seconds: 4),
      () => setState(
        () {
          done = true;
          //animationCtrl.start();
          animationCtrl.forward();
        },
      ),
    );
  }
}
