import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foods_app/data/datasources/food_remote_datasource.dart';
import 'package:foods_app/data/models/product_model.dart';

class FoodREmoteDatasourceImpl implements FoodRemoteDataSource {
  final FirebaseFirestore firestore;

  FoodREmoteDatasourceImpl({ required this.firestore});


  @override
  Future<List<FoodModel>> getFoods() async{
    final snapshot = await firestore.collection("products").get();
    return snapshot.docs.map((doc) => FoodModel.fromJson(doc.data()),).toList();
  }

}