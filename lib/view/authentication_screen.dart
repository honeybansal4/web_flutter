import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_demo_satish/app_routes.dart';
import 'package:web_demo_satish/common_widget/button.dart';
import 'package:web_demo_satish/common_widget/common_snackbar.dart';
import 'package:web_demo_satish/common_widget/text_field.dart';
import 'package:web_demo_satish/model/Apis/api_response.dart';
import 'package:web_demo_satish/model/Services/get_storage_service.dart';
import 'package:web_demo_satish/navigation_service/navigation_service.dart';
import 'package:web_demo_satish/view_model/log_in_view_model.dart';

class AuthenticationScreen extends StatefulWidget {
  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  TextEditingController userId = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController organization = TextEditingController();
  TextEditingController language = TextEditingController();
  final NavigationService _navigationService = NavigationService();
  LogInViewModel logInViewModel = Get.put(LogInViewModel());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              width: 400,
              child: Column(
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  buildTextFormField(
                    textEditingController: userId,
                    label: 'User Id',
                    enable: true,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  buildTextFormField(
                    textEditingController: password,
                    label: 'Password',
                    enable: true,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  buildTextFormField(
                    textEditingController: organization,
                    label: 'Organization',
                    enable: true,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  buildTextFormField(
                    textEditingController: language,
                    label: 'Language',
                    enable: true,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  GetBuilder<LogInViewModel>(
                    builder: (controller) {
                      return controller.isLoading == true
                          ? Center(
                              child: CircularProgressIndicator(
                                color: Colors.teal,
                              ),
                            )
                          : commonButton(
                              width: 200,
                              height: 40,
                              onPress: () async {
                                // userId.text = 'Parth';
                                // password.text = 'UGFydGgxMjM=';
                                // organization.text = 'ABC';

                                if (organization.text.isNotEmpty &&
                                    password.text.isNotEmpty &&
                                    userId.text.isNotEmpty) {
                                  controller.updateLoading(true);

                                  await controller.logInViewModel(body: {
                                    "userId": userId.text.trim(),
                                    "password": base64
                                        .encode(password.text.trim().codeUnits),
                                    "organization": organization.text.trim()
                                  });

                                  if (controller.logInApiResponse.status ==
                                      Status.COMPLETE) {
                                    controller.updateLoading(false);

                                    _navigationService.navigateTo(
                                        AppRoutes.homeScreen,
                                        clearStack: true);

                                    GetStorageServices.setUserId(
                                        userId.text.trim());
                                    GetStorageServices.setOrganization(
                                        organization.text.trim());
                                    GetStorageServices.setUserLoggedIn();

                                    CommonSnackBar.getSuccessSnackBar(
                                        context, 'Login Successfully');
                                  } else {
                                    controller.updateLoading(false);
                                    CommonSnackBar.getFailedSnackBar(
                                        context, 'Login failed!');
                                  }
                                } else if (userId.text.isEmpty) {
                                  CommonSnackBar.getWarningSnackBar(
                                      context, 'Enter UserId');
                                } else if (password.text.isEmpty) {
                                  CommonSnackBar.getWarningSnackBar(
                                      context, 'Enter Password');
                                } else if (organization.text.isEmpty) {
                                  CommonSnackBar.getWarningSnackBar(
                                      context, 'Enter Organization');
                                } else {
                                  CommonSnackBar.getFailedSnackBar(
                                      context, 'Something went wrong');
                                }
                              },
                              name: 'Login');
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
