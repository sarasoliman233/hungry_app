class ApiError{

  final String message;
  final int? statusCode;

  ApiError({ required this.message, this.statusCode});

  String isString(){

    return 'error is $message (StatusCode is :$statusCode)';
  }

}