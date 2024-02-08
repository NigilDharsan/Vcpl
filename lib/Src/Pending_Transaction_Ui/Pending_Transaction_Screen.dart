import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vcpl/Src/Common_Widgets/Common_List.dart';
import 'package:vcpl/Src/Common_Widgets/Custom_App_Bar.dart';
import 'package:vcpl/Src/Common_Widgets/Text_Form_Field.dart';
import 'package:vcpl/Src/Models/CommonListModel.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    String urlType = "";

    if (widget.pendingType == "Cement Transactions") {
      urlType = ConstantApi.pendingApprovalCementTransactions;
    } else if (widget.pendingType == "Centering Transactions") {
      urlType = ConstantApi.pendingApprovalCenteringTransactions;
    } else if (widget.pendingType == "ToolsandPlants Transactions") {
      urlType = ConstantApi.pending_approval_toolsandplants_transactions;
    } else if (widget.pendingType == "Lorry Transactions") {
      urlType = ConstantApi.pending_approval_lorry_transactions;
    }

    getPendingList(urlType);
  }

  getPendingList(String url) async {
    LoadingOverlay.show(context);

    final apiService = ApiService(ref.read(dioProvider));

    final postResponse = await apiService
        .post1<CommonListModel>(ConstantApi.pendingApprovalCementTransactions);
    LoadingOverlay.hide();

    if (postResponse.success == true) {
      if ((postResponse.data?.length ?? 0) > 0) {
        setState(() {
          pendingApprovalList = postResponse.data!;
        });
      } else {
        ShowToastMessage("No Pending Action");
      }
    } else {}
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
                    );
                  },
                )),
          ],
        ),
      ),
    );
  }
}
