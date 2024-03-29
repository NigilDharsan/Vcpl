import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vcpl/Src/Common_Widgets/Common_List.dart';
import 'package:vcpl/Src/Common_Widgets/Custom_App_Bar.dart';
import 'package:vcpl/Src/Common_Widgets/Text_Form_Field.dart';
import 'package:vcpl/Src/Models/CommonListModel.dart';
import 'package:vcpl/Src/Utilits/Common_Colors.dart';
import 'package:vcpl/Src/Utilits/Text_Style.dart';

class Shop_Transaction_Screen extends ConsumerStatefulWidget {
  List<ListData> sitenameData = [];

  Shop_Transaction_Screen(this.sitenameData, {super.key});

  @override
  ConsumerState<Shop_Transaction_Screen> createState() =>
      _Shop_Transaction_ScreenState();
}

class _Shop_Transaction_ScreenState
    extends ConsumerState<Shop_Transaction_Screen> {
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
  List<String> materialNameOption = [
    "Paint",
    "Brush",
  ];
  TextEditingController _openingBalance = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white3,
      appBar: Custom_AppBar(
        title: 'Shop Transactions',
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
                height: 15,
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
                            child: _cementHistoryList(context),
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

Widget _cementHistoryList(context) {
  return ListView.builder(
    itemCount: 5,
    shrinkWrap: true,
    scrollDirection: Axis.vertical,
    physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (BuildContext context, int index) {
      return Common_Transaction(
        context,
        isTag: 'Transfer',
        Date: '15 November 2023',
        MaterialName: '1.2 Cross Ledger',
        Quantity: '50',
      );
    },
  );
}
