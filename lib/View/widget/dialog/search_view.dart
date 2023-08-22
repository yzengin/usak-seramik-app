// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '/Controller/extension.dart';
import '../../../Model/data.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key, required this.model});
  final FilterData model;
  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Hero(
        tag: 'search',
        child: SizedBox(
          height: kToolbarHeight,
          width: context.width,
          child: Material(
            color: context.theme.colorScheme.primaryContainer,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kToolbarHeight)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: (true) ? searchSurface(context) : const SizedBox(),
            ),
          ),
        ),
      ),
    );
  }

  Widget searchSurface(BuildContext context) {
    return Row(children: [Expanded(child: Text(context.translete('search'))), Icon(FontAwesomeIcons.magnifyingGlass, color: context.theme.colorScheme.onPrimaryContainer)]);
  }

  void onTap() => Navigator.push(context, appRouteBuilder(context, _SearchPage(widget.model), routeSettings: RouteSettings(name: 'search_page')));

  Scaffold body(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Hero(
          tag: 'search',
          child: SizedBox(
            height: kToolbarHeight,
            width: context.width,
            child: Material(
              color: context.theme.colorScheme.primaryContainer,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kToolbarHeight)),
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: (false)
                      ? searchSurface(context)
                      : TextField(
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            hintText: 'Ara',
                            hintStyle: context.textStyle,
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        )),
            ),
          ),
        ),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}

class _SearchPage extends StatefulWidget {
  const _SearchPage(this.model);
  final FilterData model;

