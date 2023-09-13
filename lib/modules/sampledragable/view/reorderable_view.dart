import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../controller/dragable_controller.dart';

class DragableViews extends GetView<DragableController> {
  const DragableViews({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(DragableController());
    return Scaffold(
      body: Container(
        height: 100.h,
        width: 100.w,
        padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 3.h),
        child: Obx(
          () => ReorderableListView.builder(
            itemCount: controller.listDragable.length,
            onReorderStart: (int) {
              print("dragging $int");
            },
            onReorderEnd: (int) {
              print("stop dragging at ${int - 1}");
            },
            onReorder: (oldIndex, newIndex) {
              if (newIndex > oldIndex) newIndex--;
              final newitem = controller.listDragable.removeAt(oldIndex);
              controller.listDragable.insert(newIndex, newitem);
            },
            itemBuilder: (BuildContext context, index) {
              return Padding(
                key: ValueKey(index),
                padding: EdgeInsets.all(2.w),
                child: Stack(
                  children: [
                    Container(
                      height: 15.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: 1,
                              blurRadius: 3,
                            ),
                          ],
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
                    Positioned(
                        child: Padding(
                      padding: EdgeInsets.only(top: 1.h),
                      child: InkWell(
                          onTap: () {
                            controller.listDragable.removeAt(index);
                          },
                          child: Icon(Icons.more_vert)),
                    ))
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
