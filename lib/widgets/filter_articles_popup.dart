import 'package:flutter/material.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';

class FilterArticlesPopup extends StatefulWidget {
  const FilterArticlesPopup({super.key});

  @override
  State<FilterArticlesPopup> createState() => _FilterArticlesPopupState();

}

class _FilterArticlesPopupState extends State<FilterArticlesPopup> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * .25,
      width: double.infinity,
      child: Card(
        elevation: 10,
        color: Theme.of(context).cardColor,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  "Programs",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              MultiSelectContainer(
                itemsDecoration: MultiSelectDecorations(
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    border: Border.all(color: Colors.black12),
                    borderRadius: BorderRadius.circular(20)
                  ),
                  selectedDecoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    border: Border.all(color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(20)
                  )
                ),
                  items: [
                    MultiSelectCard(value: 'BSCS-ST', label: 'BSCS-ST'),
                    MultiSelectCard(value: 'BS-IT', label: 'BS-IT'),
                    MultiSelectCard(value: 'BSCS-NIS', label: 'BSCS-NIS'),
                    MultiSelectCard(value: 'BSCS-CSE', label: 'BSCS-CSE'),
                    MultiSelectCard(value: 'BSMS-CS', label: 'BSMS-CS'),
                  ],
                onChange: (allSelectedItems, selectedItem) {}),
            ],
          ),
        ),
      ),
    );
  }
}