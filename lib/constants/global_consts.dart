import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Constants for Article Headers
const String HEADER_THOUGHTS =  "Thoughts";
const String HEADER_WYL =       "What you'll learn";
const String HEADER_PROJECTS =  "Projects";
const String HEADER_TIPS =      "Tips for doing well";
const String HEADER_LNR =       "Links and resources";

const String DOC_ID = "documentId";
const String AUTHOR_ID = "authorId";
const String TITLE = "title";
const String CONTENT = "content";
const String DATE_POSTED = "datePosted";
const String COLLEGE_ID = "college";
const String PROGRAM_ID = "program";
FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;