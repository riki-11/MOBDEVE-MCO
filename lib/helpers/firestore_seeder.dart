import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class FirestoreSeeder {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> seedData() async {
    try {
      // Add colleges
      DocumentReference engCollegeRef = await firestore.collection('colleges').add({
        'name': 'Gokungwei College of Engineering',
        'acronym': 'GCOE',
      });

      DocumentReference artsCollegeRef = await firestore.collection('colleges').add({
        'name': 'College of Liberal Arts',
        'acronym': 'CLA',
      });

      // Add programs
      DocumentReference csProgramRef = await firestore.collection('programs').add({
        'name': 'Bachelor of Computer Science, Major in Software Technology',
        'acronym': 'BSCS-ST',
        'college': engCollegeRef.id,
      });

      DocumentReference gdProgramRef = await firestore.collection('programs').add({
        'name': 'Bachelor of Arts in Political Science',
        'acronym': 'AB-PLS',
        'college': artsCollegeRef.id,
      });

      // Add users
      DocumentReference user1Ref = await firestore.collection('users').add({
        'email': 'john.doe@example.com',
        'firstName': 'John',
        'lastName': 'Doe',
        'colleges': [engCollegeRef.id],
        'programs': [csProgramRef.id],
      });

      DocumentReference user2Ref = await firestore.collection('users').add({
        'email': 'jane.doe@example.com',
        'firstName': 'Jane',
        'lastName': 'Doe',
        'colleges': [artsCollegeRef.id],
        'programs': [gdProgramRef.id],
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

      print('Dummy data seeded successfully.');
    } catch (e) {
      print('Error seeding data: $e');
    }
  }
}
