import 'package:codeathon_usecase_5/app_manager/component/responsive/widget/responsive_helper.dart';
import 'package:codeathon_usecase_5/app_manager/helper/navigation/navigation_helper.dart';
import 'package:codeathon_usecase_5/gen/assets.gen.dart';
import 'package:codeathon_usecase_5/models/projects.dart';
import 'package:codeathon_usecase_5/view/screens/add_record_screen.dart';
import 'package:codeathon_usecase_5/view/screens/project_details_screen.dart';
import 'package:codeathon_usecase_5/viewmodel/common_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String name = "home_screen";
  static const String path = "/$name";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CommonViewModel? viewModel;

  @override
  void initState() {
    viewModel = Provider.of<CommonViewModel>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("CodeCrafters")),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: Assets.png.aiBg.provider(),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.7),
                  BlendMode.srcOver,
                ))),
        child: ResponsiveHelperWidget(
            desktop: Row(
              children: [
                Expanded(child: _buildInformationWidget()),
                Expanded(child: _buildHistoryWidget(context, viewModel)),
              ],
            ),
            mobile: Column(
              children: [
                _buildInformationWidget(),
                Expanded(child: _buildHistoryWidget(context, viewModel)),
              ],
            )),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 12, 16),
        child: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            viewModel?.projectNameC.text = "";
            viewModel?.projectId = null;
            viewModel?.addBtnEnabled = false;
            NavigationHelper.pushNamed(context, AddRecordScreen.name);
          },
        ),
      ),
    );
  }
}

Widget _buildHistoryWidget(BuildContext context, CommonViewModel? viewModel) {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Align(
          alignment: Alignment.center,
          child: Selector<CommonViewModel, List<Projects>>(
              shouldRebuild: (previous, next) => true,
              selector: (context, viewModel) => viewModel.projectsList,
              builder: (context, projectsList, child) {
                return viewModel?.isLoading ?? true
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : projectsList.isEmpty
                        ? const Center(
                            child: Text(
                            "No history available.\n\nClick on plus icon to add new record.",
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
                                const Text(
                                  "Projects history:",
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
                                    itemCount: projectsList.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final item = projectsList[index];
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all()),
                                          child: ListTile(
                                            title: Text(
                                              item.name ?? "",
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  letterSpacing: 0.2,
                                                  wordSpacing: 0.2,
                                                  height: 1.5,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            subtitle: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 10, 0, 20),
                                              child: Text(
                                                'Created at: ${item.createdAt ?? ""}',
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  letterSpacing: 0.2,
                                                  wordSpacing: 0.2,
                                                  height: 1.5,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            onTap: () {
                                              NavigationHelper.pushNamed(
                                                  context,
                                                  ProjectDetailsScreen.name,
                                                  pathParameters: {
                                                    'projectId':
                                                        item.id.toString()
                                                  });
                                            },
                                          ),
                                        ),
                                      );
                                    }),
                              ],
                            ),
                          );
              })),
    ),
  );
}

Widget _buildInformationWidget() {
  return const Padding(
    padding: EdgeInsets.fromLTRB(50, 12, 50, 12),
    child: Align(
        alignment: Alignment.center,
        child: Text(
          "Insert detailed user story, information architecture, detailed accepteance cirteria with boundary cases, detailed test cases with positive and test cases that will generate following for you \n\n- Database Schema \n- Unit test code \n- Controller code based on unit test cases",
          style: TextStyle(
              fontSize: 24,
              letterSpacing: 0.2,
              wordSpacing: 0.2,
              height: 1.7,
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.justify,
        )),
  );
}
