import 'package:codeathon_usecase_5/view/screens/generate_controller_code.dart';
import 'package:codeathon_usecase_5/view/screens/generate_db_schema_screen.dart';
import 'package:codeathon_usecase_5/view/screens/generate_unit_test_screen.dart';
import 'package:codeathon_usecase_5/view/screens/home_screen.dart';
import 'package:codeathon_usecase_5/viewmodel/common_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AddRecordScreen extends StatefulWidget {
  static const String name = "add_record_screen";
  static const String path = "/$name";
  const AddRecordScreen({super.key});

  @override
  State<AddRecordScreen> createState() => _AddRecordScreenState();
}

class _AddRecordScreenState extends State<AddRecordScreen> {
  CommonViewModel? viewModel;

  @override
  void initState() {
    viewModel = Provider.of<CommonViewModel>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CodeCrafters"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
                onPressed: () {
                  viewModel?.projectId = null;
                  viewModel?.projectNameC.text = '';
                  viewModel?.getProjectsList();
                  context.goNamed(HomeScreen.name);
                },
                icon: const Icon(Icons.done)),
          )
        ],
      ),
      body: Selector<CommonViewModel, bool>(
        shouldRebuild: (previous, next) => true,
        selector: (p0, p1) => p1.addBtnEnabled,
        builder: (context, addBtnEnabled, child) {
          return Padding(
            padding: EdgeInsets.symmetric(
                vertical: 12,
                horizontal: MediaQuery.of(context).size.width * 0.15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                TextField(
                  controller: viewModel?.projectNameC,
                  enabled: !addBtnEnabled,
                  decoration: InputDecoration(
                      hintText: "Enter project name",
                      suffixIcon: IconButton(
                          onPressed: () {
                            viewModel?.addProject();
                          },
                          icon: const Icon(Icons.save, color: Colors.blue))),
                ),
                const SizedBox(height: 20),
                const Text(
                    "Insert detailed user story, information architecture, detailed accepteance cirteria with boundary cases, detailed test cases with positive and test cases that will",
                    style: TextStyle(
                        fontSize: 24,
                        letterSpacing: 0.2,
                        wordSpacing: 0.2,
                        height: 1.7,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.justify),
                const SizedBox(
                  height: 20,
                ),
                TextButton.icon(
                    onPressed: () async {
                      if (addBtnEnabled) {
                        await viewModel?.storeChat();
                        viewModel?.chatGPTResponse = null;
                        // ignore: use_build_context_synchronously
                        context.pushNamed(GenerateDbSchemaScreen.name);
                      } else {
                        null;
                      }
                    },
                    icon: Icon(Icons.storage,
                        color: addBtnEnabled ? Colors.blue : Colors.grey),
                    label: Text(
                      "Generate Database Schema",
                      style: TextStyle(
                          color: addBtnEnabled ? Colors.blue : Colors.grey),
                    )),
                const SizedBox(height: 10),
                TextButton.icon(
                    onPressed: () async {
                      if (addBtnEnabled) {
                        await viewModel?.storeChat();
                        viewModel?.chatGPTResponse = null;
                        // ignore: use_build_context_synchronously
                        context.pushNamed(GenerateUnitTestScreen.name);
                      } else {
                        null;
                      }
                    },
                    icon: Icon(Icons.filter_alt,
                        color: addBtnEnabled ? Colors.blue : Colors.grey),
                    label: Text(
                      "Generate Unit Test Code",
                      style: TextStyle(
                          color: addBtnEnabled ? Colors.blue : Colors.grey),
                    )),
                const SizedBox(height: 10),
                TextButton.icon(
                    onPressed: () async {
                      if (addBtnEnabled) {
                        await viewModel?.storeChat();
                        viewModel?.chatGPTResponse = null;
                        // ignore: use_build_context_synchronously
                        context.pushNamed(GenerateControllerCodeScreen.name);
                      } else {
                        null;
                      }
                    },
                    icon: Icon(Icons.settings_input_component_outlined,
                        color: addBtnEnabled ? Colors.blue : Colors.grey),
                    label: Text(
                      "Generate Controller Code",
                      style: TextStyle(
                          color: addBtnEnabled ? Colors.blue : Colors.grey),
                    )),
                const SizedBox(height: 10),
              ],
            ),
          );
        },
      ),
    );
  }
}
