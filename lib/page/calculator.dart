import 'package:dinacom_2024/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String annualCarbonFootprint = "?";
  String measurementUnit = "\ntonnes";
  double inputCarbonFootprint = 0;
  Map<String, double> carbonFootprintPerWaste = {};
  Map<String, double> carbonFactorPerWaste = {
    // source: https://www.epa.gov/system/files/documents/2023-03/ghg_emission_factors_hub.pdf
    // Table 9
    // Assumption: disposal using landfill method
    // To convert short tons to kg, we divide by 907.18
    'Organic Waste' : 0.48  / 907.18,     // mixed organics
    "Plastic Waste" : 0.02  / 907.18,     // mixed plastics
    "Paper Waste"   : 0.80  / 907.18,     // mixed paper (general)
    "Metal Waste"   : 0.02  / 907.18,     // mixed metals
    "E Waste"       : 0.02  / 907.18,     // mixed electronics
    "Glass Waste"   : 0.02  / 907.18,     // glass
  };

  void updateInputCarbonFootprint() {
    double tempInputCarbonFootprint = 0;
    carbonFootprintPerWaste.forEach((key, value) {
      tempInputCarbonFootprint += value * (carbonFactorPerWaste[key] ?? 0);
    });
    setState(() {
      inputCarbonFootprint = tempInputCarbonFootprint;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);
    if (user != null) {

    }
    return Scaffold(
      backgroundColor: const Color(0xF9212121),
      body: NotificationListener<CalculatorInputFieldChanged>(
        onNotification: (notification) {
          carbonFootprintPerWaste[notification.wasteType] = notification.value;
          updateInputCarbonFootprint();
          return true;
        },
        child: ListView(
          padding: const EdgeInsets.only(top: 68, left: 34, right: 34),
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Calculator',
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                height: 0,
              ),
            ),
        
            const Text(
              'Find out your impact on this planet.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w300,
                height: 0,
              ),
            ),
            const SizedBox(
              height: 34,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: [
                    const Text(
                      'Annual Carbon Footprint',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                    const SizedBox(height: 9,),
                    CircleAvatar(
                      radius: 75,
                      backgroundColor: const Color(0xFF5B8A62),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: annualCarbonFootprint,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 45,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                            TextSpan(
                              text: measurementUnit,
                              style: const TextStyle(
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
                const Spacer(),
                Column(
                  children: [
                    const Text(
                      'Calculated\n Carbon Footprint',
                      maxLines: 2,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 9,),
                    CircleAvatar(
                        radius: 50,
                        backgroundColor: const Color(0xFF5B8A62),
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: inputCarbonFootprint.toStringAsFixed(2),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                              const TextSpan(
                                text: '\ntonnes',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.fade,
                        ),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 34,
            ),
            const Text(
              "Calculate Footprint",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
            const Divider(),
        
            const CalculatorInputField(
              wasteType: "Organic Waste",
            ),
            const CalculatorInputField(
              wasteType: "Plastic Waste",
            ),
            const CalculatorInputField(
              wasteType: "Paper Waste",
            ),
            const CalculatorInputField(
              wasteType: "Metal Waste",
            ),
            const CalculatorInputField(
              wasteType: "E Waste",
            ),
            const CalculatorInputField(
              wasteType: "Glass Waste",
            ),
        
        
        
        
        
          ],
        ),
      ),
    );
  }
}


class CalculatorInputFieldChanged extends Notification {
  final double value;
  final String wasteType;
  CalculatorInputFieldChanged({required this.value, required this.wasteType});
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
  final TextEditingController _controller = TextEditingController();
  Color labelColor = const Color(0xFF77777A);

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focus.removeListener(_onFocusChange);
    _focus.dispose();
    _controller.dispose();
    super.dispose();
  }

  double getDoubleValue() {
    // special case if text is empty
    if (_controller.text == '') {
      return 0;
    }

    double? poss = double.tryParse(_controller.text);
    if (poss == null) {
      throw Exception("Non numeric input detected at ${widget.wasteType} label.");
    }
    else {
      return poss;
    }
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
          controller: _controller,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          onChanged: (value) {
            CalculatorInputFieldChanged(
                value: getDoubleValue(),
                wasteType: widget.wasteType,
            ).dispatch(context);
          },

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
              child: Text('kg', style: TextStyle(color: Colors.white), ),
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
