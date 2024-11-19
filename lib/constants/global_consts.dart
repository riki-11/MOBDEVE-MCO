import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

const String DOC_ID = "documentId";
const String AUTHOR_ID = "authorId";
const String TITLE = "title";
const String CONTENT = "content";
const String DATE_POSTED = "datePosted";
const String COLLEGE = "college";
const String PROGRAM = "program";
FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;