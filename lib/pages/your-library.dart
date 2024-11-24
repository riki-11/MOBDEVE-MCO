import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobdeve_mco/controllers/list_controller.dart';
import 'package:mobdeve_mco/models/list.dart';
import 'package:mobdeve_mco/widgets/create_list_popup.dart';
import 'package:mobdeve_mco/widgets/library_tab_bar.dart';
import 'package:mobdeve_mco/widgets/list_container_view.dart';
import 'package:mobdeve_mco/widgets/standard_app_bar.dart';
import 'package:mobdeve_mco/widgets/standard_bottom_bar.dart';
import 'package:mobdeve_mco/widgets/standard_scrollbar.dart';

class YourLibrary extends StatefulWidget {
  final int pageIndex;
  const YourLibrary({this.pageIndex = 1, super.key});

  @override
  State<YourLibrary> createState() => _YourLibraryState();
}

class _YourLibraryState extends State<YourLibrary> {
  late int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    pageIndex = widget.pageIndex;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 1,
      child: Scaffold(
        appBar: StandardAppBar(
            title: 'Your Library',
            actions: [
              IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return const CreateListPopup();
                      }
                    );
                  },
                  icon: const Icon(Icons.add),
                  tooltip: 'Add to library'
              )
            ],
        ), 
        body: 
         GetX<ListController>(
          init: Get.put<ListController>(ListController()),
          builder: (ListController listController) {
            List<ListModel> listOfUserList = ListController.instance.currentUserLists.value;

            if (listOfUserList.isNotEmpty) {
              return StandardScrollbar(
                child: ListView.builder(
                    itemCount: listOfUserList.length,
                    itemBuilder: (BuildContext context, int index) {
                      final listModel = listOfUserList[index];
                      return ListContainerView(list: listModel);
                    },
                  )
              );
            } else {
              return Flex(
                direction: Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: Theme.of(context).textTheme.bodyLarge,
                        children: [
                          TextSpan(
                            text: 'Create a list',
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Show the CreateListPopup
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (BuildContext context) {
                                    return const CreateListPopup();
                                  },
                                );
                              },
                          ),
                          const TextSpan(
                            text: ' to save your favorite articles.',
                          )
                        ],
                      ),
                    ),
                  )
                ],
              );
            }
          }
        ),
        bottomNavigationBar: StandardBottomBar(curPageIndex: pageIndex),
      ),
    );}
}
