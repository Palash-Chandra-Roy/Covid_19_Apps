import 'dart:async';
import 'package:covid19_apps/World_Screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math'as math;


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin{

  late final AnimationController _controller =AnimationController(
    duration: const Duration(seconds: 3),
      vsync: this)..repeat();

  void dispose(){
   super.dispose();
  _controller.dispose();
  }
  @override
  void initState(){
    super.initState();

    Timer(const Duration(seconds: 5),
        ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>WorldScreen()))
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBuilder(
                animation: _controller,
                child: Container(
                  height: 200,
                  width: 200,
                  child: const Center(
                    child: Image(image: AssetImage('image/assets/logos.png')),
                  ),
                ),
                builder: (BuildContext context,Widget? child){
                  return Transform.rotate(
                      angle: _controller.value *2.0 *math.pi,
                  child: child,
                  );
                }),
            SizedBox(height: MediaQuery.of(context).size.height *.08,),
           const Align(
             alignment: Alignment.center,
               child: Text('Covid 19\nTracker App',textAlign: TextAlign.center,
               style: TextStyle(
                 fontWeight: FontWeight.bold,
                 fontSize: 25,
               ),)),
          ],
        ),
      ),
    );
  }
}
