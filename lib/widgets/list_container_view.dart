import 'package:flutter/material.dart';
import 'package:mobdeve_mco/models/list.dart';
import 'package:get/get.dart';
import 'package:mobdeve_mco/models/user.dart';
import 'package:mobdeve_mco/pages/view-articles-list.dart';

import '../controllers/user_controller.dart';

class ListContainerView extends StatelessWidget {
  final ListModel list;

  const ListContainerView({super.key, required this.list});

  Future<User> getListCreator(String creatorId) async {
    return await UserController.instance.getUserData(creatorId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: getListCreator(list.authorId.toString()),
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 170.0,
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Container(
            height: 170.0,
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          );
        } else if (!snapshot.hasData) {
          return Container(
            height: 170.0,
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                'Creator not found',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          );
        }

        // Data successfully fetched
        final listCreator = snapshot.data!;
        return InkWell(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        list.title,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 4.0),
                      RichText(
                        text: TextSpan(
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Colors.black54,
                          ),
                          children: [
                            const WidgetSpan(
                              alignment: PlaceholderAlignment.middle,
                              child: Icon(
                                Icons.account_circle_outlined,
                                size: 16.0,
                                color: Colors.black54,
                              ),
                            ),
                            const WidgetSpan(
                              child: SizedBox(width: 4.0),
                            ),
                            TextSpan(
                              text: '${listCreator.firstName} ${listCreator.lastName}',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        list.description,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 16.0),
                      if (list.articlesBookmarked.isEmpty)
                        Text(
                          'No articles',
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                      if (list.articlesBookmarked.length == 1)
                        Text(
                          '1 article',
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                      if (list.articlesBookmarked.length > 1)
                        Text(
                          '${list.articlesBookmarked.length} articles',
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                      // TODO: Add no. of articles within list.
                    ],
                  ),
                ),
              ],
            ),
          ),
          onTap: () {
            Get.to(() => ViewArticlesList(list: list, listCreator: listCreator));
          },
        );
      },
    );
  }
}
