import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vcpl/Src/Common_Widgets/Common_Button.dart';
import 'package:vcpl/Src/Common_Widgets/Custom_App_Bar.dart';
import 'package:vcpl/Src/Common_Widgets/Text_Form_Field.dart';
import 'package:vcpl/Src/Models/CommonListModel.dart';
import 'package:vcpl/Src/Models/CommonModel.dart';
import 'package:vcpl/Src/Utilits/ApiService.dart';
import 'package:vcpl/Src/Utilits/Common_Colors.dart';
import 'package:vcpl/Src/Utilits/ConstantsApi.dart';
import 'package:vcpl/Src/Utilits/Image_Path.dart';
import 'package:vcpl/Src/Utilits/Loading_Overlay.dart';
import 'package:vcpl/Src/utilits/Text_Style.dart';

class Add_Labours_Assigning_Screen extends ConsumerStatefulWidget {
  List<ListData> siteListData = [];

  Add_Labours_Assigning_Screen(this.siteListData, {super.key});

  @override
  ConsumerState<Add_Labours_Assigning_Screen> createState() =>
      _Add_Labours_Assigning_ScreenState();
}

class _Add_Labours_Assigning_ScreenState
    extends ConsumerState<Add_Labours_Assigning_Screen> {
  void _incrementFunction(int index) {
    setState(() {
      laboursCategoryList[index].labourCount += 1;
    });
  }

  void _decrementFunction(int index) {
    setState(() {
      if (laboursCategoryList[index].labourCount > 0)
        laboursCategoryList[index].labourCount -= 1;
    });
  }

  String? site_id;

  String? selectSite;
  List<String> selectSiteOption = [
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
  String? subContractor_id;

  String? subContractor;
  List<String> subContractorOption = [
    "MANI",
    "PALPANDI",
    "ANBU",
    "SANJIVI",
  ];

  String? shift;
  List<String> shiftOption = [
    "6AM-9AM",
    "9AM-6PM",
    "After 7PM",
  ];

  List<ListData> laboursCategoryList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    selectSiteOption =
        widget.siteListData.map((e) => e.siteName ?? "").toList();
    subContractorOption =
        widget.siteListData.map((e) => e.subContractor ?? "").toList();

    getLabourList();
  }

  void getLabourList() async {
    LoadingOverlay.show(context);

    final apiService = ApiService(ref.read(dioProvider));

    final postResponse =
        await apiService.post1<CommonListModel>(ConstantApi.laboursCategory);
    LoadingOverlay.hide();
    if (postResponse.success == true) {
      setState(() {
        laboursCategoryList = postResponse.data!;
      });
    }
  }

  void assignLabours(FormData formData) async {
    LoadingOverlay.show(context);

    final apiService = ApiService(ref.read(dioProvider));

    final postResponse =
        await apiService.post<CommonModel>(ConstantApi.assignLabour, formData);
    LoadingOverlay.hide();
    if (postResponse.success == true) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white3,
      appBar: Custom_AppBar(
          title: "Add Labours Assigning",
          actions: null,
          isBlue: true,
          isNav: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //SITE NAME
              Title_Style(Title: 'Site Name ', isStatus: true),
              dropDownField(
                context,
                value: selectSite,
                listValue: selectSiteOption,
                onChanged: (String? newValue) {
                  setState(() {
                    selectSite = newValue;
                    ListData result = widget.siteListData
                        .firstWhere((value) => value.siteName == newValue);
                    site_id = '${result.id ?? 0}';
                  });
                },
                hint: 'Select Site',
              ),
              //SUB CONTRACTOR
              Title_Style(Title: 'Sub Contractor ', isStatus: true),
              dropDownField(
                context,
                value: subContractor,
                listValue: subContractorOption,
                onChanged: (String? newValue) {
                  setState(() {
                    subContractor = newValue;

                    ListData result = widget.siteListData
                        .firstWhere((value) => value.subContractor == newValue);
                    subContractor_id = '${result.subContractorId ?? 0}';
                  });
                },
                hint: 'Select Sub Contractor',
              ),
              //SUB CONTRACTOR
              Title_Style(Title: 'Shift ', isStatus: true),
              dropDownField(
                context,
                value: shift,
                listValue: shiftOption,
                onChanged: (String? newValue) {
                  setState(() {
                    shift = newValue;
                  });
                },
                hint: 'Select',
              ),

              //LIST OF LABOUR CATEGORY
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Row(
                  children: [
                    Text(
                      'Labour Category',
                      style: Textfield_Style2,
                    ),
                    const Spacer(),
                    Text(
                      'No of Labours',
                      style: Textfield_Style2,
                    ),
                  ],
                ),
              ),

              Container(child: _Labour_Assigning_List()),

              //SUBMIT BUTTON
              Padding(
                padding: const EdgeInsets.only(
                    top: 50, bottom: 50, left: 30, right: 30),
                child: CommonElevatedButton(context, 'Submit', () {
                  var formData = FormData.fromMap({
                    "site_id": 4,
                    "sub_contractor_id": 113,
                    "shift_id": shift == "6AM-9AM"
                        ? 1
                        : shift == "9AM-6PM"
                            ? 2
                            : shift == "After 7PM"
                                ? 3
                                : 1
                  });

                  for (int i = 0; i < 5; i++) {
                    var obj = laboursCategoryList[i].labourCount;
                    if (obj > 0) {
                      formData.fields
                          .add(MapEntry('labours_count[$i][labours]', '$obj'));
                    }
                  }

                  assignLabours(formData);
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //LABOUR ASSIGNING
  Widget _Labour_Assigning_List() {
    return ListView.builder(
      itemCount: laboursCategoryList.length,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: Text(
                    "${laboursCategoryList[index].categoryName}",
                    style: Textfield_Style,
                    maxLines: 2,
                    textAlign: TextAlign.start,
                  )),
              const Spacer(),
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: white1,
                ),
                child: Row(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, bottom: 10, left: 10),
                      child: InkWell(
                          onTap: () {
                            _decrementFunction(index);
                          },
                          child: ImgPathSvg('down.svg')),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text('${laboursCategoryList[index].labourCount}'),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 10, top: 10, bottom: 10),
                      child: InkWell(
                          onTap: () {
                            _incrementFunction(index);
                          },
                          child: ImgPathSvg('up.svg')),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
