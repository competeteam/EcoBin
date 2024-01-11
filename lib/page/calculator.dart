import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xF9212121),
      body: ListView(
        padding: EdgeInsets.only(top: 68, left: 34, right: 34),
        // mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Text(
            'Calculator',
            style: TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              height: 0,
            ),
          ),

          Text(
            'Find out your impact on this planet.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w300,
              height: 0,
            ),
          ),
          SizedBox(
            height: 34,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: [
                  Text(
                    'Annual Carbon Footprint',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                  SizedBox(height: 9,),
                  CircleAvatar(
                    radius: 75,
                    backgroundColor: Color(0xFF5B8A62),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '99.99\n',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 45,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                          TextSpan(
                            text: 'tonnes',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
              Spacer(),
              Column(
                children: [
                  Text(
                    'Renewable Energy',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                  SizedBox(height: 9,),
                  CircleAvatar(
                      radius: 50,
                      backgroundColor: Color(0xFF5B8A62),
                      child: Text(
                        '100%',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      )
                  )
                ],
              ),
            ],
          ),
          SizedBox(
            height: 34,
          ),
          Text(
            "Calculate Footprint",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
          Divider(),

          CalculatorInputField(
            wasteType: "Organic Waste",
          ),
          CalculatorInputField(
            wasteType: "Plastic Waste",
          ),
          CalculatorInputField(
            wasteType: "Paper Waste",
          ),
          CalculatorInputField(
            wasteType: "Metal Waste",
          ),
          CalculatorInputField(
            wasteType: "E Waste",
          ),
          CalculatorInputField(
            wasteType: "Glass Waste",
          ),





        ],
      ),
    );
  }
}


class CalculatorInputField extends StatefulWidget {
  final String wasteType;
  const CalculatorInputField({
    super.key,
    this.wasteType = "",
  });

  @override
  State<CalculatorInputField> createState() => _CalculatorInputFieldState();
}

class _CalculatorInputFieldState extends State<CalculatorInputField> {
  final FocusNode _focus = FocusNode();
  Color labelColor = const Color(0xFF77777A);

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    super.dispose();
    _focus.removeListener(_onFocusChange);
    _focus.dispose();
  }

  void _onFocusChange() {
    setState(() {
      labelColor = _focus.hasFocus ? const Color(0xFF2896EC) : const Color(0xFF77777A);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.wasteType,
          style: TextStyle(
            color: labelColor,
            fontSize: 12,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
            height: 0,
          ),
        ),

        TextField(
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
            height: 0,
          ),
          keyboardType: TextInputType.number,
          focusNode: _focus,

          decoration: const InputDecoration(
            fillColor: Color(0xFF2C2C2E),
            border: OutlineInputBorder(),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),

            hintStyle: TextStyle(
              color: Color(0xFF77777A),
              fontSize: 12,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
            suffixIcon: Padding(
              padding: EdgeInsets.all(10.0),
              child: Text('lbs', style: TextStyle(color: Colors.white), ),
            ),
            suffixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
            suffixStyle: TextStyle(
              fontSize: 12,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
            // labelText: 'a',
            hintText: '0',
          ),
        ),

        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
