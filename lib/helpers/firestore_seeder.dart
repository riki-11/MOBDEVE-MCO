import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class FirestoreSeeder {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> seedData() async {
    try {
      // Add colleges
      DocumentReference engCollegeRef = await firestore.collection('colleges').add({
        'name': 'College of Engineering',
        'acronym': 'COE',
      });

      DocumentReference artsCollegeRef = await firestore.collection('colleges').add({
        'name': 'College of Arts',
        'acronym': 'CA',
      });

      // Add programs
      DocumentReference csProgramRef = await firestore.collection('programs').add({
        'name': 'Computer Science',
        'acronym': 'CS',
        'college': engCollegeRef,
      });

      DocumentReference gdProgramRef = await firestore.collection('programs').add({
        'name': 'Graphic Design',
        'acronym': 'GD',
        'college': artsCollegeRef,
      });

      // Add users
      DocumentReference user1Ref = await firestore.collection('users').add({
        'email': 'john.doe@example.com',
        'username': 'john_doe',
        'colleges': engCollegeRef.id,
        'programs': csProgramRef.id,
        'lists': 'Todo List 1',
      });

      DocumentReference user2Ref = await firestore.collection('users').add({
        'email': 'jane.doe@example.com',
        'username': 'jane_doe',
        'colleges': artsCollegeRef.id,
        'programs': gdProgramRef.id,
        'lists': 'Todo List 2',
      });

      // Add articles
      DocumentReference article1Ref = await firestore.collection('articles').add({
        'authorId': user1Ref.id,
        'title': 'The Future of Technology',
        'content': 'Exploring the next wave of innovation in tech.',
        'datePosted': DateTime.now(),
        'college': engCollegeRef.id,
        'program': csProgramRef.id,
      });

      DocumentReference article2Ref = await firestore.collection('articles').add({
        'authorId': user2Ref.id,
        'title': 'The Art of Design',
        'content': 'How graphic design shapes the visual world.',
        'datePosted': DateTime.now(),
        'college': artsCollegeRef.id,
        'program': gdProgramRef.id,
      });

      // Add reactions
      await firestore.collection('reactions').add({
        'userId': user1Ref.id,
        'articleId': article2Ref.id,
      });

      await firestore.collection('reactions').add({
        'userId': user2Ref.id,
        'articleId': article1Ref.id,
      });

      print('Dummy data seeded successfully.');
    } catch (e) {
      print('Error seeding data: $e');
    }
  }
}
