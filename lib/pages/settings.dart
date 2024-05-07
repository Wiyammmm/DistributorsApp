import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:distributorsapp/backend/httprequest/httprequest.dart';
import 'package:distributorsapp/components/buttons.dart';
import 'package:distributorsapp/components/color.dart';
import 'package:distributorsapp/components/template.dart';
import 'package:distributorsapp/components/widgets.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  HttprequestService httprequestService = HttprequestService();

  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController BusinessPermitController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final _myBox = Hive.box('myBox');
  Map<String, dynamic> userInfo = {};

  @override
  void initState() {
    userInfo = _myBox.get('userInfo');
    nameController.text =
        "${userInfo['firstName']} ${userInfo['middleName']} ${userInfo['lastName']}";
    addressController.text = "${userInfo['address']}";
    emailController.text = "${userInfo['email']}";
    // getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    final gettingUserInfo =
        await httprequestService.getUserInfo({"userId": "${userInfo['_id']}"});

    try {
      if (gettingUserInfo['messages'][0]['code'].toString() == "0") {
        setState(() {
          userInfo = gettingUserInfo['response']['userInfo'];
          print('userInfo: $userInfo');
          _myBox.put('userInfo', userInfo);
        });
      } else {
        ArtSweetAlert.show(
            context: context,
            artDialogArgs: ArtDialogArgs(
                type: ArtSweetAlertType.danger,
                title: "Oops...",
                text: "SOMETHING WENT WRONG, PLEASE TRY AGAIN"));
      }
    } catch (e) {
      print(e);

      ArtSweetAlert.show(
          context: context,
          artDialogArgs: ArtDialogArgs(
              type: ArtSweetAlertType.danger,
              title: "Oops...",
              text: "SOMETHING WENT WRONG, PLEASE TRY AGAIN"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        getUserInfo();
      },
      child: pageTemplate(
          thiswidget: Column(
            children: [
              appBardarkblueWidget(
                title: "Profile Settings",
                thisFunction: () {
                  Navigator.of(context).pop();
                },
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                  child: SizedBox(
                child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            "assets/FILIPAYDistributorLogo2.png",
                            width: 120,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Verified Account',
                            style: TextStyle(
                                color: Colors.green,
                                fontStyle: FontStyle.italic),
                          ),
                          SizedBox(
                            height: 10,
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
                                          image:
                                              AssetImage("assets/person.png"))),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: myColors.darkblue,
                                        borderRadius:
                                            BorderRadius.circular(100)),
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
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: myColors.ligtblue,
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  settingsTextfield(
                                    label: "Name",
                                    thisController: nameController,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  settingsTextfield(
                                    label: "Address",
                                    thisController: addressController,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  settingsTextfield(
                                    label: "Phone Number",
                                    thisController: phoneNumberController,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  settingsTextfield(
                                    label: "Business Permit",
                                    thisController: BusinessPermitController,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  settingsTextfield(
                                    label: "E-mail Address",
                                    thisController: emailController,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  settingsTextfield(
                                    label: "Password",
                                    thisController: passController,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              'Keep your information updated for fast transaction',
                              style: TextStyle(color: Colors.grey.shade700),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          darkblueButton(
                              thisFunction: () {}, label: "Save changes")
                        ],
                      ),
                    )),
              ))
            ],
          ),
          haveappbar: false),
    );
  }
}

class settingsTextfield extends StatelessWidget {
  const settingsTextfield(
      {super.key, required this.label, required this.thisController});
  final String label;
  final TextEditingController thisController;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            alignment: Alignment.centerLeft,
            width: MediaQuery.of(context).size.width * 0.3,
            child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  '$label',
                ))),
        Expanded(
            child: Container(
                height: 21,
                decoration: BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(width: 1, color: myColors.darkblue))),
                child: TextField(
                  controller: thisController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(borderSide: BorderSide.none)),
                )))
      ],
    );
  }
}
