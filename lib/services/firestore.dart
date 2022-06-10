import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quizapp/services/auth_service.dart';
import 'package:quizapp/services/models.dart';
import 'package:rxdart/rxdart.dart';

class FirstoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  //Read all docs from the topics collection
  Future<List<Topic>> getTopics() async {
    //while reading data from firestore, we have to make reference to the collection
    var ref = _db.collection('topics');
    //reading the collection once. not streaming/realtime
    var snapshot = await ref.get();
    //getting data as an iterable map
    var data = snapshot.docs.map((e) => e.data());
    // mapping the data into a constructor (which was created in models.g)
    var topics = data.map((d) => Topic.fromJson(d));
    //returning the value as a list
    return topics.toList();
  }

  //Retrieve a single quiz document
  Future<Quiz> getQuiz(String quizId) async {
    var ref = _db.collection('quizzes').doc(quizId);
    var snapshot = await ref.get();
    return Quiz.fromJson(snapshot.data() ?? {});
  }

  //Listen to realtime stream to find current user's report doc in Firestore
  Stream<Report> streamReport() {
    //rx-dart functionality of switching from one stream to another stream.
    return AuthService().userStream.switchMap((user) {
      if (user != null) {
        var ref = _db.collection('reports').doc(user.uid);
        // this ! is for null safety-incase.
        return ref.snapshots().map((doc) => Report.fromJson(doc.data()!));
      } else {
        //returning default report doc.
        return Stream.fromIterable([Report()]);
      }
    });
  }

  /// Update the current user's report document after completing quiz
  //using future because we don't need stream here as this method can't be called unless user logs in.
  Future<void> updateUserReport(Quiz quiz) {
    var user = AuthService().user!;
    //getting data of reports with corresponding user id
    var ref = _db.collection('reports').doc(user.uid);

    //now updating data to firestore, we use map (key,value)
    var data = {
      // calculate the no. of quizz taken (using FieldValue.increment()) and add 1 to existing value on db
      'total': FieldValue.increment(1),
      // under topic key, creating another map as a value for topics. Later
      // adding each quiz topic into an array of quizzes taken. merge value into firestore list.
      'topics': {
        quiz.topic: FieldValue.arrayUnion([quiz.id])
      }
    };
    // writing data into database.. adding second argument to create non-destructing array.
    // this means it won't override any existing data.i.e. merges to previous list.
    return ref.set(data, SetOptions(merge: true));
  }
}
