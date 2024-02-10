import 'package:flutter/material.dart';
import 'package:vcpl/Src/Models/CommonListModel.dart';
import 'package:vcpl/Src/Utilits/Common_Colors.dart';
import 'package:vcpl/Src/Utilits/Text_Style.dart';

//Transaction List
Widget Transaction_List(context,
    {required String isTag, required ListData transactiondata}) {
  Color? containerColor;
  TextStyle? style;
  switch (isTag) {
    case "Issued":
      containerColor = pink3;
      style = red;
      break;
    case "Transfer":
      containerColor = blue2;
      style = blue;
      break;
    case "Received":
      containerColor = green3;
      style = green;
      break;
    default:
      containerColor = Colors.white;
      break;
  }
  return Container(
    width: MediaQuery.of(context).size.width / 1.5,
    margin: EdgeInsets.only(
      bottom: 20,
    ),
    decoration:
        BoxDecoration(borderRadius: BorderRadius.circular(10), color: white3),
    child: Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: EdgeInsets.only(top: 15, bottom: 20),
              alignment: Alignment.topLeft,
              child: Row(
                children: [
                  Text(
                    'Date : ',
                    style: cardDetailT,
                  ),
                  Text(
                    '${transactiondata.createdAt}',
                    style: DateT,
                  ),
                ],
              )),
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Quantity : ',
                  style: cardDetailT,
                ),
                Center(
                    child: Text(
                  '${transactiondata.quantity}',
                  style: TBlack,
                )),
                isTag == "Issued"
                    ? Icon(
                        Icons.arrow_downward_sharp,
                        size: 25,
                        color: Color.fromRGBO(255, 0, 13, 1),
                      )
                    : isTag == "Transfer Cement"
                        ? Icon(
                            Icons.compare_arrows_sharp,
                            size: 25,
                            color: Color.fromRGBO(0, 160, 226, 1),
                          )
                        : isTag == "Received Cement"
                            ? Icon(
                                Icons.arrow_upward,
                                size: 25,
                                color: Color.fromRGBO(61, 186, 40, 1),
                              )
                            : Container(),
                const Spacer(),
                Container(
                    alignment: Alignment.topLeft,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: containerColor),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 5, bottom: 5),
                      child: Text(
                        isTag,
                        style: style,
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

//COMMON TRANSACTION
Widget Common_Transaction(context,
    {required String isTag,
    required String Date,
    required String MaterialName,
    required String Quantity}) {
  Color? containerColor;
  TextStyle? style;
  switch (isTag) {
    case "Issued":
      containerColor = pink3;
      style = red;
      break;
    case "Transfer":
      containerColor = blue2;
      style = blue;
      break;
    case "Purchased":
      containerColor = blue2;
      style = blue;
      break;
    case "Received":
      containerColor = green3;
      style = green;
      break;
    default:
      containerColor = Colors.white;
      break;
  }
  return Container(
    width: MediaQuery.of(context).size.width / 1.5,
    margin: EdgeInsets.only(
      bottom: 20,
    ),
    decoration:
        BoxDecoration(borderRadius: BorderRadius.circular(10), color: white3),
    child: Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: EdgeInsets.only(top: 15, bottom: 10),
              alignment: Alignment.topLeft,
              child: Row(
                children: [
                  Text(
                    'Date : ',
                    style: cardDetailT,
                  ),
                  Text(
                    Date,
                    style: DateT,
                  ),
                ],
              )),
          Container(
              margin: EdgeInsets.only(bottom: 15),
              alignment: Alignment.topLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Material Name : ',
                    style: cardDetailT,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width / 2.4,
                      child: Text(
                        MaterialName,
                        style: DateT,
                        maxLines: 2,
                      )),
                ],
              )),
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Quantity : ',
                  style: cardDetailT,
                ),
                Center(
                    child: Text(
                  Quantity,
                  style: TBlack,
                )),
                isTag == "Transfer"
                    ? Icon(
                        Icons.compare_arrows_sharp,
                        size: 25,
                        color: Color.fromRGBO(0, 160, 226, 1),
                      )
                    : isTag == "Received"
                        ? Icon(
                            Icons.arrow_upward,
                            size: 25,
                            color: Color.fromRGBO(61, 186, 40, 1),
                          )
                        : Container(),
                const Spacer(),
                Container(
                    alignment: Alignment.topLeft,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: containerColor),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 5, bottom: 5),
                      child: Text(
                        isTag,
                        style: style,
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

//PENDING TRANSACTION
Widget Pending_Transaction(context,
    {required String isTag,
    required ListData pendingTrans,
    void Function()? onPressAccept,
    void Function()? onPressDecline}) {
  Color? containerColor;
  TextStyle? style;
  switch (isTag) {
    case "Issued":
      containerColor = pink3;
      style = red;
      break;
    case "Transfer":
      containerColor = blue2;
      style = blue;
      break;
    case "Received":
      containerColor = green3;
      style = green;
      break;
    default:
      containerColor = Colors.white;
      break;
  }
  return Container(
    width: MediaQuery.of(context).size.width,
    margin: EdgeInsets.only(
      bottom: 20,
    ),
    decoration:
        BoxDecoration(borderRadius: BorderRadius.circular(10), color: white3),
    child: Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: EdgeInsets.only(top: 15, bottom: 20),
              alignment: Alignment.topLeft,
              child: Row(
                children: [
                  Text(
                    'Date : ',
                    style: cardDetailT,
                  ),
                  Text(
                    pendingTrans.createdAt ?? "",
                    style: DateT,
                  ),
                ],
              )),
          Container(
              margin: EdgeInsets.only(bottom: 20),
              alignment: Alignment.topLeft,
              child: Row(
                children: [
                  Text(
                    'Site Name : ',
                    style: cardDetailT,
                  ),
                  Text(
                    pendingTrans.siteName ?? "",
                    style: DateT,
                  ),
                ],
              )),
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Quantity : ',
                  style: cardDetailT,
                ),
                Center(
                    child: Text(
                  '${pendingTrans.quantity ?? 0}',
                  style: TBlack,
                )),
                const Spacer(),
                InkWell(
                  onTap: onPressAccept,
                  child: Container(
                      alignment: Alignment.topLeft,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5), color: blue1),
                      child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Icon(
                            Icons.check,
                            color: white1,
                          ))),
                ),
                InkWell(
                  onTap: onPressDecline,
                  child: Container(
                      margin: EdgeInsets.only(left: 10),
                      alignment: Alignment.topLeft,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5), color: red1),
                      child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Icon(
                            Icons.close,
                            color: white1,
                          ))),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
