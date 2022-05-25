import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../config/app_colors.dart';
import '../../models/suppli_tea.dart';
import '../../providers/supply_killo_provider.dart';

// ignore: must_be_immutable
class SuppliedKilosTab extends StatefulWidget {
  List<SuppliTea> suppledKilos;
  SuppliedKilosTab({Key? key, required this.suppledKilos}) : super(key: key);
  @override
  _SuppliedKilosTabState createState() => _SuppliedKilosTabState();
}

class _SuppliedKilosTabState extends State<SuppliedKilosTab> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return SingelListTileForSuppledTea(
            list: widget.suppledKilos, index: index);
      },
      itemCount: widget.suppledKilos.length,
    );
  }
}

// ignore: must_be_immutable
class SingelListTileForSuppledTea extends StatefulWidget {
  List<SuppliTea> list;
  int index;
  SingelListTileForSuppledTea(
      {Key? key, required this.list, required this.index})
      : super(key: key);
  @override
  _SingelListTileForSuppledTeaState createState() =>
      _SingelListTileForSuppledTeaState();
}

class _SingelListTileForSuppledTeaState
    extends State<SingelListTileForSuppledTea> {
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
                      const Icon(
                        Icons.calendar_today_rounded,
                        color: AppColors.buttonColorDarkGreen,
                      ),
                      Text(
                          DateFormat('MM/dd/yyyy HH:mm')
                              .format(widget.list[widget.index].date),
                          style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.black,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("KG :",
                          style: TextStyle(
                              fontSize: 16,
                              color: AppColors.appBarGradientDarkGreen,
                              fontWeight: FontWeight.bold)),
                      Text(widget.list[widget.index].amount.toString(),
                          style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.black,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  CircleAvatar(
                    backgroundColor: AppColors.buttonColorDarkGrey,
                    child: Text(
                        widget.list[widget.index].numberOfBages.toString(),
                        style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.black,
                            fontWeight: FontWeight.bold)),
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
                  color: Colors.grey[200],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          DateFormat('MM/dd/yyyy HH:mm')
                              .format(widget.list[widget.index].time),
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
                                                        widget
                                                            .list[widget.index]
                                                            .date
                                                            .toIso8601String(),
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
                                                    const Text("Kg :",
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
                                            Provider.of<SuppliKilloProvider>(
                                                    context,
                                                    listen: false)
                                                .deleOneSuppledTransaction(
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
