import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Simple Interest Calculator",
    home: new SIForm(),
    theme: ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.indigo,
      accentColor: Colors.indigo,
    ),
  ));
}

class SIForm extends StatefulWidget {
  SIForm();

  @override
  State createState() => _SIFormState();
}

class _SIFormState extends State<SIForm> {
  var _currencies = ['Dollars', 'Rupees', 'Yen', 'Others'];
  var _currentItemSelected = 'Rupees';
  final _minPadding = 5.0;
  String finalResult = "";

  final TextEditingController principalController = TextEditingController();
  final TextEditingController roiController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Simple Interest"),
      ),
      body: Form(
        //margin: EdgeInsets.all(_minPadding * 2),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(_minPadding * 10),
                child: Image(
                  image: AssetImage("images/cash.png"),
                  width: 125.0,
                  height: 125.0,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(_minPadding),
                child: TextField(
                  controller: principalController,
                  style: textStyle,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'Principal',
                      labelStyle: textStyle,
                      hintText: 'Enter the Principal Value Here',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0))),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(_minPadding),
                child: TextField(
                  controller: roiController,
                  style: textStyle,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'Rate Of Interest',
                      labelStyle: textStyle,
                      hintText: 'Enter the Rate Of Interest Here',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: timeController,
                        style: textStyle,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: 'Term',
                            labelStyle: textStyle,
                            hintText: 'Enter the Time in Years Here',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0))),
                      ),
                    ),
                    Container(
                      width: _minPadding * 5,
                    ),
                    Expanded(
                      child: DropdownButton<String>(
                        items: _currencies.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        value: _currentItemSelected,
                        onChanged: (String newValueSelected) {
                          setState(() {
                            _currentItemSelected = newValueSelected;
                          });

                          //Code to Execute when a new value is selected
                        },
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).accentColor,
                        textColor: Theme.of(context).primaryColorDark,
                        child: Text(
                          "Calculate",
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          setState(() {
                            this.finalResult = _calculateTotalReturns();
                          });

                        },
                      ),
                    ),
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          "Reset",
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          setState(() {
                                _resetAll();
                              });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                      child: Text(
                        this.finalResult ,
                    style: textStyle,
                  ))),
            ],
          ),
        ),
      ),
    );
  }

  String _calculateTotalReturns() {
    double principal = (double.parse(principalController.text));
    double roi = (double.parse(roiController.text));
    double time = (double.parse(timeController.text));

    double amount = principal + (principal * roi * time) / 100.0;

    String result = "After $time years your investment will be equal to $amount";

    return result;
  }

  void _resetAll(){
    principalController.text = "";
    roiController.text = "";
    timeController.text = "";
    this.finalResult = "";

  }
}
