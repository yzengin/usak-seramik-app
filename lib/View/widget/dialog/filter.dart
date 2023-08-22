// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../Controller/filter.dart';
import '../../style/colors.dart';
import '../../../Controller/extension.dart';
import '../../../model/data.dart';

Future appFilterDialog(
  BuildContext context, {
  bool onWillPop = true,
  FilterData? model,
  String routeName = 'filter dialog',
  Color? barrierColor,
}) {
  double radius = 20;
  barrierColor = barrierColor ?? AppColors.primaryColor;

  model ??= testFilter as FilterData?;
  return showDialog(
    context: context,
    barrierColor: Colors.transparent,
    barrierDismissible: onWillPop,
    routeSettings: RouteSettings(name: routeName),
    builder: (context) {
      for (var element in model!.searchFilters!) {
        element.controller.clear();
      }
      for (var element in model.chooseFilters!) {
        element.context.data = -1;
      }
      return StatefulBuilder(builder: (context, setState) {
        return BackdropFilter(
          filter: ColorFilter.mode(Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(.75), BlendMode.srcOver),
          child: Dialog(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 10,
            shadowColor: const Color.fromARGB(180, 0, 0, 0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
            insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: DefaultTextStyle(
              style: Theme.of(context).textTheme.bodyMedium!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(radius),
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(radius * 0.5),
                          child: Column(
                            children: [
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: model!.searchFilters!.length,
                                itemBuilder: (context, index) {
                                  final data = model!.searchFilters![index];
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 10),
                                        child: DecoratedBox(
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(radius * 0.5)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextField(
                                              controller: data.controller,
                                              focusNode: data.node,
                                              textInputAction: index == model.searchFilters!.length - 1 ? TextInputAction.done : TextInputAction.next,
                                              decoration: InputDecoration(border: InputBorder.none, label: Text("${data.filter.context.label}"), floatingLabelAlignment: FloatingLabelAlignment.center),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                              Divider(thickness: 1),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: model.chooseFilters!.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      Padding(
                                        // padding: EdgeInsets.only(bottom: model!.chooseFilters.length - 1 == index ? 0 : 10.0),
                                        padding: const EdgeInsets.only(bottom: 10.0),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(right: 20.0),
                                                child: Row(
                                                  children: [
                                                    Icon(FontAwesomeIcons.circle, size: 15, color: Theme.of(context).textTheme.bodyMedium!.color),
                                                    Padding(padding: const EdgeInsets.only(left: 3.0), child: Icon(FontAwesomeIcons.solidCircle, size: 15, color: Theme.of(context).textTheme.bodyMedium!.color)),
                                                    Padding(padding: const EdgeInsets.only(left: 8.0), child: Text("${model!.chooseFilters![index].context.label}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'avenir'))),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: ListView.builder(
                                                  shrinkWrap: true,
                                                  physics: const NeverScrollableScrollPhysics(),
                                                  padding: EdgeInsets.zero,
                                                  itemCount: model.chooseFilters![index].filters!.length,
                                                  itemBuilder: (BuildContext context, int indexSub) {
                                                    return GestureDetector(
                                                      onTap: () {
                                                        model!.chooseFilters![index].context.data = model.chooseFilters![index].filters![indexSub].context.data;
                                                        setState(() {});
                                                      },
                                                      child: Row(
                                                        children: [
                                                          AnimatedContainer(
                                                            duration: 300.millisecond(),
                                                            width: 15,
                                                            height: 15,
                                                            decoration: BoxDecoration(border: Border.all(width: model!.chooseFilters![index].context.data == model.chooseFilters![index].filters![indexSub].context.data ? 7.5 : 2), shape: BoxShape.circle),
                                                          ),
                                                          Expanded(
                                                              child: Padding(
                                                            padding: const EdgeInsets.only(left: 10.0),
                                                            child: Text("${model.chooseFilters![index].filters![indexSub].context.label}", style: TextStyle(color: model.chooseFilters![index].context.data == model.chooseFilters![index].filters![indexSub].context.data ? Theme.of(context).textTheme.bodyMedium!.color : Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(.5), fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'avenir')),
                                                          )),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                              Divider(thickness: 1),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: model.rangeFilters!.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 10.0),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Icon(FontAwesomeIcons.sliders, size: 15, color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(.5)),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 8.0),
                                                child: Text("${model!.rangeFilters![index].context.label}: ${model.rangeFilters![index].context.data.value.start.toStringAsFixed(0)} ile ${model.rangeFilters![index].context.data.value.end.toStringAsFixed(0)} aralığında", style: TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color, fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'avenir')),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 20.0),
                                          child: RangeSlider(
                                            values: model.rangeFilters![index].context.data.value,
                                            onChangeEnd: (value) {
                                              model!.rangeFilters![index].context.data.value = new RangeValues(value.start, value.end);
                                              setState(() {});
                                            },
                                            onChangeStart: (value) {
                                              model!.rangeFilters![index].context.data.value = new RangeValues(value.start, value.end);
                                              setState(() {});
                                            },
                                            onChanged: (RangeValues value) {
                                              model!.rangeFilters![index].context.data.value = new RangeValues(value.start, value.end);
                                              setState(() {});
                                            },
                                            activeColor: Theme.of(context).textTheme.bodyMedium!.color,
                                            inactiveColor: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(.15),
                                            min: model.rangeFilters![index].context.data.minMax.start,
                                            max: model.rangeFilters![index].context.data.minMax.end,
                                            divisions: model.rangeFilters![index].context.data.division,
                                            labels: const RangeLabels('En Az', 'En Çok'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   crossAxisAlignment: CrossAxisAlignment.end,
                      //   children: [
                      //     Expanded(
                      //       child: SizedBox(
                      //         height: kToolbarHeight,
                      //         child: ElevatedButton(
                      //           onPressed: () => Navigator.pop(context, model),
                      //           style: ButtonStyle(shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(radius))))),
                      //           child: const Center(child: Text('Onayla', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white))),
                      //         ),
                      //       ),
                      //     ),
                      //     Expanded(
                      //       child: SizedBox(
                      //         height: kToolbarHeight,
                      //         child: ElevatedButton(
                      //           onPressed: () => Navigator.pop(context, null),
                      //           style: ButtonStyle(shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomRight: Radius.circular(radius))))),
                      //           child: const Center(child: Text('İptal', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white))),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: kToolbarHeight,
                              child: ElevatedButton(
                                onPressed: () => Navigator.pop(context, model),
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(radius)))),
                                  backgroundColor: MaterialStateProperty.resolveWith((states) {
                                    if (states.contains(MaterialState.pressed)) {
                                      return Theme.of(context).scaffoldBackgroundColor;
                                    } else {
                                      return Colors.greenAccent.shade700;
                                    }
                                  }),
                                ),
                                child: Center(child: Text('Onayla', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.bodyMedium!.color!))),
                              ),
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                              height: kToolbarHeight,
                              child: ElevatedButton(
                                onPressed: () => Navigator.pop(context, null),
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomRight: Radius.circular(radius * 0.5)))),
                                  backgroundColor: MaterialStateProperty.resolveWith((states) {
                                    if (states.contains(MaterialState.pressed)) {
                                      return Theme.of(context).textTheme.bodyMedium!.color!;
                                    } else {
                                      return Theme.of(context).scaffoldBackgroundColor;
                                    }
                                  }),
                                  foregroundColor: MaterialStateProperty.resolveWith((states) {
                                    if (states.contains(MaterialState.pressed)) {
                                      return Theme.of(context).scaffoldBackgroundColor;
                                    } else {
                                      return Theme.of(context).textTheme.bodyMedium!.color!;
                                    }
                                  }),
                                ),
                                child: Center(child: Text('İptal', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      });
    },
  ).then((value) {
    if (value != null && model != null) {
      model.toDebugPrint();
    }
  });
}
