import 'package:flutter/material.dart';

class CustomMultiSelectContainer extends StatefulWidget {
  final List<String> items;
  final String? selectedItem;
  final Function(String? selectedItem) onChange;
  final String label;

  const CustomMultiSelectContainer({
    super.key,
    required this.items,
    this.selectedItem,
    required this.onChange,
    required this.label,
  });

  @override
  State<CustomMultiSelectContainer> createState() =>
      _CustomMultiSelectContainerState();
}

class _CustomMultiSelectContainerState
    extends State<CustomMultiSelectContainer> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolling = false;

  @override
  void initState() {
    super.initState();

    // Detect if the user starts or stops scrolling
    _scrollController.addListener(() {
      if (_scrollController.position.isScrollingNotifier.value) {
        setState(() {
          _isScrolling = true;
        });
      } else {
        setState(() {
          _isScrolling = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose(); // Dispose the controller when the widget is removed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Text(
              widget.label,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Scrollbar(
            controller: _scrollController, // Attach the scroll controller
            thumbVisibility: _isScrolling, // Only show when scrolling
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: _scrollController, // Use the same controller
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: widget.items.map((item) {
                  return GestureDetector(
                    onTap: () {
                      widget.onChange(item);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(bottom: 10, right: 10),
                      decoration: BoxDecoration(
                        color: widget.selectedItem == item
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: widget.selectedItem == item
                              ? Theme.of(context).primaryColor
                              : Colors.black12,
                        ),
                      ),
                      child: Text(
                        item,
                        style: TextStyle(
                          color: widget.selectedItem == item
                              ? Colors.white
                              : Colors.black,
                          fontWeight: widget.selectedItem == item
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
