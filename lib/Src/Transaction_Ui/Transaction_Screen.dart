import 'package:flutter/material.dart';
import 'package:vcpl/Src/Common_Widgets/Custom_App_Bar.dart';
import 'package:vcpl/Src/Common_Widgets/Text_Form_Field.dart';
import 'package:vcpl/Src/Utilits/Common_Colors.dart';
import 'package:vcpl/Src/Utilits/Text_Style.dart';

class Cement_Transaction extends StatefulWidget {
  const Cement_Transaction({super.key});

  @override
  State<Cement_Transaction> createState() => _Cement_TransactionState();
}

class _Cement_TransactionState extends State<Cement_Transaction> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white3,
        appBar: Custom_AppBar(title: 'Cement Transaction', actions: null,isNav: null, isBlue: true,),
        body: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 25,),
            Title_Style(Title: 'Site Name', isStatus: true),
            Container(
              width: MediaQuery.of(context).size.width/2,
              child: dropDownField(
                context,
                value: workTypeOption,
                listValue: workTypeVal,
                onChanged: (String? newValue) {
                  setState(() {
                    workTypeOption = newValue;
                  });
                }, hint: 'Site Name',
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 25,bottom: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: white1
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10,right: 10),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20, bottom: 20),
                      child: textFormFieldSearchBar(
                        keyboardtype: TextInputType.text,
                        hintText: "Search ...",
                        Controller: null,
                        validating: null,
                        onChanged: null, onTap: () {  },
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height/1.7,
                        child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: _cementHistoryList(context),
                            ))),
                  ],
                ),
              ),
            ),

          ],
    ),
        ),
    );
  }
}

Widget _cementHistoryList(context){
  return ListView.builder(
    itemCount: 5,
    shrinkWrap: true,
    scrollDirection: Axis.vertical,
    physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (BuildContext context, int index) {
      return     Container(
        width: MediaQuery.of(context).size.width/1.5,
        margin: EdgeInsets.only(bottom: 20,),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: white3
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10,right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin: EdgeInsets.only(top: 15,bottom: 20),
                  alignment:Alignment.topLeft,
                  child: Row(
                    children: [
                      Text('Date : ',style: cardDetailT,),
                      Text('15 November 2023',style: DateT,),
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Quantity : ',style:cardDetailT ,),
                    Center(child: Text('50',style: TBlack,)),
                    Icon(Icons.arrow_downward_sharp,size: 25,color: green7,),

                    const Spacer(),
                    Container(
                      alignment: Alignment.topLeft,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: pink3
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                          child: Text('Issued',style: red,),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

    },);

}
