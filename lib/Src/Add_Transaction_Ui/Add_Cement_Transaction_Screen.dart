import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vcpl/Src/Common_Widgets/Common_Button.dart';
import 'package:vcpl/Src/Common_Widgets/Custom_App_Bar.dart';
import 'package:vcpl/Src/Common_Widgets/Text_Form_Field.dart';
import 'package:vcpl/Src/Models/VehicleModel.dart';
import 'package:vcpl/Src/Utilits/ApiService.dart';
import 'package:vcpl/Src/Utilits/Common_Colors.dart';
import 'package:vcpl/Src/Utilits/ConstantsApi.dart';
import 'package:vcpl/Src/Utilits/Loading_Overlay.dart';
import 'package:vcpl/Src/Utilits/Text_Style.dart';

class Add_Cement_Transaction_Screen extends ConsumerStatefulWidget {
  const Add_Cement_Transaction_Screen({super.key});

  @override
  ConsumerState<Add_Cement_Transaction_Screen> createState() =>
      _Add_Cement_Transaction_ScreenState();
}

class _Add_Cement_Transaction_ScreenState
    extends ConsumerState<Add_Cement_Transaction_Screen> {
  String? trnsactionType;
  List<String> TransactionOtion = [
    "Transfer Cement",
    "Received Cement",
    "Issued to Site",
  ];

  String? workTypeOption;
  List<String> workTypeVal = [
    "VKT Godown",
    "Suresh Complex",
    "Codissia Hub",
    "KCT",
    "Promod Complex",
    "PSGR S BLOCK",
    "KCN BOYS HOSTEL",
    "EPPINGER",
    "SARAYU SCHOOL",
  ];

  String? vechileNumber;
  List<String> vechileNumberOtion = [
    "TN 37 CC 2683",
    "TN 37 CC 2683",
    "TN 37 CC 2683",
  ];

  TextEditingController _Bags = TextEditingController();
  TextEditingController _Purpose = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      getVehicleList();
    });
  }

  void getVehicleList() async {
    LoadingOverlay.show(context);

    final apiService = ApiService(ref.read(dioProvider));

    final postResponse =
        await apiService.post1<VehicleModel>(ConstantApi.vehicleListUrl);
    LoadingOverlay.hide();
    if (postResponse.success == true) {
      setState(() {
        vechileNumberOtion =
            postResponse.data!.map((e) => e.vehicleNo ?? "").toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white3,
      appBar: Custom_AppBar(
          title: "Add Cement Transactions",
          actions: null,
          isBlue: true,
          isNav: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              //TRANSACTION TYPE
              Title_Style(Title: 'Transaction Type', isStatus: true),
              dropDownField(
                context,
                value: trnsactionType,
                listValue: TransactionOtion,
                onChanged: (String? newValue) {
                  setState(() {
                    trnsactionType = newValue;
                  });
                },
                hint: 'Site Name',
              ),

              //ISSUED TYPE
              Column(
                children: [
                  //BAGS QUANTITY
                  trnsactionType == null
                      ? Container()
                      : Title_Style(Title: 'Bags (Quantity) ', isStatus: true),
                  trnsactionType == null
                      ? Container()
                      : textFormField2(
                          // isEnabled: false,
                          hintText: "Enter Bags Quantity",
                          keyboardtype: TextInputType.phone,
                          Controller: _Bags,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          onChanged: null,
                          validating: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Bags Quantity';
                            } else if (value == null) {
                              return 'Please Enter Bags Quantity';
                            }
                            return null;
                          }),

                  //BAGS QUANTITY
                  trnsactionType == "Issued to Site"
                      ? Title_Style(Title: 'Purpose ', isStatus: true)
                      : Container(),
                  trnsactionType == "Issued to Site"
                      ? textFormField2(
                          // isEnabled: false,
                          hintText: "Enter Purpose",
                          keyboardtype: TextInputType.text,
                          Controller: _Purpose,
                          inputFormatters: null,
                          onChanged: null,
                          validating: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Purpose';
                            } else if (value == null) {
                              return 'Please Enter Purpose';
                            }
                            return null;
                          })
                      : Container(),
                ],
              ),
              //TRANSFER CEMENT
              Column(
                children: [
                  // Site Name
                  trnsactionType == "Transfer Cement"
                      ? Title_Style(Title: 'To Site Name  ', isStatus: true)
                      : Container(),
                  trnsactionType == "Transfer Cement"
                      ? dropDownField(
                          context,
                          value: workTypeOption,
                          listValue: workTypeVal,
                          onChanged: (String? newValue) {
                            setState(() {
                              workTypeOption = newValue;
                            });
                          },
                          hint: 'Select To Site',
                        )
                      : Container(),

                  //SLIP NUMBER
                  trnsactionType == "Transfer Cement"
                      ? Title_Style(
                          Title: 'Transfer Slip Number  ', isStatus: true)
                      : Container(),
                  trnsactionType == "Transfer Cement"
                      ? textFormField2(
                          // isEnabled: false,
                          hintText: "Enter Transfer Slip Number ",
                          keyboardtype: TextInputType.phone,
                          Controller: _Bags,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          onChanged: null,
                          validating: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Transfer Slip Number ';
                            } else if (value == null) {
                              return 'Please Enter Transfer Slip Number ';
                            }
                            return null;
                          })
                      : Container(),
                  //VECHILE NUMBER
                  trnsactionType == "Transfer Cement"
                      ? Title_Style(Title: 'Vehicle No  ', isStatus: true)
                      : trnsactionType == "Received Cement"
                          ? Title_Style(Title: 'Vehicle No  ', isStatus: true)
                          : Container(),
                  trnsactionType == "Transfer Cement"
                      ? dropDownField(
                          context,
                          value: vechileNumber,
                          listValue: vechileNumberOtion,
                          onChanged: (String? newValue) {
                            setState(() {
                              vechileNumber = newValue;
                            });
                          },
                          hint: 'Select Vechile',
                        )
                      : trnsactionType == "Received Cement"
                          ? dropDownField(
                              context,
                              value: vechileNumber,
                              listValue: vechileNumberOtion,
                              onChanged: (String? newValue) {
                                setState(() {
                                  vechileNumber = newValue;
                                });
                              },
                              hint: 'Select Vechile',
                            )
                          : Container(),
                ],
              ),
              //RECEIVED CEMENT
              Column(
                children: [
                  //INVOICE NUMBER
                  trnsactionType == "Received Cement"
                      ? Title_Style(Title: 'Invoie Number  ', isStatus: true)
                      : Container(),
                  trnsactionType == "Received Cement"
                      ? textFormField2(
                          // isEnabled: false,
                          hintText: "Enter Invoie Number",
                          keyboardtype: TextInputType.phone,
                          Controller: _Bags,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          onChanged: null,
                          validating: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Invoie Number';
                            } else if (value == null) {
                              return 'Please Enter Invoie Number';
                            }
                            return null;
                          })
                      : Container(),
                  //GRADE AND BRAND
                  trnsactionType == "Received Cement"
                      ? Title_Style(Title: 'Grade and Brand ', isStatus: true)
                      : Container(),
                  trnsactionType == "Received Cement"
                      ? textFormField2(
                          // isEnabled: false,
                          hintText: "Entre Grade and Brand",
                          keyboardtype: TextInputType.text,
                          Controller: _Bags,
                          inputFormatters: null,
                          onChanged: null,
                          validating: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Grade and Brand';
                            } else if (value == null) {
                              return 'Please Enter Grade and Brand';
                            }
                            return null;
                          })
                      : Container(),
                ],
              ),
              //SUBMIT BUTTON
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 100, top: 100, left: 30, right: 30),
                child: CommonElevatedButton(context, 'Submit', () {}),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
