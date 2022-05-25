import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../config/app_colors.dart';
import '../../models/advance_payment.dart';
import '../../providers/advance_payment_provider.dart';

// ignore: must_be_immutable
class AdvancePaymentTab extends StatefulWidget {
  List<AdvancePayment> advancepaymentList;
  AdvancePaymentTab({Key? key, required this.advancepaymentList})
      : super(key: key);
  @override
  _AdvancePaymentTabState createState() => _AdvancePaymentTabState();
}

class _AdvancePaymentTabState extends State<AdvancePaymentTab> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return SingelListTileOfAdvancepyamet(
            list: widget.advancepaymentList, index: index);
      },
      itemCount: widget.advancepaymentList.length,
    );
  }
}

// ignore: must_be_immutable
class SingelListTileOfAdvancepyamet extends StatefulWidget {
  List<AdvancePayment> list;
  int index;
  SingelListTileOfAdvancepyamet(
      {Key? key, required this.list, required this.index})
      : super(key: key);
  @override
  _SingelListTileOfAdvancepyametState createState() =>
      _SingelListTileOfAdvancepyametState();
}

class _SingelListTileOfAdvancepyametState
    extends State<SingelListTileOfAdvancepyamet> {
  bool isExpand = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 2,
                        color: Colors.green,
                      ),
                      const Icon(
                        Icons.calendar_today_rounded,
                        color: AppColors.buttonColorDarkGreen,
                      ),
                      Text(
                          DateFormat('MM/dd/yyyy HH:mm')
                              .format(widget.list[widget.index].date),

                          // widget.list[widget.index].date,
                          style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.black,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(
                        Icons.monetization_on,
                        color: AppColors.buttonColorDarkGreen,
                      ),
                      Text(widget.list[widget.index].amount.toString(),
                          style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.black,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          isExpand = !isExpand;
                        });
                      },
                      icon: !isExpand
                          ? const Icon(Icons.keyboard_arrow_down_outlined)
                          : const Icon(
                              Icons.keyboard_arrow_up_rounded,
                            ),
                    ),
                  ),
                ],
              ),
            ),
            if (isExpand)
              SizedBox(
                height: 90,
                width: MediaQuery.of(context).size.width,
                child: Card(
                  color: Colors.grey[400],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          widget.list[widget.index].description,
                          style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontStyle: FontStyle.italic),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                      title: const Text(
                                          'Are you sure you want to delete this'),
                                      content: SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.25,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Card(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Icon(
                                                      Icons
                                                          .calendar_today_rounded,
                                                      color: AppColors
                                                          .buttonColorDarkGreen,
                                                    ),
                                                    Text(
                                                        DateFormat('MM/yyyy/dd')
                                                            .format(widget
                                                                .list[widget
                                                                    .index]
                                                                .date),
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            color:
                                                                AppColors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Card(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Text("Amount :",
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color: AppColors
                                                                .appBarGradientDarkGreen,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    Text(
                                                        widget
                                                            .list[widget.index]
                                                            .amount
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            color:
                                                                AppColors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Card(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Icon(
                                                      Icons.account_box,
                                                      color: AppColors
                                                          .buttonColorDarkGreen,
                                                    ),
                                                    Text(
                                                        widget
                                                            .list[widget.index]
                                                            .customerId,
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            color:
                                                                AppColors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Provider.of<AdvancePaymentProvider>(
                                                    context,
                                                    listen: false)
                                                .deleOneAdvancePaymentTransaction(
                                                    widget
                                                        .list[widget.index].id,
                                                    widget.list[widget.index]
                                                        .customerId);
                                            Navigator.of(ctx).pop();
                                          },
                                          child: const Text('Ok'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(ctx).pop();
                                          },
                                          child: const Text('Cancle',
                                              style:
                                                  TextStyle(color: Colors.red)),
                                        )
                                      ],
                                    ),
                                  );
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
