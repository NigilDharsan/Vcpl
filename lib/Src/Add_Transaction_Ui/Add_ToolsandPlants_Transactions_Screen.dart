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
import 'package:vcpl/Src/Utilits/ApiService.dart';
import 'package:vcpl/Src/Utilits/Common_Colors.dart';
import 'package:vcpl/Src/Utilits/ConstantsApi.dart';
import 'package:vcpl/Src/Utilits/Generic.dart';
import 'package:vcpl/Src/Utilits/Loading_Overlay.dart';
import 'package:vcpl/Src/utilits/Text_Style.dart';

class Add_ToolsAndPlant_Transaction_Screen extends ConsumerStatefulWidget {
  List<ListData> sitenameData = [];
  List<ListData> siteListData = [];
  List<VehicleData> vehicleListData = [];

  Add_ToolsAndPlant_Transaction_Screen(
      this.siteListData, this.sitenameData, this.vehicleListData,
      {super.key});

  @override
  ConsumerState<Add_ToolsAndPlant_Transaction_Screen> createState() =>
      _Add_ToolsAndPlant_Transaction_ScreenState();
}

class _Add_ToolsAndPlant_Transaction_ScreenState
    extends ConsumerState<Add_ToolsAndPlant_Transaction_Screen> {
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

  List<String> toSiteList = [];
  String? toSiteValue;
  String? toSiteID = "";

  String? vechileID = "";
  String? vechileNumber;
  List<String> vechileNumberOtion = [
    "TN 37 CC 2683",
    "TN 37 CC 2683",
    "TN 37 CC 2683",
  ];

  String? materialName;
  List<ListData> materialData = [];
  List<String> materialNameOption = [];

  String site_id = "";
  String material_id = "";
  TextEditingController _TransferedSlip = TextEditingController();
  TextEditingController _Quantity = TextEditingController();
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

    getMaterialNameList();
  }

  void getMaterialNameList() async {
    LoadingOverlay.show(context);

    final apiService = ApiService(ref.read(dioProvider));

    final postResponse = await apiService
        .post1<CommonListModel>(ConstantApi.toolsandplantsMaterial);
    LoadingOverlay.hide();
    if (postResponse.success == true) {
      setState(() {
        materialData = postResponse.data!;
        materialNameOption =
            materialData.map((e) => e.productName ?? "").toList();
        print(postResponse);

        print(materialNameOption);
      });
    }
  }

  getStocks(String site_id, String material_id) async {
    final apiService = ApiService(ref.read(dioProvider));

    var formData =
        FormData.fromMap({"site_id": site_id, "material_id": material_id});

    final postResponse = await apiService.post<CommonModel>(
        ConstantApi.getCenteringStocks, formData);
    if (postResponse.success == true && postResponse.data != null) {
      setState(() {
        _openingBalance.text = postResponse.data!.stock.toString();
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
        ConstantApi.addToolsandplantsTransaction, formData);
    LoadingOverlay.hide();
    if (postResponse.success == true) {
      ShowToastMessage(postResponse.message ?? "");
      Navigator.pop(context);
    } else {
      ShowToastMessage(postResponse.message ?? "");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white3,
      appBar: Custom_AppBar(
          title: "Add ToolsandPlants Transactions",
          actions: null,
          isBlue: true,
          isNav: true),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
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

                                ListData result = widget.sitenameData
                                    .firstWhere(
                                        (value) => value.siteName == newValue);

                                site_id = result.id.toString();

                                if (site_id != "" && material_id != "") {
                                  LoadingOverlay.show(context);

                                  await getStocks(site_id, material_id);

                                  LoadingOverlay.hide();
                                } else {
                                  setState(() {
                                    workTypeOption = newValue;
                                  });
                                }
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
                  Title_Style(Title: 'Material Name', isStatus: true),
                  dropDownField(
                    context,
                    value: materialName,
                    listValue: materialNameOption,
                    onChanged: (String? newValue) async {
                      materialName = newValue;

                      ListData result = materialData
                          .firstWhere((value) => value.productName == newValue);

                      material_id = result.id.toString();

                      if (site_id != "" && material_id != "") {
                        LoadingOverlay.show(context);

                        await getStocks(site_id, material_id);

                        LoadingOverlay.hide();
                      } else {
                        setState(() {
                          materialName = newValue;
                        });
                      }
                    },
                    hint: 'Select Material Name',
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
                  //TO SITE NAME
                  Title_Style(Title: 'To Site Name  ', isStatus: true),
                  dropDownField(
                    context,
                    value: toSiteValue,
                    listValue: toSiteList,
                    onChanged: (String? newValue) {
                      setState(() {
                        toSiteValue = newValue;
                        ListData result = widget.siteListData
                            .firstWhere((value) => value.siteName == newValue);
                        toSiteID = "${result.id}";
                      });
                    },
                    hint: 'Select To Site',
                  ),
                  //QUANTITY
                  Title_Style(Title: 'Quantity  ', isStatus: true),
                  textFormField2(
                      // isEnabled: false,
                      hintText: "Enter Quantity",
                      keyboardtype: TextInputType.phone,
                      Controller: _Quantity,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      onChanged: null,
                      validating: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Quantity';
                        } else if (value == null) {
                          return 'Please Enter Quantity';
                        }
                        return null;
                      }),
                  //TRANSFER SLIP NUMBER
                  Title_Style(Title: 'Transfer Slip Number  ', isStatus: true),
                  textFormField2(
                      // isEnabled: false,
                      hintText: "Enter Transfer Slip Number ",
                      keyboardtype: TextInputType.phone,
                      Controller: _TransferedSlip,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      onChanged: null,
                      validating: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Transfer Slip Number ';
                        } else if (value == null) {
                          return 'Please Enter Transfer Slip Number ';
                        }
                        return null;
                      }),
                  //SELECT VECHILE
                  Title_Style(Title: 'Vehicle No  ', isStatus: true),
                  dropDownField(
                    context,
                    value: vechileNumber,
                    listValue: vechileNumberOtion,
                    onChanged: (String? newValue) {
                      setState(() {
                        vechileNumber = newValue;
                        VehicleData result = widget.vehicleListData
                            .firstWhere((value) => value.vehicleNo == newValue);
                        vechileID = '${result.id}';
                      });
                    },
                    hint: 'Select Vechile',
                  ),

                  //SUBMIT BUTTON
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 50, bottom: 50, left: 30, right: 30),
                    child: CommonElevatedButton(context, 'Submit', () {
                      if (_formKey.currentState!.validate()) {
                        if (site_id == "") {
                          ShowToastMessage("Choose Site Name");
                        } else if (vechileID == "") {
                          ShowToastMessage("Choose vehicle number");
                        } else if (toSiteID == "") {
                          ShowToastMessage("Choose to site name");
                        } else if (material_id == "") {
                          ShowToastMessage("Choose material name");
                        } else if (site_id == toSiteID) {
                          ShowToastMessage(
                              "To Site and Current Site should be different");
                        } else if (!(int.parse(_Quantity.text) <=
                            int.parse(_openingBalance.text))) {
                          ShowToastMessage(
                              "Quantity is Greater than Opening Balance");
                        } else {
                          var formData = FormData.fromMap({
                            "transaction_type": 1,
                            "current_site_id": site_id,
                            "quantity": _Quantity.text,
                            "to_site_id": toSiteID,
                            "transfer_slip_no": _TransferedSlip.text,
                            "vehicle_id": vechileID,
                            "material_id": material_id
                          });

                          addCementTransaction(formData);
                        }
                      }
                    }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
