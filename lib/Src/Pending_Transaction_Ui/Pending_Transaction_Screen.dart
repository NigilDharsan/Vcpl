import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vcpl/Src/Common_Widgets/Common_List.dart';
import 'package:vcpl/Src/Common_Widgets/Custom_App_Bar.dart';
import 'package:vcpl/Src/Common_Widgets/Text_Form_Field.dart';
import 'package:vcpl/Src/Models/CommonListModel.dart';
import 'package:vcpl/Src/Models/CommonModel.dart';
import 'package:vcpl/Src/Utilits/ApiService.dart';
import 'package:vcpl/Src/Utilits/Common_Colors.dart';
import 'package:vcpl/Src/Utilits/ConstantsApi.dart';
import 'package:vcpl/Src/Utilits/Generic.dart';
import 'package:vcpl/Src/Utilits/Loading_Overlay.dart';

class Pending_Transaction_Screen extends ConsumerStatefulWidget {
  String pendingType = "";

  Pending_Transaction_Screen(this.pendingType, {super.key});

  @override
  ConsumerState<Pending_Transaction_Screen> createState() =>
      _Pending_Transaction_ScreenState();
}

class _Pending_Transaction_ScreenState
    extends ConsumerState<Pending_Transaction_Screen> {
  List<ListData> pendingApprovalList = [];
  String urlType = "";
  String acceptUrlType = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.pendingType == "Cement Transactions") {
      urlType = ConstantApi.pendingApprovalCementTransactions;
    } else if (widget.pendingType == "Centering Transactions") {
      urlType = ConstantApi.pendingApprovalCenteringTransactions;
    } else if (widget.pendingType == "ToolsandPlants Transactions") {
      urlType = ConstantApi.pending_approval_toolsandplants_transactions;
    } else if (widget.pendingType == "Lorry Transactions") {
      urlType = ConstantApi.pending_approval_lorry_transactions;
    }
    LoadingOverlay.show(context);
    getPendingList(urlType);
  }

  getPendingList(String url) async {
    final apiService = ApiService(ref.read(dioProvider));

    final postResponse = await apiService.post1<CommonListModel>(url);
    LoadingOverlay.hide();

    if (postResponse.success == true) {
      if ((postResponse.data?.length ?? 0) > 0) {
        setState(() {
          pendingApprovalList = postResponse.data!;
        });
      } else {
        setState(() {
          pendingApprovalList = [];
        });
        ShowToastMessage("No Pending Action");
      }
    } else {}
  }

  acceptApicall(String url, FormData formData) async {
    LoadingOverlay.show(context);

    final apiService = ApiService(ref.read(dioProvider));

    final postResponse = await apiService.post<CommonModel>(url, formData);

    if (postResponse.success == true) {
      ShowToastMessage(postResponse.message ?? "");

      getPendingList(urlType);
    } else {
      LoadingOverlay.hide();
      ShowToastMessage(postResponse.message ?? "");
    }
  }

  declineApicall(String url, FormData formData) async {
    LoadingOverlay.show(context);

    final apiService = ApiService(ref.read(dioProvider));

    final postResponse = await apiService.post<CommonModel>(url, formData);

    if (postResponse.success == true) {
      ShowToastMessage(postResponse.message ?? "");

      getPendingList(urlType);
    } else {
      LoadingOverlay.hide();

      ShowToastMessage(postResponse.message ?? "");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white1,
      appBar: Custom_AppBar(
        title: 'Pending Transactions',
        actions: null,
        isNav: true,
        isBlue: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),
            textFormFieldSearchBar(
              keyboardtype: TextInputType.text,
              hintText: "Search ...",
              Controller: null,
              validating: null,
              onChanged: null,
              onTap: () {},
            ),
            Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ListView.builder(
                  itemCount: pendingApprovalList.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Pending_Transaction(
                      context,
                      isTag: 'Issued',
                      onPressAccept: () {
                        if (widget.pendingType == "Cement Transactions") {
                          acceptUrlType = ConstantApi.acceptCementTransaction;
                        } else if (widget.pendingType ==
                            "Centering Transactions") {
                          acceptUrlType =
                              ConstantApi.acceptCenteringTransaction;
                        } else if (widget.pendingType ==
                            "ToolsandPlants Transactions") {
                          acceptUrlType =
                              ConstantApi.accept_toolsandplants_transaction;
                        } else if (widget.pendingType == "Lorry Transactions") {
                          acceptUrlType = ConstantApi.accept_lorry_transaction;
                        }

                        final getObj = pendingApprovalList[index];

                        var formData = FormData.fromMap({
                          "to_site_id": getObj.toSiteId,
                          "quantity": getObj.quantity,
                          "ctid": getObj.ctid,
                          "material_id": getObj.materialId
                        });

                        acceptApicall(acceptUrlType, formData);
                      },
                      onPressDecline: () {
                        if (widget.pendingType == "Cement Transactions") {
                          acceptUrlType = ConstantApi.declineCementTransaction;
                        } else if (widget.pendingType ==
                            "Centering Transactions") {
                          acceptUrlType =
                              ConstantApi.declineCenteringTransaction;
                        } else if (widget.pendingType ==
                            "ToolsandPlants Transactions") {
                          acceptUrlType =
                              ConstantApi.decline_toolsandplants_transaction;
                        } else if (widget.pendingType == "Lorry Transactions") {
                          acceptUrlType = ConstantApi.decline_lorry_transaction;
                        }

                        final getObj = pendingApprovalList[index];

                        var formData = FormData.fromMap({
                          "site_id": getObj.currentSiteId,
                          "quantity": getObj.quantity,
                          "ctid": getObj.ctid,
                          "material_id": getObj.materialId
                        });

                        declineApicall(acceptUrlType, formData);
                      },
                      pendingTrans: pendingApprovalList[index],
                    );
                  },
                )),
          ],
        ),
      ),
    );
  }
}
