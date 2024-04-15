import 'package:betta_store/core/constents.dart';
import 'package:betta_store/features/Pages/domain/data/api/api_clint.dart';
import 'package:betta_store/features/Pages/domain/models/review_model.dart';
import 'package:get/get.dart';

class ReviewRepo {
  final ApiClint apiClint;

  ReviewRepo({
    required this.apiClint,
  });
  Future<Response> getReviews() async {
    return await apiClint.getData(
      AppConstents.getAllReviews,
    );
  }

  Future<Response> addReview(ReviewModel reviewData) async {
    return await apiClint.postData(
        AppConstents.postAddReview, reviewData.toJson());
  }
}
