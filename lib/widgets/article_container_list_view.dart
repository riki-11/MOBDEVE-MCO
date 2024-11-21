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
                margin: const EdgeInsets.only(bottom: 8.0),
                padding: const EdgeInsets.all(10),
                height: 170.0,
                // color: Colors.green,
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: Theme.of(context).dividerColor,
                            width: 1.0))),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(author.getName()),
                            Expanded(
                              child: Text(
                                widget.article.title,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                            Card(
                              color: Colors.black, // ← And also this.
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 5, right: 5),
                                child: Text(college.acronym,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Center(
                                    child: Container(
                                      color:
                                          Colors.green, // Inner green container
                                      height:
                                          65, // Adjust height to fit inside the purple container
                                    ),
                                  ),
                                ),
                                Text(DateFormat.yMMMd().format(
                                    widget.article.datePosted.toDate())),
                              ],
                            ),
                          )),
                    ],
                  ),
                ));
          }),
      onTap: () {
        Get.to(ViewArticle(article: widget.article),
            transition: Transition.rightToLeft,
            arguments: {'article': widget.article});
      },
    );
  }
}
