import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vcpl/Src/Common_Widgets/Common_Button.dart';
import 'package:vcpl/Src/Common_Widgets/Custom_App_Bar.dart';
import 'package:vcpl/Src/Common_Widgets/Text_Form_Field.dart';
import 'package:vcpl/Src/Models/CommonListModel.dart';
import 'package:vcpl/Src/Models/CommonModel.dart';
import 'package:vcpl/Src/Models/VehicleModel.dart';
import 'package:vcpl/Src/Pending_Transaction_Ui/Pending_Transaction_Screen.dart';
import 'package:vcpl/Src/Utilits/ApiService.dart';
import 'package:vcpl/Src/Utilits/Common_Colors.dart';
import 'package:vcpl/Src/Utilits/ConstantsApi.dart';
import 'package:vcpl/Src/Utilits/Generic.dart';
import 'package:vcpl/Src/Utilits/Loading_Overlay.dart';
import 'package:vcpl/Src/Utilits/Text_Style.dart';

class Add_Cement_Transaction_Screen extends ConsumerStatefulWidget {
  List<ListData> sitenameData = [];
  List<ListData> siteListData = [];
  List<VehicleData> vehicleListData = [];

  Add_Cement_Transaction_Screen(
      this.sitenameData, this.siteListData, this.vehicleListData,
      {super.key});

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
  String? siteNameID = "";

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
  List<String> toSiteList = [];
  String? toSiteValue;
  String? toSiteID = "";

  String? vechileNumber;
  String? vechileID = "";
  List<String> vechileNumberOtion = [
    "TN 37 CC 2683",
    "TN 37 CC 2683",
    "TN 37 CC 2683",
  ];

  TextEditingController _Bags = TextEditingController();
  TextEditingController _transferSlipNo = TextEditingController();
  TextEditingController _invoiceNo = TextEditingController();
  TextEditingController _Grade = TextEditingController();

  TextEditingController _Purpose = TextEditingController();
  TextEditingController _openingBalance = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    workTypeVal = widget.sitenameData.map((e) => e.siteName ?? "").toList();
    toSiteList = widget.siteListData.map((e) => e.siteName ?? "").toList();
    vechileNumberOtion =
        widget.vehicleListData.map((e) => e.vehicleNo ?? "").toList();
    _openingBalance.text = "0";
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

  getStocks(String site_id) async {
    LoadingOverlay.show(context);

    final apiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({"site_id": site_id});

    final postResponse = await apiService.post<CommonModel>(
        ConstantApi.getCementStocks, formData);
    LoadingOverlay.hide();

    if (postResponse.success == true) {
      setState(() {
        _openingBalance.text = postResponse.data?.stock.toString() ?? "0";
      });
    } else {
      ShowToastMessage(postResponse.message ?? "");
      _openingBalance.text = "0";
    }
  }

