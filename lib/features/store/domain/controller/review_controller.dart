
import 'package:betta_store/core/utils/widgets/custom.dart';
import 'package:betta_store/features/store/domain/data/repository/review_repo.dart';
import 'package:betta_store/features/store/domain/models/respones_model.dart';
import 'package:betta_store/features/store/domain/models/review_model.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';


class ReviewController extends GetxController implements GetxService {
  final ReviewRepo reviewRepo;

  ReviewController({required this.reviewRepo});
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<ReviewModel> _allReviews = [];
  List<ReviewModel> get allReviews => _allReviews;
  Future<ResponesModel> getReview() async {
    Response response = await reviewRepo.getReviews();

    late ResponesModel responesModel;
    if (response.statusCode == 200) {
      _isLoading = true;
      _allReviews = [];
      _allReviews.addAll(Review.fromJson(response.body).reviews!);
      debugPrint(
          "..........................................................................Got reviews.$allReviews");
      responesModel = ResponesModel(true, "SuccessFull");
    } else {
      print("Getting ----${response.statusCode}--token");
      responesModel = ResponesModel(false, response.statusText!);
    }

    update();
    return responesModel;
  }

  Future<void> addReview(ReviewModel reviewModel) async {
    Response response = await reviewRepo.addReview(reviewModel);
    if (response.statusCode == 200) {
      _isLoading = false;
      showCustumeSnackBar("Review added SuccessFully", title: "Review added");
    } else {
      showCustumeSnackBar(response.statusText!, title: "Review failed");
    }
    update();
  }
}
