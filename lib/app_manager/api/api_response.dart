class ApiResponse<T> {
  Status status;
  T? data;
  String? message;

  ApiResponse.initial(this.message,) : status = Status.initial,
        data=null;

  ApiResponse.loading(this.message) : status = Status.loading;

  ApiResponse.completed(this.data) : status = Status.completed;

  ApiResponse.error(this.message) : status = Status.error;

  ApiResponse.empty(this.message) : status = Status.empty;


  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }

  static const statusOK=200;
  static const statusBadRequest = 400;
  static const statusUnAuthorised = 401;
  static const statusNotFound=404;
  static const statusRequestTimeOut=408;
  static const statusInternalServer=500;
  static const statusGatewayTimeOut=504;
  static const statusVersionNotSupported=505;

}

enum Status { initial, loading, completed, error,empty}