  @override
  State<_SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<_SearchPage> with SingleTickerProviderStateMixin {
  double radius = 20;
  late ValueNotifier<TabController> tabBarController;

  @override
  void initState() {
    tabBarController = ValueNotifier<TabController>(TabController(length: 2, vsync: this, initialIndex: 1));
    super.initState();
  }

  @override
  void dispose() {
    tabBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ValueListenableBuilder(
                  valueListenable: tabBarController,
                  builder: (context, _, __) {
                    return TabBar(
                      controller: tabBarController.value,
                      onTap: (index) {
                        tabBarController.value.index = index;
                        setState(() {});
                      },
                      padding: EdgeInsets.zero,
                      indicatorPadding: EdgeInsets.zero,
                      tabs: ['quickly', 'detailed'].map((e) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(child: Text(context.translete(e), style: context.theme.textTheme.bodyMedium)),
                        );
                      }).toList(),
                      indicatorSize: TabBarIndicatorSize.tab,
                      overlayColor: MaterialStateProperty.all(Colors.transparent),
                      indicator: ShapeDecoration(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kToolbarHeight)),
                        color: context.theme.colorScheme.onSecondary,
                      ),
                    );
                  }),
            ),
          ),
          title: Hero(
            tag: 'search',
            child: SizedBox(
              height: kToolbarHeight,
              width: context.width,
              child: Material(
                color: context.colors.primaryContainer,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kToolbarHeight)),
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: (false)
                        ? const SizedBox()
                        : TextField(
                            autofocus: true,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                          )),
              ),
            ),
          ),
        ),
        body: GestureDetector(onTap: () => FocusScope.of(context).unfocus(), child: body(context)));
  }

  Widget body(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.paddingBottom * 2),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: ValueListenableBuilder(
                valueListenable: tabBarController,
                builder: (context, _, __) {
                  if (tabBarController.value.index == 0) {
                    return SizedBox();
                  }
                  if (tabBarController.value.index == 1) {
                    return _advancedSearch();
                  } else {
                    return SizedBox();
                  }
                },
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              widget.model.toDebugPrint();
            },
            child: Text(context.translete('search')),
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(context.colors.onSecondary), foregroundColor: MaterialStateProperty.all(Colors.black), shape: MaterialStateProperty.all(StadiumBorder())),
          ).wrapPaddingHorizontal(20)
        ],
      ),
    );
  }

  Column _advancedSearch() {
    return Column(
      children: [
        (widget.model.searchFilters == null)
            ? const SizedBox()
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: widget.model.searchFilters!.length,
                itemBuilder: (context, index) {
                  final data = widget.model.searchFilters![index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${data.filter.context.label}").wrapPaddingLeft(20),
                            Material(
                              color: context.colors.shadow,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kToolbarHeight)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: TextField(
                                  controller: data.controller,
                                  focusNode: data.node,
                                  textInputAction: index == widget.model.searchFilters!.length - 1 ? TextInputAction.done : TextInputAction.next,
                                  decoration: InputDecoration(
                                    hintText: context.translete('search').toLowerCase(),
                                    hintStyle: context.textStyle,
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    floatingLabelAlignment: FloatingLabelAlignment.center,
                                  ),
                                ),
                              ),
                            ).wrapPaddingTop(10),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
        Divider(),
        (widget.model.chooseFilters == null)
            ? const SizedBox()
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: widget.model.chooseFilters!.length,
                itemBuilder: (context, index) {
                  final data = widget.model.chooseFilters![index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${data.context.label}").wrapPaddingLeft(20),
                        SizedBox(
                          height: kToolbarHeight,
                          child: ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.model.chooseFilters![index].filters!.length,
                            itemBuilder: (BuildContext context, int indexSub) {
                              final subData = widget.model.chooseFilters![index].filters![indexSub];
                              if (data.multiple) {
                                return FilterChip(
                                  label: Text(subData.context.label),
                                  selected: data.context.data.contains(subData.context.data),
                                  backgroundColor: subData.context.isColor ? subData.context.data.withOpacity(.5) : context.theme.chipTheme.backgroundColor!,
                                  selectedColor: subData.context.isColor ? subData.context.data : context.theme.chipTheme.backgroundColor,
                                  onSelected: (value) {
                                    if (data.context.data.contains(subData.context.data)) {
                                      data.context.data.remove(subData.context.data);
                                    } else {
                                      data.context.data.add(subData.context.data);
                                    }
                                    // data.context.data = subData.context.data;
                                    setState(() {});
                                    // widget.model.chooseFilters[indexSub].context.data = subData;
                                    // setState(() {});
                                  },
                                ).wrapPaddingRight(10);
                              } else {
                                return FilterChip(
                                  label: Text(subData.context.label),
                                  selected: data.context.data == subData.context.data,
                                  onSelected: (value) {
                                    data.context.data = subData.context.data;
                                    setState(() {});
                                    // widget.model.chooseFilters[indexSub].context.data = subData;
                                    // setState(() {});
                                  },
                                ).wrapPaddingRight(10);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
        Divider(),
        (widget.model.rangeFilters == null)
            ? const SizedBox()
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: widget.model.rangeFilters!.length,
                itemBuilder: (context, index) {
                  final data = widget.model.rangeFilters![index];
                  TextEditingController minController = TextEditingController();
                  TextEditingController maxController = TextEditingController();
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${data.context.label}").wrapPaddingLeft(20),
                        if (!data.context.data.preferSlider)
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Material(
                                    color: context.colors.shadow,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kToolbarHeight)),
                                    child: TextField(
                                      controller: minController,
                                      onChanged: (value) {
                                        data.context.data.value = new RangeValues(double.parse(value), data.context.data.value.end);
                                      },
                                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                                      decoration: InputDecoration(
                                        hintText: context.translete('min'),
                                        hintStyle: context.textStyle,
                                        border: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        floatingLabelAlignment: FloatingLabelAlignment.center,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Material(
                                    color: context.colors.shadow,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kToolbarHeight)),
                                    child: TextField(
                                      controller: maxController,
                                      onChanged: (value) {
                                        data.context.data.value = new RangeValues(data.context.data.value.start, double.parse(value));
                                      },
                                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                                      decoration: InputDecoration(
                                        hintText: context.translete('max'),
                                        hintStyle: context.textStyle,
                                        border: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        floatingLabelAlignment: FloatingLabelAlignment.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        if (data.context.data.preferSlider)
                          Row(
                            children: [
                              Text("${data.context.data.minMax.start.toInt()}"),
                              Expanded(
                                child: RangeSlider(
                                  values: data.context.data.value,
                                  onChangeEnd: (value) {
                                    data.context.data.value = new RangeValues(value.start, value.end);
                                    setState(() {});
                                  },
                                  onChangeStart: (value) {
                                    data.context.data.value = new RangeValues(value.start, value.end);
                                    setState(() {});
                                  },
                                  onChanged: (RangeValues value) {
                                    data.context.data.value = new RangeValues(value.start, value.end);
                                    setState(() {});
                                  },
                                  min: data.context.data.minMax.start,
                                  max: data.context.data.minMax.end,
                                  divisions: data.context.data.division,
                                  labels: RangeLabels("${data.context.data.value.start.toInt()}", "${data.context.data.value.end.toInt()}"),
                                ),
                              ),
                              Text("${data.context.data.minMax.end.toInt()}"),
                            ],
                          ),
                      ],
                    ),
                  );
                },
              )
      ],
    );
  }
}

Route appRouteBuilder(
  BuildContext context,
  Widget routePage, {
  RouteSettings? routeSettings,
  Color? barrierColor,
  Duration? transitionDuration,
  Duration? reverseTransitionDuration,
}) {
  return PageRouteBuilder(
    transitionDuration: transitionDuration ?? const Duration(milliseconds: 300),
    reverseTransitionDuration: reverseTransitionDuration ?? const Duration(milliseconds: 300),
    barrierColor: barrierColor ?? context.theme.scaffoldBackgroundColor,
    barrierDismissible: false,
    settings: routeSettings,
    pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secAnimation) {
      return routePage;
    },
    transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secAnimation, Widget child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  );
}
