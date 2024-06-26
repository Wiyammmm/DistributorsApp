import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:distributorsapp/backend/generator/generator.dart';
import 'package:distributorsapp/backend/httprequest/httprequest.dart';
import 'package:distributorsapp/components/buttons.dart';
import 'package:distributorsapp/components/color.dart';
import 'package:distributorsapp/components/modals.dart';
import 'package:distributorsapp/components/template.dart';
import 'package:distributorsapp/components/textfields.dart';
import 'package:distributorsapp/pages/register/registerGetVerified.dart';
import 'package:distributorsapp/pages/register/registerUserType.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class RegisterUserProfilePage extends StatefulWidget {
  const RegisterUserProfilePage({super.key, required this.thisData});

  final thisData;
  @override
  State<RegisterUserProfilePage> createState() =>
      _RegisterUserProfilePageState();
}

class _RegisterUserProfilePageState extends State<RegisterUserProfilePage> {
  MyModals myModals = MyModals();
  HttprequestService httprequestService = HttprequestService();
  GeneratorServices generatorServices = GeneratorServices();
  final TextEditingController numberController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  // TextEditingController mobileNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  String numberInputted = "";
  String initialCountry = 'PH';
  PhoneNumber number = PhoneNumber(isoCode: 'PH');
  final _formKey = GlobalKey<FormState>();
  bool isObsecure = true;

  void _registerUser() async {
    var refnum = generatorServices.generateRandomString();
    print('refnum: $refnum');
    if (!widget.thisData['isDistributor']) {
      refnum = widget.thisData['refNumber'];
    }
    final registerUser = await httprequestService.registerUser({
      "firstName": "${firstNameController.text}",
      "middleName": "",
      "lastName": "${lastNameController.text}",
      "password": "${passController.text}",
      "email": "${emailController.text}",
      "mobileNumber": "${numberInputted}",
      "address": "${addressController.text}",
      "referenceNumber": "$refnum",
      "role": "${widget.thisData['isDistributor'] ? "distributor" : "retailer"}"
    });

    try {
      if (registerUser['messages'][0]['code'].toString() == "0") {
        print('success register');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RegisterGetVerified()),
        );
      } else {
        Navigator.of(context).pop();
        ArtSweetAlert.show(
            context: context,
            artDialogArgs: ArtDialogArgs(
                type: ArtSweetAlertType.danger,
                title: "Oops...",
                text: "${registerUser['messages'][0]['message']}"));
      }
    } catch (e) {
      print(e);
      if (mounted) {
        Navigator.of(context).pop();
        ArtSweetAlert.show(
            context: context,
            artDialogArgs: ArtDialogArgs(
                type: ArtSweetAlertType.danger,
                title: "Oops...",
                text: "SOMETHING WENT WRONG, PLEASE TRY AGAIN"));
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    print("this data: ${widget.thisData}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return pageTemplate(
        thiswidget: Column(children: [
          Container(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterUserTypePage()),
                      );
                    },
                    icon: Icon(Icons.arrow_back_ios_new_rounded,
                        color: myColors.darkblue)),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Image.asset(
                    "assets/FILIPAYDistributorLogo2.png",
                    width: 120,
                  ),
                ),
                SizedBox(
                  width: 20,
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: SizedBox(
              child: SingleChildScrollView(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Register',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  SizedBox(
                    width: 110,
                    height: 110,
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Color(0xffaec7d5),
                              shape: BoxShape.circle,
                              border: Border.all(
                                  width: 5, color: Color(0xff273d4a)),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage("assets/person.png"))),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            decoration: BoxDecoration(
                                color: myColors.darkblue,
                                borderRadius: BorderRadius.circular(100)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.camera_alt_outlined,
                                  color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          textformfieldWidget(
                            label: "first name",
                            thisController: firstNameController,
                            thisTextInputType: TextInputType.name,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          textformfieldWidget(
                            label: "last name",
                            thisController: lastNameController,
                            thisTextInputType: TextInputType.name,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: InternationalPhoneNumberInput(
                              onInputChanged: (PhoneNumber number) {
                                print("phonenumber: ${number.phoneNumber}");
                                setState(() {
                                  numberInputted = "${number.phoneNumber}";
                                });
                              },
                              onInputValidated: (bool value) {
                                print(value);
                              },
                              selectorConfig: SelectorConfig(
                                selectorType:
                                    PhoneInputSelectorType.BOTTOM_SHEET,
                                useBottomSheetSafeArea: true,
                              ),
                              ignoreBlank: false,
                              autoValidateMode: AutovalidateMode.disabled,
                              selectorTextStyle: TextStyle(color: Colors.black),
                              initialValue: number,
                              textFieldController: numberController,
                              formatInput: true,
                              keyboardType: TextInputType.numberWithOptions(
                                  signed: true, decimal: true),
                              inputDecoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                  hintText: "Mobile Number",
                                  hintStyle:
                                      TextStyle(color: Colors.lightBlue)),
                              inputBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              onSaved: (PhoneNumber number) {
                                print('On Saved: $number');
                              },
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          textformfieldWidget(
                            label: "Address",
                            thisController: addressController,
                            thisTextInputType: TextInputType.name,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          textformfieldWidget(
                            label: "Email Address",
                            thisController: emailController,
                            thisTextInputType: TextInputType.emailAddress,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: double.infinity,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextFormField(
                              controller: passController,
                              keyboardType: TextInputType.text,
                              obscureText: isObsecure,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                  label: Text("Password"),
                                  labelStyle: TextStyle(
                                      color: Colors.lightBlue,
                                      backgroundColor: Colors.white),
                                  hintText: "Enter password",
                                  hintStyle: TextStyle(color: Colors.lightBlue),
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isObsecure = !isObsecure;
                                        });
                                      },
                                      icon: isObsecure
                                          ? Icon(
                                              Icons.remove_red_eye,
                                              color: myColors.darkblue,
                                            )
                                          : Icon(Icons.remove_red_eye_outlined,
                                              color: myColors.darkblue))),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: RichText(
                              softWrap: true,
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                // Note: Styles for TextSpans must be explicitly defined.
                                // Child text spans will inherit styles from parent
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.black,
                                ),
                                children: [
                                  TextSpan(
                                      text: 'By signing up, you agree to the'),
                                  TextSpan(
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          print('Terms of Service');
                                          // Handle tap on "Terms of Service"
                                        },
                                      text: ' Terms of Service',
                                      style: new TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue)),
                                  TextSpan(text: ' and'),
                                  TextSpan(
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          print('Privacy Policy');
                                          // Handle tap on "Terms of Service"
                                        },
                                      text: ' Privacy Policy',
                                      style: new TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue)),
                                ],
                              ),
                            ),
                          ),
                          darkblueButton(
                              thisFunction: () {
                                myModals.showProcessing(context, "Processing");
                                if (_formKey.currentState!.validate()) {
                                  _registerUser();
                                }
                              },
                              label: "NEXT")
                        ],
                      ),
                    ),
                  )
                ],
              )),
            ),
          )
        ]),
        haveappbar: false);
  }
}
