import 'dart:convert';
import 'dart:io';
import 'package:codeathon_usecase_5/app_manager/api/api_constant.dart';
import 'package:codeathon_usecase_5/app_manager/api/api_response.dart';
import 'package:codeathon_usecase_5/app_manager/helper/show_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

// ignore: depend_on_referenced_packages
import 'package:http_parser/http_parser.dart';

enum ApiType {
  get,
  post,
  rawPost,
  multiPartRequest,
  multiPartRequestPUT,
  put,
  rawPut,
  options,
  patch,
  delete,
}

Map<String, String> rawHeader = {'Content-Type': 'application/json'};

class ApiCallType {
  Map? body;
  String? fileParameter;
  String? filePath;
  ApiType apiType;
  Map<String, String> header = {};

  ApiCallType.get() : apiType = ApiType.get;

  ApiCallType.post({required this.body}) : apiType = ApiType.post;

  ApiCallType.rawPost({required this.body})
      : apiType = ApiType.rawPost,
        header = rawHeader;

  ApiCallType.multiPartRequest({
    this.filePath,
    this.fileParameter,
    required this.body,
  }) : apiType = ApiType.multiPartRequest;

  ApiCallType.multiPartRequestPUT({
    this.filePath,
    this.fileParameter,
    required this.body,
  }) : apiType = ApiType.multiPartRequestPUT;

  ApiCallType.put({required this.body}) : apiType = ApiType.put;

  ApiCallType.rawPut({required this.body})
      : apiType = ApiType.rawPut,
        header = rawHeader;

  ApiCallType.options()
      : apiType = ApiType.options,
        header = rawHeader;

  ApiCallType.delete()
      : apiType = ApiType.delete,
        header = rawHeader;

  ApiCallType.patch({required this.body}) : apiType = ApiType.patch;
}

