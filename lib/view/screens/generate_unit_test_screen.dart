import 'package:codeathon_usecase_5/app_manager/helper/show_toast.dart';
import 'package:codeathon_usecase_5/viewmodel/common_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class GenerateUnitTestScreen extends StatefulWidget {
  static const String name = "generate_unit_test_screen";
  static const String path = "/$name";
  const GenerateUnitTestScreen({super.key});

  @override
  State<GenerateUnitTestScreen> createState() => _GenerateUnitTestScreenState();
}

class _GenerateUnitTestScreenState extends State<GenerateUnitTestScreen> {
  CommonViewModel? viewModel;
  TextEditingController inputC = TextEditingController();

  @override
  void initState() {
    viewModel = Provider.of<CommonViewModel>(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {
    viewModel?.chatsList = [];
    viewModel?.currentProjectName = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Database Schema"),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20),
              child: IconButton(
                  onPressed: () {
                    viewModel?.chatId = null;
                    Router.neglect(context, () => context.pop());
                  },
                  icon: const Icon(Icons.save)))
        ],
      ),
      body: Selector<CommonViewModel, bool>(
        shouldRebuild: (previous, next) => true,
        selector: (p0, p1) => p1.isLoading,
        builder: (context, isLoading, child) {
          return SingleChildScrollView(
            physics: isLoading ? const NeverScrollableScrollPhysics() : null,
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: MediaQuery.of(context).size.width * 0.15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                          "Insert detailed user story, information architecture, detailed accepteance cirteria with boundary cases, detailed test cases with positive and test cases that will generate following for you \n- Unit Test Code",
                          style: TextStyle(
                              fontSize: 18,
                              letterSpacing: 0.2,
                              wordSpacing: 0.2,
                              height: 1.4),
                          textAlign: TextAlign.justify),
                      const SizedBox(
                        height: 20,
                      ),
                      const SelectableText(
                          "For example: I want to create a login page for a e commerce appliction.",
                          style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 0.2,
                              wordSpacing: 0.2,
                              height: 1.4),
                          textAlign: TextAlign.justify),
                      const SizedBox(
                        height: 40,
                      ),
                      TextField(
                        controller: inputC,
                        decoration: const InputDecoration(
                            hintText: "Enter detailed user story...",
                            border: OutlineInputBorder()),
                        maxLines: 20,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton.icon(
                          label: const Text("Generate"),
                          onPressed: () {
                            viewModel?.getResponseFromChatGPT("${inputC.text}. Generate Unit test cases for this.");
                          },
                          icon: const Icon(Icons.wifi_protected_setup),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      if ((viewModel?.chatGPTResponse ?? "").trim().isNotEmpty)
                        Column(
                          children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Response:"),
                                  IconButton(
                                      onPressed: () async {
                                        await Clipboard.setData(ClipboardData(
                                            text: viewModel?.chatGPTResponse ??
                                                ""));
                                        showToast('Copied to clipboard');
                                      },
                                      icon: const Icon(Icons.copy))
                                ]),
                            Text(viewModel?.chatGPTResponse ?? "")
                          ],
                        )
                    ],
                  ),
                ),
                if (isLoading)
                  Container(
                    height: MediaQuery.of(context).size.height,
                    color: Colors.black.withOpacity(0.5),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
              ],
            ),
          );
        },
      ),
    );
  }
}
