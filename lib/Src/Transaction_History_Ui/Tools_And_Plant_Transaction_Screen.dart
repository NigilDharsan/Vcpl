import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vcpl/Src/Common_Widgets/Common_List.dart';
import 'package:vcpl/Src/Common_Widgets/Custom_App_Bar.dart';
import 'package:vcpl/Src/Common_Widgets/Text_Form_Field.dart';
import 'package:vcpl/Src/Models/CommonListModel.dart';
import 'package:vcpl/Src/Models/CommonModel.dart';
import 'package:vcpl/Src/Utilits/ApiService.dart';
import 'package:vcpl/Src/Utilits/Common_Colors.dart';
import 'package:vcpl/Src/Utilits/ConstantsApi.dart';
import 'package:vcpl/Src/Utilits/Loading_Overlay.dart';
import 'package:vcpl/Src/Utilits/Text_Style.dart';

class Tools_And_Plant_Transaction_Screen extends ConsumerStatefulWidget {
  List<ListData> sitenameData = [];

  Tools_And_Plant_Transaction_Screen(this.sitenameData, {super.key});

  @override
  ConsumerState<Tools_And_Plant_Transaction_Screen> createState() =>
      _Tools_And_Plant_Transaction_ScreenState();
}

class _Tools_And_Plant_Transaction_ScreenState
    extends ConsumerState<Tools_And_Plant_Transaction_Screen> {
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

  String? materialName;
  List<ListData> materialData = [];
  List<String> materialNameOption = [
    "1.2 Cross Ledger",
    "H Frame",
    "GPS 1.25MM",
    "GPS 1.25MM",
    "SPAN(INNER)",
  ];
  TextEditingController _openingBalance = TextEditingController();

  List<ListData> transactionList = [];

  String stock_id = "";
  String material_id = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    workTypeVal = widget.sitenameData.map((e) => e.siteName ?? "").toList();

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
      });
    }
  }

  getTransactionList(String site_id) async {
    final apiService = ApiService(ref.read(dioProvider));

    var formData = FormData.fromMap({"current_site_id": site_id});

    final postResponse = await apiService.post<CommonListModel>(
        ConstantApi.cementTransactionList, formData);
    if (postResponse.success == true) {
      setState(() {
        transactionList = postResponse.data!;
      });
    } else {
      LoadingOverlay.hide();
    }
  }

  getStocks(String site_id, String material_id) async {
    final apiService = ApiService(ref.read(dioProvider));

    var formData =
        FormData.fromMap({"site_id": site_id, "material_id": material_id});

    final postResponse = await apiService.post<CommonModel>(
        ConstantApi.getCementStocks, formData);
    if (postResponse.success == true) {
      setState(() {
        _openingBalance.text = postResponse.data!.stock.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white3,
      appBar: Custom_AppBar(
        title: 'ToolsandPlants Transactions',
        actions: null,
        isNav: true,
        isBlue: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 25,
              ),
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
                          onChanged: (String? newValue) {
                            setState(() {
                              workTypeOption = newValue;

                              ListData result = widget.sitenameData.firstWhere(
                                  (value) => value.siteName == newValue);

                              stock_id = result.id.toString();
                            });
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
                          // isEnabled: false,
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
                onChanged: (String? newValue) {
                  setState(() {
                    materialName = newValue;
                  });
                },
                hint: 'Select Material Name',
              ),
              Container(
                margin: EdgeInsets.only(top: 25, bottom: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15), color: white1),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 20),
                        child: textFormFieldSearchBar(
                          keyboardtype: TextInputType.text,
                          hintText: "Search ...",
                          Controller: null,
                          validating: null,
                          onChanged: null,
                          onTap: () {},
                        ),
                      ),
                      Container(
                          height: MediaQuery.of(context).size.height / 1.7,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: _cementHistoryList(context, transactionList),
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _cementHistoryList(context, List<ListData> transactionList) {
  return ListView.builder(
    itemCount: transactionList.length,
    shrinkWrap: true,
    scrollDirection: Axis.vertical,
    physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (BuildContext context, int index) {
      return Common_Transaction(
        context,
        isTag: transactionList[index].transactionType ?? "",
        Date: transactionList[index].createdAt ?? "",
        MaterialName: transactionList[index].material ?? "",
        Quantity: '${transactionList[index].quantity ?? 0}',
      );
    },
  );
}
