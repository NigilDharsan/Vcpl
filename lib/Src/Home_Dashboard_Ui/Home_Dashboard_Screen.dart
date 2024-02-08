import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vcpl/Src/Common_Widgets/Common_Pop_Up.dart';
import 'package:vcpl/Src/Models/CommonListModel.dart';
import 'package:vcpl/Src/Models/LoginModel.dart';
import 'package:vcpl/Src/Models/VehicleModel.dart';
import 'package:vcpl/Src/Utilits/ApiService.dart';
import 'package:vcpl/Src/Utilits/Common_Colors.dart';
import 'package:vcpl/Src/Utilits/ConstantsApi.dart';
import 'package:vcpl/Src/Utilits/Generic.dart';
import 'package:vcpl/Src/Utilits/Loading_Overlay.dart';
import 'package:vcpl/Src/Utilits/Text_Style.dart';

import '../Common_Widgets/Custom_App_Bar.dart';

class Home_Dashboard_Screen extends ConsumerStatefulWidget {
  List<Permissions>? permissionsList;

  Home_Dashboard_Screen(this.permissionsList, {super.key});

  @override
  ConsumerState<Home_Dashboard_Screen> createState() =>
      _Home_Dashboard_ScreenState();
}

class _Home_Dashboard_ScreenState extends ConsumerState<Home_Dashboard_Screen> {
  List<ListData> sitenameData = [];
  List<ListData> siteListData = [];
  List<VehicleData> vechileNumberOtion = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    initalApiCalls();
  }

  void initalApiCalls() async {
    LoadingOverlay.show(context);

    await getSiteList();
    await getSiteNameList();
    await getVehicleList();

    LoadingOverlay.hide();
  }

  getSiteNameList() async {
    final apiService = ApiService(ref.read(dioProvider));

    var formData = FormData.fromMap({"user_id": await getUserID()});

    final postResponse = await apiService.post<CommonListModel>(
        ConstantApi.siteInfoUrl, formData);
    if (postResponse.success == true) {
      setState(() {
        sitenameData = postResponse.data!;
      });
    }
  }

  getSiteList() async {
    final apiService = ApiService(ref.read(dioProvider));

    final postResponse =
        await apiService.post1<CommonListModel>(ConstantApi.siteListUrl);
    if (postResponse.success == true) {
      setState(() {
        siteListData = postResponse.data!;
      });
    }
  }

  getVehicleList() async {
    final apiService = ApiService(ref.read(dioProvider));

    final postResponse =
        await apiService.post1<VehicleModel>(ConstantApi.vehicleListUrl);
    if (postResponse.success == true) {
      setState(() {
        vechileNumberOtion = postResponse.data!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white3,
      appBar: Custom_AppBar(
        title: 'Dashboard',
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: CircleAvatar(
              radius: 15,
              backgroundColor: grey3,
              child: Icon(
                Icons.person,
                size: 20,
              ),
            ),
          ),
        ],
        isNav: null,
        isBlue: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 35),
                  child: DashBoard_List(widget.permissionsList ?? [],
                      sitenameData, siteListData, vechileNumberOtion),
                ),
                // //Cement Transactions && Labours Assigning
                // Padding(
                //   padding: const EdgeInsets.only(bottom: 20, top: 20),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       InkWell(
                //           onTap: () {
                //             showDialog(
                //               context: context,
                //               builder: (BuildContext context) {
                //                 return Cement_Pop_Up(context, sitenameData,
                //                     siteListData, vechileNumberOtion);
                //               },
                //             );
                //           },
                //           child: _DashBoardCard(context,
                //               cardTitle: 'Cement Transactions',
                //               cardImg: 'payment.svg')),
                //       const Spacer(),
                //       InkWell(
                //           onTap: () {
                //             showDialog(
                //               context: context,
                //               builder: (BuildContext context) {
                //                 return Labour_Pop_Up(context, siteListData);
                //               },
                //             );
                //           },
                //           child: _DashBoardCard(context,
                //               cardTitle: 'Labours Assigning',
                //               cardImg: 'Document.svg')),
                //     ],
                //   ),
                // ),
                // //Centering Transaction && Tools&Plants Transaction
                // Padding(
                //   padding: const EdgeInsets.only(bottom: 20),
                //   child: Row(
                //     children: [
                //       InkWell(
                //           onTap: () {
                //             showDialog(
                //               context: context,
                //               builder: (BuildContext context) {
                //                 return Centering_Pop_Up(context, sitenameData,
                //                     siteListData, vechileNumberOtion);
                //               },
                //             );
                //           },
                //           child: _DashBoardCard(context,
                //               cardTitle: 'Centering Transaction',
                //               cardImg: 'Document.svg')),
                //       const Spacer(),
                //       InkWell(
                //           onTap: () {
                //             showDialog(
                //               context: context,
                //               builder: (BuildContext context) {
                //                 return Tools_Pop_Up(context, sitenameData,
                //                     siteListData, vechileNumberOtion);
                //               },
                //             );
                //           },
                //           child: _DashBoardCard(context,
                //               cardTitle: 'Tools&Plants Transaction',
                //               cardImg: 'Document.svg')),
                //     ],
                //   ),
                // ),
                // //Lorry Transactions && Shop Transactions
                // Padding(
                //   padding: const EdgeInsets.only(bottom: 20),
                //   child: Row(
                //     children: [
                //       InkWell(
                //           onTap: () {
                //             showDialog(
                //               context: context,
                //               builder: (BuildContext context) {
                //                 return Lorry_Pop_Up(context, sitenameData,
                //                     siteListData, vechileNumberOtion);
                //               },
                //             );
                //           },
                //           child: _DashBoardCard(context,
                //               cardTitle: 'Lorry Transactions',
                //               cardImg: 'Document.svg')),
                //       const Spacer(),
                //       InkWell(
                //           onTap: () {
                //             showDialog(
                //               context: context,
                //               builder: (BuildContext context) {
                //                 return Shop_Pop_Up(context, sitenameData);
                //               },
                //             );
                //           },
                //           child: _DashBoardCard(context,
                //               cardTitle: 'Shop Transactions',
                //               cardImg: 'Document.svg')),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget DashBoard_List(
    List<Permissions> permissionsList,
    List<ListData> sitenameData,
    List<ListData> siteListData,
    List<VehicleData> vechileNumberOtion) {
  return Container(
    child: GridView.builder(
      itemCount: permissionsList.length,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: InkWell(
              onTap: () {
                if (permissionsList[index].name == "Cement Transactions") {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Cement_Pop_Up(context, sitenameData, siteListData,
                          vechileNumberOtion);
                    },
                  );
                } else if (permissionsList[index].name ==
                    "Centering Transactions") {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Centering_Pop_Up(context, sitenameData,
                          siteListData, vechileNumberOtion);
                    },
                  );
                } else if (permissionsList[index].name ==
                    "ToolsandPlants Transactions") {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Tools_Pop_Up(context, sitenameData, siteListData,
                          vechileNumberOtion);
                    },
                  );
                } else if (permissionsList[index].name ==
                    "Lorry Transactions") {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Lorry_Pop_Up(context, sitenameData, siteListData,
                          vechileNumberOtion);
                    },
                  );
                } else if (permissionsList[index].name == "Labours Assigning") {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Labour_Pop_Up(context, siteListData);
                      });
                } else {}
              },
              child: _DashBoardCard(context,
                  cardData: permissionsList[index], cardImg: 'payment.svg')),
        );
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 4.0,
      ),
    ),
  );
}

Widget _DashBoardCard(context,
    {required Permissions cardData, required String cardImg}) {
  return Card(
    elevation: 5,
    child: Container(
      width: MediaQuery.of(context).size.width / 2.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: white1,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //COUNT
            Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: Icon(
                    Icons.shopping_cart_rounded,
                    color: blue3,
                    size: 45,
                  )),
                  SizedBox(
                    height: 5,
                  ),
                  //CARD TITLE
                  Container(
                    width: 150,
                    child: Text(
                      cardData.name ?? "",
                      style: cardT,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
