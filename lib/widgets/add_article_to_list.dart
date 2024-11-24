import 'package:flutter/material.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:get/get.dart';
import 'package:mobdeve_mco/controllers/list_controller.dart';
import 'package:mobdeve_mco/models/list.dart';

class AddArticleToList extends StatefulWidget {
  final String articleId;
  final Function(bool isBookmarked) onBookmarkStatusChanged;

  const AddArticleToList({
    super.key,
    required this.articleId,
    required this.onBookmarkStatusChanged,
  });

  @override
  State<AddArticleToList> createState() => _AddArticleToListState();
}

class _AddArticleToListState extends State<AddArticleToList> {
  late String articleId;

  final MultiSelectController<ListModel> _controller = MultiSelectController();

  // Key: List object, Value: List Name
  late Map<ListModel, String> listOptions;

  @override
  void initState() {
    super.initState();
    articleId = widget.articleId;
    // Set the options
    listOptions = {for(ListModel list in ListController.instance.currentUserLists.value)
      list: list.title};
  }

  Future<void> _saveSelections() async {
    // Get selected items list
    List<ListModel> currentlySelectedLists = _controller.getSelectedItems();
    bool itemsUpdated = false;
    ListController listController = ListController.instance;
    // Update values in cloud firestore
    for (var list in listOptions.keys){
      if(!list.articlesBookmarked.contains(articleId) && currentlySelectedLists.contains(list)){
        // Add article to list if not preselected and is selected
        listController.addArticleFromList(list, articleId);
        print("ADD ARTICLE $articleId TO ${list.title}");
        itemsUpdated = true;

      } else if(list.articlesBookmarked.contains(articleId) && !currentlySelectedLists.contains(list)){
        // Delete article from list if preselected and not selected
        print("DELETE ARTICLE $articleId FROM ${list.title}");
        listController.deleteArticleFromList(list, articleId);
        itemsUpdated = true;
      }
    }
    if (itemsUpdated){
      // Check if the article is still bookmarked in any list
      bool isNowBookmarked = listOptions.keys.any(
            (list) => list.articlesBookmarked.contains(articleId),
      );

      // Notify parent widget of the updated bookmark state
      widget.onBookmarkStatusChanged(isNowBookmarked);

      Get.snackbar('Success', 'Lists updated.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Text(
              "Add Article to List",
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
          ),
          MultiSelectContainer(
            controller: _controller,
            maxSelectableCount: listOptions.length,
            itemsDecoration: MultiSelectDecorations(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                border: Border.all(color: Colors.black12),
                borderRadius: BorderRadius.circular(10.0),
              ),
              selectedDecoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                border: Border.all(color: Theme.of(context).primaryColor),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            items: listOptions.entries.map((entry) {
              return MultiSelectCard(
                value: entry.key,
                label: entry.value,
                textStyles: MultiSelectItemTextStyles(
                  textStyle: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge!.color,
                  ),
                  selectedTextStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold, // Optional, for emphasis
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.9,
                    child: Text(
                      entry.value,
                    ),
                  ),
                ),
                selected: entry.key.articlesBookmarked.contains(articleId),
              );
            }).toList(),
            onChange: (allSelectedItems, selectedItem) {
              print("Selected Lists: $allSelectedItems");
            },
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Theme.of(context).colorScheme.primary),
            ),
            onPressed: ()  async {
              await _saveSelections();
            },
            child: Text(
              "Confirm",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary),
            ),
          ),
        ],
      ),
    );
  }
}
