import 'package:flutter/material.dart';
import 'package:vcpl/Src/Common_Widgets/Custom_App_Bar.dart';
import 'package:vcpl/Src/Common_Widgets/Text_Form_Field.dart';
import 'package:vcpl/Src/Utilits/Common_Colors.dart';
import 'package:vcpl/Src/Utilits/Image_Path.dart';
import 'package:vcpl/Src/utilits/Text_Style.dart';

class Add_Labours_Assigning_Screen extends StatefulWidget {
  const Add_Labours_Assigning_Screen({super.key});

  @override
  State<Add_Labours_Assigning_Screen> createState() => _Add_Labours_Assigning_ScreenState();
}

class _Add_Labours_Assigning_ScreenState extends State<Add_Labours_Assigning_Screen> {
  int _count = 0;

  void _incrementFunction(){
    setState(() {
      _count++;
    });
  }
  void _decrementFunction(){
    setState(() {
      _count--;
    });
  }
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white3,
      appBar: Custom_AppBar(title: "Add Labours Assigning", actions: null, isBlue: true, isNav: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20),
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
                  });
                }, hint: 'Select Site',
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
                  });
                }, hint: 'Select Sub Contractor',
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
                }, hint: 'Select',
              ),

              //LIST OF LABOUR CATEGORY
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Row(
                  children: [
                    Text('Labour Category',style: Textfield_Style2,),
                    const Spacer(),
                    Text('No of Labours',style: Textfield_Style2,),
                  ],
                ),
              ),

              Container(
                height: 500,
                  child: _Labour_Assigning_List()),
            ],
          ),
        ),
      ),
    );
  }
  //LABOUR ASSIGNING
  Widget _Labour_Assigning_List(){
    return ListView.builder(
      itemCount: 7,
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
                width: MediaQuery.of(context).size.width/1.5,
                  child: Text("CARPEBENDER",style: Textfield_Style,maxLines: 2,textAlign: TextAlign.start,)),
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
                      padding: const EdgeInsets.only(top: 10,bottom: 10,left: 10),
                      child: InkWell(
                          onTap: (){
                            _decrementFunction();
                          },
                          child: ImgPathSvg('down.svg')),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text('${_count}'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10,top: 10,bottom: 10),
                      child: InkWell(
                          onTap: (){
                            _incrementFunction();
                          },
                          child: ImgPathSvg('up.svg')),
                    ),
                  ],
                ),
              ),

            ],
          ),
        );
        },);
  }

}

