import 'package:codeathon_usecase_5/app_manager/helper/navigation/navigation_helper.dart';
import 'package:codeathon_usecase_5/app_manager/helper/show_toast.dart';
import 'package:codeathon_usecase_5/models/chats.dart';
import 'package:codeathon_usecase_5/view/screens/add_record_screen.dart';
import 'package:codeathon_usecase_5/viewmodel/common_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ProjectDetailsScreen extends StatefulWidget {
  static const String name = "project_details_screen";
  static const String path = "/$name/:projectId";
  const ProjectDetailsScreen({super.key, this.projectId});
  final String? projectId;

  @override
  State<ProjectDetailsScreen> createState() => _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen> {
  CommonViewModel? viewModel;

  @override
  void initState() {
    viewModel = Provider.of<CommonViewModel>(context, listen: false);
    viewModel?.getProjectDetails(int.parse(widget.projectId ?? ""));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Project Details"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Align(
              alignment: Alignment.center,
              child: Selector<CommonViewModel, List<Chats>>(
                  shouldRebuild: (previous, next) => true,
                  selector: (context, viewModel) => viewModel.chatsList,
                  builder: (context, chatsList, child) {
                    return viewModel?.isChatsLoading ?? true
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : chatsList.isEmpty
                            ? const Center(
                                child: Text(
                                "No Chat History Available",
                                style: TextStyle(
                                    fontSize: 20,
                                    letterSpacing: 0.2,
                                    wordSpacing: 0.2,
                                    height: 1.5,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ))
                            : Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 12),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Project Name: ${viewModel?.currentProjectName ?? ""}",
                                      style: const TextStyle(
                                          fontSize: 20,
                                          letterSpacing: 0.2,
                                          wordSpacing: 0.2,
                                          height: 1.5,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 20),
                                    const Text(
                                      "Chats history:",
                                      style: TextStyle(
                                          fontSize: 20,
                                          letterSpacing: 0.2,
                                          wordSpacing: 0.2,
                                          height: 1.5,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 40),
                                    ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: chatsList.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          final item = chatsList[index];
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  border: Border.all()),
                                              child: ListTile(
                                                title: Text(
                                                  "Input:\n${item.input ?? ""}",
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      letterSpacing: 0.2,
                                                      wordSpacing: 0.2,
                                                      height: 1.5,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                subtitle: Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 10, 0, 20),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Align(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        child: IconButton(
                                                            onPressed:
                                                                () async {
                                                              await Clipboard.setData(
                                                                  ClipboardData(
                                                                      text: item
                                                                              .output ??
                                                                          ""));
                                                              showToast(
                                                                  'Copied to clipboard');
                                                            },
                                                            icon: const Icon(
                                                                Icons.copy)),
                                                      ),
                                                      Text(
                                                        'Output:\n${item.output ?? ""}',
                                                        style: const TextStyle(
                                                          fontSize: 16,
                                                          letterSpacing: 0.2,
                                                          wordSpacing: 0.2,
                                                          height: 1.5,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                  ],
                                ),
                              );
                  })),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 12, 16),
        child: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            viewModel?.projectNameC.text = viewModel?.currentProjectName ?? "";
            viewModel?.projectId = int.parse(widget.projectId ?? '');
            viewModel?.addBtnEnabled = true;
            NavigationHelper.pushNamed(context, AddRecordScreen.name);
          },
        ),
      ),
    );
  }
}
