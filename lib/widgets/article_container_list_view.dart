import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobdeve_mco/pages/view-article.dart';
import 'package:intl/intl.dart';

import '../controllers/college_controller.dart';
import '../controllers/program_controller.dart';
import '../controllers/user_controller.dart';
import '../models/article.dart';
import '../models/college.dart';
import '../models/program.dart';
import '../models/user.dart';

class ArticleContainerListView extends StatefulWidget {
  final Article article;
  const ArticleContainerListView({super.key, required this.article});

  @override
  State<ArticleContainerListView> createState() =>
      _ArticleContainerListViewState();
}

class _ArticleContainerListViewState extends State<ArticleContainerListView> {
  late College college;
  late Program program;
  late User author;
  Future<Map<String, dynamic>> fetchCollegeAndAuthor() async {
    // college = await CollegeController.instance.getCollege(widget.article.collegeId);
    college = CollegeController.instance.collegeList.value.firstWhere(
        (college) => college.id == widget.article.collegeId,
        orElse: () => throw Exception("College not Found"));
    program =
        await ProgramController.instance.getProgram(widget.article.programId);
    author = await UserController.instance.getUserData(widget.article.authorId);
    return {'college': college, 'program': program, 'author': author};
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: FutureBuilder(
          future: fetchCollegeAndAuthor(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Show a loading indicator while fetching data
              return const SizedBox(
                height: 170.0,
                child: Center(child: CircularProgressIndicator()),
              );
            } else if (snapshot.hasError) {
              // Handle error state
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData) {
              // Handle the case where there's no data
              return const Center(child: Text('No data available'));
            }

            // Data has been fetched successfully
            final college = snapshot.data!['college'] as College;
            final author = snapshot.data!['author'] as User;
            return Container(
              width: double.infinity, // Ensures the container takes up the full width
              margin: const EdgeInsets.only(bottom: 8.0),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Theme.of(context).dividerColor,
                    width: 1.0,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(author.getName()),
                          const SizedBox(height: 4.0),
                          Text(
                            widget.article.title,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 16.0),
                          Row(
                            children: [
                              Card(
                                color: Colors.black,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text(
                                    college.acronym,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Card(
                                color: Colors.black,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text(
                                    program.acronym,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  DateFormat.yMMMd()
                                  .format(widget.article.datePosted.toDate()),
                                  textAlign: TextAlign.right,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
      onTap: () {
        Get.to(ViewArticle(article: widget.article),
            transition: Transition.rightToLeft,
            arguments: {'article': widget.article});
      },
    );
  }
}
