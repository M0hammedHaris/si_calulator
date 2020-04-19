import 'package:flutter/material.dart';
import '../data/data.dart';
import 'package:calc_core/calc.dart';

class MaterialCalculator extends StatefulWidget {
  @override
  _MaterialCalculatorState createState() => _MaterialCalculatorState();
}

class _MaterialCalculatorState extends State<MaterialCalculator> {
  var valueEntered = '', answer = '';

  var numList = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];

  Calculator calc = Calculator();

  var themeData;
  bool themeChange = false;

  addDigit(int digit) {
    setState(() {
      calc.addDigit(digit);
      valueEntered = calc.text;
    });
  }

  addPoint() {
    setState(() {
      calc.addPoint();
      valueEntered = calc.text;
    });
  }

  addSum() {
    setState(() {
      calc.setAdditionOperator();
      valueEntered = calc.text;
    });
  }

  addSub() {
    setState(() {
      calc.setSubtranctionOperator();
      valueEntered = calc.text;
    });
  }

  addProduct() {
    setState(() {
      calc.setProductOperator();
      valueEntered = calc.text;
    });
  }

  addDiv() {
    setState(() {
      calc.setDivisinOperator();
      valueEntered = calc.text;
    });
  }

  backspace() {
    setState(() {
      calc.backspace();
      valueEntered = calc.text;
    });
  }

  clear() {
    setState(() {
      calc.clear();
      valueEntered = calc.text;
    });
  }

  operate() {
    setState(() {
      calc.operate();
      answer = calc.text;
    });
  }

  void onButtonPressed(value) {
    if (value == 'C') {
      setState(() {
        answer = '';
        clear();
      });
    } else if (value == 'backSpace') {
      backspace();
    } else if (value == '=') {
      operate();
    } else if (value == '.') {
      addPoint();
    } else if (numList.contains(value)) {
      addDigit(value);
    } else if (value == 'themeChange') {
      setState(() {
        themeChange ? themeData = new DayTheme() : themeData = new NightTheme();
        themeChange = !themeChange;
      });
    } else if (value == 'menu') {
      print("menu");
    } else {
      switch (value) {
        case '+':
          addSum();
          break;
        case '-':
          addSub();
          break;
        case 'x':
          addProduct();
          break;
        case '÷':
          addDiv();
          break;
        default:
          print(value);
      }
    }
  }

  Widget materialShadowButton(
      {child,
      childId,
      childColor,
      buttonBgColor,
      primaryShadowColor,
      secondaryShadowColor,
      height = 70.0,
      width = 70.0}) {
    if (childId == null) {
      childId = child;
    }
    return GestureDetector(
      onTap: () {
        if (child == childId) {
          onButtonPressed(child);
        } else {
          onButtonPressed(childId);
        }
      },
      child: Container(
        height: height,
        width: width,
        child: Center(
          child: child.runtimeType != IconData
              ? Text(
                  child.toString(),
                  style: TextStyle(
                      color: childColor,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold),
                )
              : Icon(
                  child,
                  color: childColor,
                ),
        ),
        decoration: BoxDecoration(
            color: buttonBgColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                  color: primaryShadowColor,
                  offset: Offset(-4.0, -4.0),
                  blurRadius: 10.0,
                  spreadRadius: 1),
              BoxShadow(
                  color: secondaryShadowColor,
                  offset: Offset(4.0, 4.0),
                  blurRadius: 15.0,
                  spreadRadius: 1.5),
            ]),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    themeData = new DayTheme();
  }

  @override
  void dispose() {
    themeData = new DayTheme();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: themeData.primaryBgColor,
      body: Column(
        children: <Widget>[
          Container(
            height: height * 0.35,
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 15.0),
                  height: height * 0.35 * 0.25,
                  width: width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      materialShadowButton(
                        child: Icons.menu,
                        childId: 'menu',
                        childColor: themeData.themeIconColor,
                        primaryShadowColor: themeData.primaryShadowColor,
                        secondaryShadowColor: themeData.secondaryShadowColor,
                        buttonBgColor: themeData.primaryButtonColor,
                        height: 40.0,
                        width: 40.0,
                      ),
                      materialShadowButton(
                        child: themeData.themeIcon,
                        childId: 'themeChange',
                        childColor: themeData.themeIconColor,
                        primaryShadowColor: themeData.primaryShadowColor,
                        secondaryShadowColor: themeData.secondaryShadowColor,
                        buttonBgColor: themeData.primaryButtonColor,
                        height: 40.0,
                        width: 40.0,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 8.0),
                  height: height * 0.35 * 0.30,
                  width: width,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      valueEntered != '' ? valueEntered : '0',
                      textAlign: TextAlign.left,
                      textScaleFactor: 1.8,
                      style: TextStyle(color: themeData.primaryIconColor),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: 8.0),
                    width: width,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        answer != '' ? answer : '0',
                        textScaleFactor: 3.5,
                        style: TextStyle(color: themeData.secondaryIconColor),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      materialShadowButton(
                          child: "C",
                          childColor: themeData.secondaryIconColor,
                          primaryShadowColor: themeData.primaryShadowColor,
                          secondaryShadowColor: themeData.secondaryShadowColor,
                          buttonBgColor: themeData.primaryButtonColor),
                      materialShadowButton(
                          child: "+/-",
                          childColor: themeData.secondaryIconColor,
                          primaryShadowColor: themeData.primaryShadowColor,
                          secondaryShadowColor: themeData.secondaryShadowColor,
                          buttonBgColor: themeData.primaryButtonColor),
                      materialShadowButton(
                          child: "%",
                          childColor: themeData.secondaryIconColor,
                          primaryShadowColor: themeData.primaryShadowColor,
                          secondaryShadowColor: themeData.secondaryShadowColor,
                          buttonBgColor: themeData.primaryButtonColor),
                      materialShadowButton(
                          child: "÷",
                          childColor: themeData.secondaryIconColor,
                          primaryShadowColor: themeData.primaryShadowColor,
                          secondaryShadowColor: themeData.secondaryShadowColor,
                          buttonBgColor: themeData.primaryButtonColor)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      materialShadowButton(
                          child: 7,
                          childColor: themeData.primaryIconColor,
                          primaryShadowColor: themeData.primaryShadowColor,
                          secondaryShadowColor: themeData.secondaryShadowColor,
                          buttonBgColor: themeData.primaryButtonColor),
                      materialShadowButton(
                        child: 8,
                        childColor: themeData.primaryIconColor,
                        primaryShadowColor: themeData.primaryShadowColor,
                        secondaryShadowColor: themeData.secondaryShadowColor,
                        buttonBgColor: themeData.primaryButtonColor,
                      ),
                      materialShadowButton(
                          child: 9,
                          childColor: themeData.primaryIconColor,
                          primaryShadowColor: themeData.primaryShadowColor,
                          secondaryShadowColor: themeData.secondaryShadowColor,
                          buttonBgColor: themeData.primaryButtonColor),
                      materialShadowButton(
                          child: "x",
                          childColor: themeData.secondaryIconColor,
                          primaryShadowColor: themeData.primaryShadowColor,
                          secondaryShadowColor: themeData.secondaryShadowColor,
                          buttonBgColor: themeData.primaryButtonColor)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      materialShadowButton(
                          child: 4,
                          childColor: themeData.primaryIconColor,
                          primaryShadowColor: themeData.primaryShadowColor,
                          secondaryShadowColor: themeData.secondaryShadowColor,
                          buttonBgColor: themeData.primaryButtonColor),
                      materialShadowButton(
                          child: 5,
                          childColor: themeData.primaryIconColor,
                          primaryShadowColor: themeData.primaryShadowColor,
                          secondaryShadowColor: themeData.secondaryShadowColor,
                          buttonBgColor: themeData.primaryButtonColor),
                      materialShadowButton(
                          child: 6,
                          childColor: themeData.primaryIconColor,
                          primaryShadowColor: themeData.primaryShadowColor,
                          secondaryShadowColor: themeData.secondaryShadowColor,
                          buttonBgColor: themeData.primaryButtonColor),
                      materialShadowButton(
                          child: "-",
                          childColor: themeData.secondaryIconColor,
                          primaryShadowColor: themeData.primaryShadowColor,
                          secondaryShadowColor: themeData.secondaryShadowColor,
                          buttonBgColor: themeData.primaryButtonColor)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      materialShadowButton(
                          child: 1,
                          childColor: themeData.primaryIconColor,
                          primaryShadowColor: themeData.primaryShadowColor,
                          secondaryShadowColor: themeData.secondaryShadowColor,
                          buttonBgColor: themeData.primaryButtonColor),
                      materialShadowButton(
                          child: 2,
                          childColor: themeData.primaryIconColor,
                          primaryShadowColor: themeData.primaryShadowColor,
                          secondaryShadowColor: themeData.secondaryShadowColor,
                          buttonBgColor: themeData.primaryButtonColor),
                      materialShadowButton(
                          child: 3,
                          childColor: themeData.primaryIconColor,
                          primaryShadowColor: themeData.primaryShadowColor,
                          secondaryShadowColor: themeData.secondaryShadowColor,
                          buttonBgColor: themeData.primaryButtonColor),
                      materialShadowButton(
                          child: "+",
                          childColor: themeData.secondaryIconColor,
                          primaryShadowColor: themeData.primaryShadowColor,
                          secondaryShadowColor: themeData.secondaryShadowColor,
                          buttonBgColor: themeData.primaryButtonColor)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      materialShadowButton(
                          child: Icons.arrow_back,
                          childId: "backSpace",
                          childColor: themeData.secondaryIconColor,
                          primaryShadowColor: themeData.primaryShadowColor,
                          secondaryShadowColor: themeData.secondaryShadowColor,
                          buttonBgColor: themeData.primaryButtonColor),
                      materialShadowButton(
                          child: 0,
                          childColor: themeData.primaryIconColor,
                          primaryShadowColor: themeData.primaryShadowColor,
                          secondaryShadowColor: themeData.secondaryShadowColor,
                          buttonBgColor: themeData.primaryButtonColor),
                      materialShadowButton(
                          child: ".",
                          childColor: themeData.secondaryIconColor,
                          primaryShadowColor: themeData.primaryShadowColor,
                          secondaryShadowColor: themeData.secondaryShadowColor,
                          buttonBgColor: themeData.primaryButtonColor),
                      materialShadowButton(
                          child: "=",
                          childColor: Colors.white,
                          primaryShadowColor: themeData.primaryShadowColor,
                          secondaryShadowColor: themeData.secondaryShadowColor,
                          buttonBgColor: themeData.secondaryIconColor)
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
