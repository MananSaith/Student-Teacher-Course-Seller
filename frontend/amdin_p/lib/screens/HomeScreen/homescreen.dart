import 'package:amdin_p/constant/colorclass.dart';
import 'package:amdin_p/widgets/textwidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/techerDataFromNode/teacher_crud.dart';
import 'contained_tab_bar_view.dart';
import 'search_result.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final TeacherCrud teacherCrudController = Get.put(TeacherCrud());
  final TextEditingController searchController = TextEditingController();
  bool showSearchField = false;

  void toggleSearch() {
    setState(() {
      showSearchField = !showSearchField;
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    //final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColors.scaffoldBack,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
                backgroundColor: MyColors.primaryPallet,
                expandedHeight: height * 0.35,
                collapsedHeight:
                    height * 0.15, // Increased height when collapsed
                floating: false,
                pinned: true,
                stretch: true,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  titlePadding: const EdgeInsets.only(
                    left: 30,
                    bottom: 30,
                  ),
                  title: showSearchField
                      ? TextField(
                          controller: searchController,
                          autofocus: true,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            hintText: 'Search...',
                            border: InputBorder.none,
                            hintStyle: TextStyle(color: Colors.white),
                          ),
                          onChanged: (value) {
                            teacherCrudController.searchTeachers.value = value;
                          },
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextWidget(
                              text: "Search",
                              fSize: 30,
                              textColor: MyColors.bgPallet,
                            ),
                            IconButton(
                              icon: const Icon(Icons.search),
                              onPressed: toggleSearch,
                            ),
                          ],
                        ),
                  centerTitle: true,
                ),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(0.0),
                  child: Container(
                    height: height * 0.03,
                    decoration: BoxDecoration(
                        color: MyColors.scaffoldBack,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                  ),
                )),
            SliverToBoxAdapter(
              child:Obx(() {
                // Check if search is active
                if (teacherCrudController.searchTeachers.value.isNotEmpty) {
                  return searchResults(searchQuery: teacherCrudController.searchTeachers.value);
                }
                return containedTabBarView(context: context);
              }),
            )
          ],
        ),
      ),
    );
  }
}


