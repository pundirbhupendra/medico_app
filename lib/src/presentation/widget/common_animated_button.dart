 import 'dart:async';

import 'package:flutter/material.dart';
import 'package:medico_app/src/res/app_color.dart';
class ProgressButton extends StatefulWidget {
  ProgressButton({
    Key key, 
     @required this.title,
     this.state,
    this.onTap,
      this.textStyle,
      this.buttonColor,
      this.titleColor,
      this.width,
      this.height,
     
    
    }) : super(key: key);

  final String title;
  final state;
  final VoidCallback onTap;
  final TextStyle textStyle;
  final Color buttonColor;
  final double width;
  final double height;
  final Color titleColor;

  @override
  _ProgressButtonState createState() => _ProgressButtonState();
}

class _ProgressButtonState extends State<ProgressButton>
    with TickerProviderStateMixin {
  int _state = 0;
  Animation _animation;
  AnimationController _controller;
  GlobalKey _globalKey = GlobalKey();
  double _width = double.maxFinite;

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
       key: _globalKey,
      child: ButtonTheme(
        minWidth: widget.width ?? MediaQuery.of(context).size.width * 0.6,
       
        height:  widget.height ?? 40,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)),
        child: MaterialButton(
         color:  widget. buttonColor ?? Colors.white,
          onPressed: () {
            if ( widget.onTap != null) {
              setState(() {
            if (_state == 0) {
              animateButton();
            }
          });
               widget.onTap();
            }
          },
          child: setUpButtonChild(),
          
        ),
      ),
    );
    // return Container(
    //   key: _globalKey,
    //   height: 48,
    //   width: _width,
    //   child: RaisedButton(
    //     animationDuration: Duration(milliseconds: 1000),
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(25),
    //     ),
    //     padding: EdgeInsets.all(0),
    //     child: setUpButtonChild(),
    //     onPressed: () {
    //       setState(() {
    //         if (_state == 0) {
    //           animateButton();
    //         }
    //       });
    //     },
    //     elevation: 4,
    //     color: Colors.white,
    //   ),
    // );
  }

  ///
  ///
  ///
  setUpButtonChild() {
    if (_state == 0) {
      return Text(widget.title,
              style: TextStyle(
                color:  widget.titleColor ?? Colors.white,
              ));
    } else if (_state == 1) {
      return Center(
        child: CircularProgressIndicator(
          value: null,
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
        ),
      );
    } else {
      return Icon(Icons.check, color: Colors.black);
    }
  }

  void animateButton() {
    double initialWidth = _globalKey.currentContext.size.width;

    _controller =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);

    _animation = Tween(begin: 0.0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {
          _width = initialWidth - ((initialWidth - 48) * _animation.value);
        });
      });
    _controller.forward();

    setState(() {
      _state = 1;
    });

    Timer(Duration(milliseconds: 3300), () {
      setState(() {
        _state = widget.state;
      });
    });
  }}