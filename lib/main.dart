import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Simple Interest Calulator",
    home: SIForm(),
  ));
}

class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SIFormState();
  }
}

class _SIFormState extends State<SIForm> {
  var _formKey = GlobalKey<FormState>();

  var _currencies = ['Rupees', 'Dollors', 'Euros'];
  var _curr = '';

  @override
  void initState() {
    super.initState();
    _curr = _currencies[0];
  }

  var displayresult = '';

  TextEditingController principalController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Simple Interest Calulator"),
      ),
      body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Center(
              child: ListView(
                children: [
                  getImageAsset(),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: principalController,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "Please Enter Principal";
                      }
                    },
                    decoration: InputDecoration(
                        labelText: "Principal",
                        hintText: "Enter Amount",
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.5),
                            borderRadius: BorderRadius.circular(5.0)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.blueAccent, width: 1.5),
                            borderRadius: BorderRadius.circular(5.0)),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.blueAccent, width: 1.5),
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                  Padding(padding: EdgeInsets.all(10.0)),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: roiController,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "Please Enter Rate Of Interest";
                      }
                    },
                    decoration: InputDecoration(
                        labelText: "Rate of Interest",
                        hintText: "Enter Interest",
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.5),
                            borderRadius: BorderRadius.circular(5.0)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.blueAccent, width: 1.5),
                            borderRadius: BorderRadius.circular(5.0)),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.blueAccent, width: 1.5),
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                      child: Row(
                        children: [
                          Expanded(
                              child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: termsController,
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return "Please Enter Terms";
                                    }
                                  },
                                  decoration: InputDecoration(
                                      labelText: "Terms",
                                      hintText: "In Years",
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(2.5),
                                          borderSide: BorderSide(
                                              color: Colors.black, width: 1.5)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black, width: 1.5)),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 1.5),
                                      )))),
                          Container(
                            width: 20.0,
                          ),
                          Expanded(
                              child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black, width: 1.5),
                                      borderRadius: BorderRadius.circular(4.5)),
                                  child: DropdownButton<String>(
                                    hint: Text("Select Currency"),
                                    icon: Icon(Icons.arrow_drop_down),
                                    iconSize: 25.0,
                                    items: _currencies.map((String value) {
                                      return DropdownMenuItem<String>(
                                          value: value, child: Text(value));
                                    }).toList(),
                                    value: _curr,
                                    onChanged: (String? newvalue) {
                                      _dropdownfucntion(newvalue!);
                                    },
                                  )))
                        ],
                      )),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          child: Text("Calculate"),
                          onPressed: () {
                            setState(() {
                              if (_formKey.currentState!.validate()) {
                                this.displayresult = _calculatereturns();
                              }
                            });
                          },
                        ),
                      ),
                      Container(
                        width: 10.0,
                      ),
                      Expanded(
                          child: ElevatedButton(
                        child: Text("Reset"),
                        onPressed: () {
                          setState(() {
                            resetfun();
                          });
                        },
                      ))
                    ],
                  ),
                  Padding(
                      padding: EdgeInsets.all(20.2),
                      child: Text(displayresult)),
                ],
              ),
            ),
          )),
    );
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('images/cal.png');
    Image image = Image(
      image: assetImage,
      width: 120.0,
      height: 120.0,
    );
    return Container(
      child: image,
      margin: EdgeInsets.all(50.0),
    );
  }

  void _dropdownfucntion(String newvalue) {
    setState(() {
      this._curr = newvalue;
    });
  }

  String _calculatereturns() {
    double principal = double.parse(principalController.text);
    double roi = double.parse(roiController.text);
    double terms = double.parse(termsController.text);

    double totalamount = principal + (principal * roi * terms) / 100;
    String result =
        "After $terms years at $roi %  of interest the Total Amount will be $totalamount in $_curr";
    return result;
  }

  void resetfun() {
    principalController.text = '';
    roiController.text = '';
    termsController.text = '';
    displayresult = '';
    _curr = _currencies[0];
  }
}
