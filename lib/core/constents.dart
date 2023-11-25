class AppConstents {
  static const String APP_NAME = "BettaStore";
  static const int APP_VERSION = 1;
  static const String BASE_URL = "http://192.168.100.30:8000";
  static const String PRODUCT_URI = "/api/v1/products/popular";
  static const String Betta_Fish_URI = "/api/v1/products/betta";
  static const String Plants_URI = "/api/v1/products/plant";
  static const String OtherFishes_URI = "/api/v1/products/otherfish";
  static const String Feeds_URI = "/api/v1/products/feeds";
  static const String Items_URI = "/api/v1/products/items";
  static const String UPLOAD_URL = "/uploads/";
  static const String registrationUri = "/api/v1/auth/register";
  static const String loginUri = "/api/v1/auth/login";
  static const String userList = "/api/v1/auth/users";

  static const String placeOrderUri = "/api/v1/customer/order/place";
  static const String getOrderListUri = "/api/v1/customer/order/list";
  static const String getOrderListForSellerUri =
      "/api/v1/customer/order/to-seller";
  static const String getAllReviews = "/api/v1/customer/order/reviews";
  static const String postAddReview = "/api/v1/customer/order/add-review";
  static const String tokenUri = "/api/v1/customer/cm-firebase-token";

  static const String updateUser = "/api/v1/auth/update";
  static const String userUri = "/api/v1/customer/info";
  static const String addressUri = "/api/v1/customer/address/add";
  static const String addressListUri = "/api/v1/customer/address/list";
  static const String addProductUri = "/api/v1/products/add-product";
  static const String userAddress = "useraddress";
  static const String uploadFile = "/api/v1/products/add-file";
  static const String uploadVideo = "/api/v1/products/add-video";
  static const String TOKEN = "DBtoken";
  static const String Cart_list = "cart-list";
  static const String Cart_history_list = "cart-history-list";
}
