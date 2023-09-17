import 'dart:math';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:usak_seramik_app/Rest/Entity/User/message_entity.dart';
import 'package:usak_seramik_app/Rest/Handler/message_handler.dart';
import '../../../Controller/formatter.dart';
import '../dialog/dialog.dart';
import '/Controller/extension.dart';

// ignore: must_be_immutable
class ContactFormBottomSheet extends StatefulWidget {
  ContactFormBottomSheet({
    super.key,
    this.maxSize = 0.5,
    this.initialSize = 0.1,
    this.child,
    this.title,
    this.icon,
  });
  double maxSize;
  double initialSize;
  Widget? child;
  String? title;
  IconData? icon;

  @override
  State<ContactFormBottomSheet> createState() => _ContactFormBottomSheetState();
}

class _ContactFormBottomSheetState extends State<ContactFormBottomSheet> with SingleTickerProviderStateMixin {
  double? minSize;
  DraggableScrollableController draggableScrollableController = DraggableScrollableController();
  late AnimationController animationController;
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController phoneController = new TextEditingController();
  final TextEditingController subjectController = new TextEditingController();
  final TextEditingController messageController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    animationController = AnimationController(vsync: this, lowerBound: 0, upperBound: widget.initialSize, duration: 300.millisecond(), reverseDuration: 300.millisecond());
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => animationController.forward());
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    minSize = minSize != null ? minSize : widget.initialSize;
    ValueNotifier<double> currentSheetPosition = ValueNotifier<double>(0);

    return SizedBox(
      width: context.width,
      child: AnimatedBuilder(
          animation: animationController,
          builder: (context, _) {
            return DraggableScrollableSheet(
              maxChildSize: widget.maxSize,
              minChildSize: animationController.value,
              initialChildSize: animationController.value,
              controller: draggableScrollableController,
              snap: true,
              expand: false,
              snapAnimationDuration: 250.millisecond(),
              snapSizes: [widget.initialSize, widget.maxSize],
              builder: (context, scrollController) {
                return NotificationListener<DraggableScrollableNotification>(
                  onNotification: (notification) {
                    currentSheetPosition.value = notification.extent.reduceRange(widget.maxSize, minSize!);
                    return true;
                  },
                  child: SingleChildScrollView(
                    controller: scrollController,
                    physics: ClampingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            if (currentSheetPosition.value == 0) {
                              draggableScrollableController.animateTo(1, duration: 300.millisecond(), curve: Curves.ease);
                            } else {
                              draggableScrollableController.animateTo(0, duration: 300.millisecond(), curve: Curves.ease);
                            }
                          },
                          child: Container(
                              height: context.height * widget.initialSize,
                              width: context.width,
                              color: Colors.transparent,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    widget.icon != null ? Icon(widget.icon) : Opacity(opacity: 0, child: Icon(FontAwesomeIcons.chevronUp)),
                                    Text(widget.title ?? ""),
                                    ValueListenableBuilder(
                                        valueListenable: currentSheetPosition,
                                        builder: (context, _, __) {
                                          return Transform.rotate(angle: pi * -currentSheetPosition.value, child: Icon(FontAwesomeIcons.chevronUp));
                                        }),
                                  ],
                                ),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: nameController,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(labelText: context.translete('name')),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return context.translete('emptyMessage');
                                    } else if (value.length < 2) {
                                      return context.translete('nameGreaterThan');
                                    }
                                    return null;
                                  },
                                ).wrapPaddingBottom(20),
                                TextFormField(
                                  controller: emailController,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(labelText: context.translete('email')),
                                  validator: (value) {
                                    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
                                    if (value == null || value.isEmpty) {
                                      return context.translete('emptyMessage');
                                    } else if (!emailRegex.hasMatch(value)) {
                                      return context.translete('emailValidation');
                                    }

                                    return null;
                                  },
                                ).wrapPaddingBottom(20),
                                TextFormField(
                                  controller: phoneController,
                                  textInputAction: TextInputAction.next,
                                  inputFormatters: [AppFormatter.phone],
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(labelText: context.translete('phone')),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return context.translete('emptyMessage');
                                    } else if (value.replaceAll(' ', '').replaceAll('+90', '').toString().length < 10) {
                                      return context.translete('phoneGreaterThan');
                                    }
                                    return null;
                                  },
                                ).wrapPaddingBottom(20),
                                TextFormField(
                                  controller: subjectController,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(labelText: context.translete('subject')),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return context.translete('emptyMessage');
                                    }
                                    return null;
                                  },
                                ).wrapPaddingBottom(20),
                                TextFormField(
                                  controller: messageController,
                                  textInputAction: TextInputAction.done,
                                  inputFormatters: [],
                                  minLines: 5,
                                  maxLines: 5,
                                  decoration: InputDecoration(labelText: context.translete('message')),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return context.translete('emptyMessage');
                                    }
                                    return null;
                                  },
                                ).wrapPaddingBottom(20),
                                ElevatedButton(
                                    onPressed: () {
                                      debugPrint('${phoneController.text.replaceAll(' ', '').replaceAll('+90', '').toString()}');
                                      debugPrint('${phoneController.text.replaceAll(' ', '').replaceAll('+90', '').toString().length}');
                                      if (_formKey.currentState!.validate()) {
                                        MessageEntity messageEntity = MessageEntity();
                                        messageEntity.name = nameController.text;
                                        messageEntity.email = emailController.text;
                                        messageEntity.tel = phoneController.text.replaceAll(' ', '').replaceAll('+90', '').toString();
                                        messageEntity.subject = subjectController.text;
                                        messageEntity.message = messageController.text;
                                        AppMessageHandler.operations().sendMessageHandler(messageEntity: messageEntity).then((value) {
                                          if (value == 200) {
                                            appDialog(context, message: context.translete('sendMessageDialog'), dialogType: DialogType.success).then((value) {
                                              currentSheetPosition.value = 0;
                                            });
                                          }
                                        });
                                      }
                                      nameController.clear();
                                      emailController.clear();
                                      phoneController.clear();
                                      subjectController.clear();
                                      messageController.clear();
                                      draggableScrollableController.animateTo(0, duration: 300.millisecond(), curve: Curves.ease);
                                      FocusScope.of(context).unfocus();
                                    },
                                    child: Text(context.translete('send')))
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}
