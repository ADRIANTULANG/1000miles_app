import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../controller/dragable_controller.dart';

class DragableView extends GetView<DragableController> {
  const DragableView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(DragableController());
    return Scaffold(
      body: Container(
        height: 100.h,
        width: 100.w,
        padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 3.h),
        child: Obx(
          () => ListView.builder(
            itemCount: controller.listDragable.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: 2.h,
                ),
                child: DragTarget<int>(
                    builder: (
                      BuildContext context,
                      List<dynamic> accepted,
                      List<dynamic> rejected,
                    ) {
                      return LongPressDraggable<int>(
                        data: index,
                        onDragStarted: () {
                          print("on drag start $index");
                        },
                        onDragEnd: (details) {},
                        onDragCompleted: () {},
                        child: Container(
                          height: 15.h,
                          width: 100.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(controller
                                      .listDragable[index].groupProductImage))),
                          padding: EdgeInsets.only(
                            top: 2.h,
                            left: 2.w,
                            right: 3.w,
                            bottom: 2.h,
                          ),
                        ),
                        feedback: Container(
                          height: 15.h,
                          width: 100.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(controller
                                      .listDragable[index].groupProductImage))),
                          padding: EdgeInsets.only(
                            top: 2.h,
                            left: 2.w,
                            right: 3.w,
                            bottom: 2.h,
                          ),
                        ),
                        childWhenDragging: Opacity(
                          opacity: 0.5,
                          child: Container(
                            height: 15.h,
                            width: 100.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(controller
                                        .listDragable[index]
                                        .groupProductImage))),
                            padding: EdgeInsets.only(
                              top: 2.h,
                              left: 2.w,
                              right: 3.w,
                              bottom: 2.h,
                            ),
                          ),
                        ),
                      );
                    },
                    onAccept: (data) {
                      print("done oldindex $data");
                      print("done newindex: $index");

                      // var indexDragValue = controller.listDragable[data];
                      // var indexSelectedValue = controller.listDragable[index];

                      // controller.listDragable[data] = indexSelectedValue;
                      // controller.listDragable[index] = indexDragValue;

                      // controller.colorList[]
                    },
                    onWillAccept: (data) {
                      controller.listDragable.value = [
                        ...controller.listDragable_tmp
                      ];
                      print("oldIndex: $data");
                      print("newIndex: $index");
                      // int newIndex = index;
                      // int oldIndex = int.parse(data.toString());

                      // int indexOfFirstItem = controller.listDragable
                      //     .indexOf(controller.listDragable[oldIndex]);
                      // int indexOfSecondItem = controller.listDragable
                      //     .indexOf(controller.listDragable[newIndex]);

                      // if (indexOfFirstItem > indexOfSecondItem) {
                      //   for (int i = controller.listDragable
                      //           .indexOf(controller.listDragable[oldIndex]);
                      //       i >
                      //           controller.listDragable
                      //               .indexOf(controller.listDragable[newIndex]);
                      //       i--) {
                      //     var tmp = controller.listDragable[i - 1];
                      //     controller.listDragable[i - 1] =
                      //         controller.listDragable[i];
                      //     controller.listDragable[i] = tmp;
                      //   }
                      // } else {
                      //   for (int i = controller.listDragable
                      //           .indexOf(controller.listDragable[oldIndex]);
                      //       i <
                      //           controller.listDragable
                      //               .indexOf(controller.listDragable[newIndex]);
                      //       i++) {
                      //     var tmp = controller.listDragable[i + 1];
                      //     controller.listDragable[i + 1] =
                      //         controller.listDragable[i];
                      //     controller.listDragable[i] = tmp;
                      //   }
                      // }

                      return data == data;
                    },
                    onLeave: (data) {
                      // print("onLeave data $data");
                      // print("onLeave$index");
                    },
                    onAcceptWithDetails: (details) {}),
              );
            },
          ),
        ),
      ),
    );
  }
}