class ApiCall {
  Future<dynamic> call({
    required String url,
    required ApiCallType apiCallType,
    required http.Client client,
    bool token = false,
    String? newBaseUrl,
    String? useThisToken,
    int retryCount = 0,
  }) async {
    String myUrl = (newBaseUrl ?? ApiConstant.baseUrl) + url;
    String accessToken = useThisToken ?? "";
    Map body = apiCallType.body ?? {};
    Map<String, String>? header = token
        ? {
            'Authorization': accessToken.toString(),
          }
        : {};

    header.addAll(apiCallType.header);

    http.Response? response;
    if (kDebugMode) {
      print("Api call at ${DateTime.now()}");
      print("Type: ${apiCallType.apiType.name.toString()}");
      print("Header: $header");
      print("URL: $myUrl");
      print("BODY: $body");
    }

    try {
      switch (apiCallType.apiType) {
        case ApiType.post:
          response =
              await client.post(Uri.parse(myUrl), body: body, headers: header);
          break;

        case ApiType.get:
          response = await client.get(Uri.parse(myUrl), headers: header);
          break;

        case ApiType.rawPost:
          var request = http.Request('POST', Uri.parse(myUrl));
          request.body = json.encode(body);
          request.headers.addAll(header);
          response = await http.Response.fromStream((await request.send()));
          break;

        case ApiType.multiPartRequest:
          var request = http.MultipartRequest(
            'POST',
            Uri.parse(myUrl),
          );

          Map<String, String> bodyInMultiPart =
              body.map((key, value) => MapEntry(key, value.toString()));
          request.fields.addAll(bodyInMultiPart);
          request.headers.addAll(header);

          if (apiCallType.filePath != null &&
              apiCallType.fileParameter != null &&
              apiCallType.filePath != "" &&
              apiCallType.fileParameter != "") {
            if (kDebugMode) {
              print(apiCallType.fileParameter);
              print(apiCallType.filePath);
            }

            request.files.add(
              await http.MultipartFile.fromPath(
                apiCallType.fileParameter ?? '',
                apiCallType.filePath ?? '',
                filename: apiCallType.filePath ?? "",
                contentType: MediaType(
                  'image',
                  (apiCallType.filePath ?? "").split(".").last,
                ),
              ),
            );
          }

          response = await http.Response.fromStream((await request.send()));
          break;

        case ApiType.multiPartRequestPUT:
          var request = http.MultipartRequest(
            'PUT',
            Uri.parse(myUrl),
          );
          request.fields.addAll(body as Map<String, String>);
          request.headers.addAll(header);

          if (apiCallType.filePath != null &&
              apiCallType.fileParameter != null &&
              apiCallType.filePath != "" &&
              apiCallType.fileParameter != "") {
            try {
              request.files.add(
                http.MultipartFile(
                  apiCallType.fileParameter ?? "",
                  (File(apiCallType.filePath ?? "").readAsBytes().asStream()),
                  File(apiCallType.filePath ?? "").lengthSync(),
                  filename: apiCallType.filePath ?? "",
                  contentType: MediaType(
                    'image',
                    (apiCallType.filePath ?? "").split(".").last,
                  ),
                ),
              );
            } catch (e) {
              rethrow;
            }
          }

          response = await http.Response.fromStream((await request.send()));
          break;

        case ApiType.put:
          response =
              await client.put(Uri.parse(myUrl), body: body, headers: header);
          break;
        case ApiType.rawPut:
          var request = http.Request('PUT', Uri.parse(myUrl));
          request.body = json.encode(body);
          request.headers.addAll(header);
          response = await http.Response.fromStream((await request.send()));
          break;

        case ApiType.options:
          var request = http.Request('OPTIONS', Uri.parse(myUrl));
          request.body = json.encode(body);
          request.headers.addAll(header);
          response = await http.Response.fromStream((await request.send()));
          break;

        case ApiType.delete:
          var request = http.Request('DELETE', Uri.parse(myUrl));
          request.body = json.encode(body);
          request.headers.addAll(header);
          response = await http.Response.fromStream((await request.send()));
          break;
        case ApiType.patch:
          response =
              await client.patch(Uri.parse(myUrl), body: body, headers: header);
          break;
        default:
          break;
      }

      if (response != null && response.statusCode == ApiResponse.statusOK) {
        var data = await _handleDecodeAndStorage(
          url: url,
          encodeData: response.body,
        );
        if (data['message'] ==
            "You are not authorized to access this resource.") {
          await Future.delayed(const Duration(seconds: 1), () async {
            /// Uncomment to show unauthorised toast
            //showToast(decodeData['message']);
            if (url != "user/details") {}
          });
        }
        return data;
      } else if (response != null &&
          response.statusCode == ApiResponse.statusBadRequest) {
        showToast(
          "400 Bad Request, Please try again.",
        );
        return ApiConstant.cancelResponse;
      } else if (response != null &&
          response.statusCode == ApiResponse.statusUnAuthorised) {
        showToast(
          "401 Unauthorised, Please check your credentials try again.",
        );
        return ApiConstant.cancelResponse;
      } else if (response != null &&
          response.statusCode == ApiResponse.statusNotFound) {
        showToast(
          "404 Not Found, Please try again.",
        );
        return ApiConstant.cancelResponse;
      } else if (response != null &&
          response.statusCode == ApiResponse.statusRequestTimeOut) {
        showToast(
          "408 Request Timeout, Please try again.",
        );
        return ApiConstant.cancelResponse;
      } else if (response != null &&
          response.statusCode == ApiResponse.statusInternalServer) {
        showToast(
          "500 Internal Server Error occurred. Please try again.",
        );
        return ApiConstant.cancelResponse;
      } else if (response != null &&
          response.statusCode == ApiResponse.statusGatewayTimeOut) {
        showToast(
          "504 Gateway Timeout. Please try again.",
        );
        return ApiConstant.cancelResponse;
      } else if (response != null &&
          response.statusCode == ApiResponse.statusVersionNotSupported) {
        showToast(
          "505 HTTP Version not supported. Please try again.",
        );
        return ApiConstant.cancelResponse;
      } else {
        showToast(
          "Something went wrong. Trouble in getting response from server. Try after sometime.",
        );
      }
      return ApiConstant.cancelResponse;
    } catch (e) {
      if (retryCount > 0) {
        await Future.delayed(const Duration(seconds: 1));
        return await call(
            url: url,
            apiCallType: apiCallType,
            client: client,
            token: token,
            newBaseUrl: newBaseUrl,
            useThisToken: useThisToken,
            retryCount: (retryCount - 1));
      }
      rethrow;
    }
  }

  Future<Map> _handleDecodeAndStorage({
    required String url,
    required var encodeData,
  }) async {
    if (kDebugMode) {
      print("Response: ${encodeData.toString()}\n");
    }
    try {
      var decodeData = (await json.decode(encodeData));
      return decodeData;
    } catch (e) {
      return ApiConstant.cancelResponse;
    }
  }
}
