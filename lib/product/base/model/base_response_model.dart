final class BaseResponseModel<T> {
  T? data;
  String? error;

  BaseResponseModel({this.data,this.error});
}