  void addCementTransaction(FormData formData) async {
    LoadingOverlay.show(context);

    final apiService = ApiService(ref.read(dioProvider));

    final postResponse = await apiService.post<CommonModel>(
        ConstantApi.addCementTransaction, formData);
    LoadingOverlay.forcedStop();

    if (postResponse.success == true) {
      if (trnsactionType == "Transfer Cement") {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Pending_Transaction_Screen("Cement Transactions")));
      } else {
        ShowToastMessage(postResponse.message ?? "");
        Navigator.pop(context);
      }
    } else {
      postResponse.messageError?.transferSlipNo != null
          ? ShowToastMessage(
              postResponse.messageError?.transferSlipNo?[0] ?? "")
          : ShowToastMessage(postResponse.message ?? "");
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
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Title_Style(Title: 'Site Name', isStatus: true),
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          child: dropDownField(
                            context,
                            value: workTypeOption,
                            listValue: workTypeVal,
                            onChanged: (String? newValue) async {
                              workTypeOption = newValue;

                              ListData result = widget.sitenameData.firstWhere(
                                  (value) => value.siteName == newValue);
                              siteNameID = "${result.id}";
                              getStocks(result.id.toString());
                            },
                            hint: 'Site Name',
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      children: [
                        Title_Style(Title: 'Opening Balance', isStatus: true),
                        Container(
                          width: MediaQuery.of(context).size.width / 4.5,
                          child: textFormField2(
                            isEnabled: false,
                            hintText: "00",
                            keyboardtype: TextInputType.phone,
                            Controller: _openingBalance,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            onChanged: null,
                            validating: null,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
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
                        : Title_Style(
                            Title: 'Bags (Quantity) ', isStatus: true),
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
                            value: toSiteValue,
                            listValue: toSiteList,
                            onChanged: (String? newValue) {
                              setState(() {
                                toSiteValue = newValue;

                                ListData result = widget.siteListData
                                    .firstWhere(
                                        (value) => value.siteName == newValue);
                                toSiteID = "${result.id}";
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
                            Controller: _transferSlipNo,
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
                    trnsactionType == "Transfer Cement" ||
                            trnsactionType == "Received Cement"
                        ? dropDownField(
                            context,
                            value: vechileNumber,
                            listValue: vechileNumberOtion,
                            onChanged: (String? newValue) {
                              setState(() {
                                vechileNumber = newValue;
                                VehicleData result = widget.vehicleListData
                                    .firstWhere(
                                        (value) => value.vehicleNo == newValue);
                                vechileID = '${result.id}';
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
                            Controller: _invoiceNo,
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
                            Controller: _Grade,
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
                      bottom: 50, top: 50, left: 30, right: 30),
                  child: CommonElevatedButton(context, 'Submit', () {
                    print("object");

                    if (trnsactionType == "Transfer Cement") {
                      if (_formKey.currentState!.validate()) {
                        if (siteNameID == "") {
                          ShowToastMessage("Choose Site Name");
                        } else if (vechileID == "") {
                          ShowToastMessage("Choose vehicle number");
                        } else if (toSiteID == "") {
                          ShowToastMessage("Choose to site name");
                        } else if (siteNameID == toSiteID) {
                          ShowToastMessage(
                              "To Site and Current Site should be different");
                        } else if (!(int.parse(_Bags.text) <=
                            int.parse(_openingBalance.text))) {
                          ShowToastMessage(
                              "Quantity is Greater than Opening Balance");
                        } else {
                          var formData = FormData.fromMap({
                            "transaction_type": 1,
                            "current_site_id": siteNameID,
                            "quantity": _Bags.text,
                            "to_site_id": toSiteID,
                            "transfer_slip_no": _transferSlipNo.text,
                            "vehicle_id": vechileID
                          });

                          addCementTransaction(formData);
                        }
                      }
                    } else if (trnsactionType == "Received Cement") {
                      if (_formKey.currentState!.validate()) {
                        if (siteNameID == "") {
                          ShowToastMessage("Choose Site Name");
                        } else if (vechileID == "") {
                          ShowToastMessage("Choose vehicle number");
                        } else {
                          var formData = FormData.fromMap({
                            "transaction_type": 2,
                            "current_site_id": siteNameID,
                            "quantity": _Bags.text,
                            "bill_no": _invoiceNo.text,
                            "grand_and_brand": _Grade.text,
                            "vehicle_id": vechileID
                          });
                          addCementTransaction(formData);
                        }
                      }
                    } else if (trnsactionType == "Issued to Site") {
                      if (_formKey.currentState!.validate()) {
                        if (siteNameID == "") {
                          ShowToastMessage("Choose Site Name");
                        } else if (!(int.parse(_Bags.text) <=
                            int.parse(_openingBalance.text))) {
                          ShowToastMessage(
                              "Quantity is Greater than Opening Balance");
                        } else {
                          var formData = FormData.fromMap({
                            "transaction_type": 3,
                            "current_site_id": siteNameID,
                            "quantity": _Bags.text,
                            "issued_purpose": _Purpose.text
                          });
                          addCementTransaction(formData);
                        }
                      }
                    } else {
                      ShowToastMessage("Choose Transaction Type");
                    }
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
