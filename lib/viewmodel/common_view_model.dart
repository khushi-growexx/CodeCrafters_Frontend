import 'package:codeathon_usecase_5/app_manager/api/api_call.dart';
import 'package:codeathon_usecase_5/app_manager/api/project_response.dart';
import 'package:codeathon_usecase_5/app_manager/helper/show_toast.dart';
import 'package:codeathon_usecase_5/models/chats.dart';
import 'package:codeathon_usecase_5/models/projects.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CommonViewModel extends ChangeNotifier {
  List<Projects> projectsList = [];
  List<Chats> chatsList = [];
  http.Client client = http.Client();
  bool _isLoading = false;
  final TextEditingController projectNameC = TextEditingController();

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool get isLoading => _isLoading;

  bool _isChatsLoading = false;

  set isChatsLoading(bool value) {
    _isChatsLoading = value;
    notifyListeners();
  }

  bool get isChatsLoading => _isChatsLoading;

  bool _addBtnEnabled = false;

  set addBtnEnabled(bool value) {
    _addBtnEnabled = value;
    notifyListeners();
  }

  bool get addBtnEnabled => _addBtnEnabled;

  int? projectId;
  int? chatId;
  String? chatGPTResponse;
  String? currentProjectName;

  CommonViewModel() {
    getProjectsList();
  }

  Future getProjectsList() async {
    try {
      isLoading = true;
      var response = await ApiCall().call(
          url: "/api/get-all-projects",
          apiCallType: ApiCallType.get(),
          client: client);
      ProjectResponse data = ProjectResponse.fromJson(response);
      final itemList = data.data as List<dynamic>;
      List<Projects> projects =
          itemList.map((e) => Projects.fromJson(e)).toList();
      if (data.success == true) {
        projectsList = projects.reversed.toList();
      } else {
        showToast(
          data.message ?? "",
        );
      }
      isLoading = false;
    } catch (error) {
      isLoading = false;
    }
  }

  Future addProject() async {
    try {
      if (projectNameC.text.trim().isEmpty) {
        showToast("Can't add a project with empty name");
        return;
      }
      final body = {"name": projectNameC.text};
      var response = await ApiCall().call(
          url: "/api/store-project",
          apiCallType: ApiCallType.post(body: body),
          client: client);
      ProjectResponse data = ProjectResponse.fromJson(response);
      if (data.success == true) {
        projectId = data.data['id'];
        showToast(
          data.message ?? "",
        );
        addBtnEnabled = true;
      } else {
        showToast(
          data.message ?? "",
        );
      }
    } catch (error) {}
  }

  Future<void> storeChat() async {
    try {
      final body = {"project_id": projectId};
      var response = await ApiCall().call(
          url: "/api/store-chat",
          apiCallType: ApiCallType.rawPost(body: body),
          client: client);
      ProjectResponse data = ProjectResponse.fromJson(response);
      if (data.success == true) {
        chatId = data.data['id'];
      } else {
        showToast(
          data.message ?? "",
        );
      }
    } catch (error) {}
  }

  Future<void> getResponseFromChatGPT(String text) async {
    isLoading = true;
    try {
      if (text.trim().isEmpty) {
        showToast("Can't get response for empty input");
        return;
      }
      final body = {"message": text, "chat_id": chatId};
      var response = await ApiCall().call(
          url: "/api/chat",
          apiCallType: ApiCallType.rawPost(body: body),
          client: client);
      ProjectResponse data = ProjectResponse.fromJson(response);
      if (data.success == true) {
        chatGPTResponse = data.data;
      } else {
        showToast(
          data.message ?? "",
        );
      }
      isLoading = false;
    } catch (error) {
      isLoading = false;
    }
  }

  Future<void> getProjectDetails(int? projectId) async {
    if (projectId == null) {
      return;
    }
    isChatsLoading = true;
    try {
      final body = {"project_id": projectId};
      var response = await ApiCall().call(
          url: "/api/get-project-details",
          apiCallType: ApiCallType.rawPost(body: body),
          client: client);
      ProjectResponse data = ProjectResponse.fromJson(response);
      if (data.success == true) {
        final itemList = data.data as List<dynamic>;
        if (itemList.isNotEmpty) {
          currentProjectName = itemList[0]['Project Name'];
        }
        List<Chats> chats = itemList.map((e) => Chats.fromJson(e)).toList();
        chatsList = chats;
      } else {
        showToast(
          data.message ?? "",
        );
      }
      isChatsLoading = false;
    } catch (error) {
      isChatsLoading = false;
    }
  }
}
