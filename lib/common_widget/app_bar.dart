import 'dart:developer';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_demo_satish/common_widget/common_snackbar.dart';
import 'package:web_demo_satish/common_widget/drop_down.dart';
import 'package:web_demo_satish/common_widget/logger.dart';
import 'package:web_demo_satish/common_widget/text_field.dart';
import 'package:web_demo_satish/model/Repo/delete_form_repo.dart';
import 'package:web_demo_satish/model/Repo/edit_form_repo.dart';
import 'package:web_demo_satish/model/Repo/edit_saved_form_repo.dart';
import 'package:web_demo_satish/model/Services/get_storage_service.dart';
import 'package:web_demo_satish/view_model/add_form_view_model.dart';
import 'package:web_demo_satish/view_model/get_all_form_view_model.dart';
import 'package:web_demo_satish/view_model/set_form_view_model.dart';
import 'package:web_demo_satish/view_model/show_form_view_model.dart';

buildAppBar({
  BuildContext? context,
  GlobalKey<ScaffoldState>? scaffoldKey,
  double? width,
  SetFormViewModel? setFormViewModel,
  AddFormViewModel? addFormViewModel,
  GetAllFormViewModel? getAllFormViewModel,
  ShowSelectFormViewModel? showSelectFormViewModel,
}) {
  return AppBar(
    leadingWidth: 100,
    leading: Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            'https://wallpapercave.com/fwp/wp5204552.jpg',
            height: 40,
            width: 40,
            fit: BoxFit.cover,
          ),
        ),
      ],
    ),
    bottom: PreferredSize(
      child: SizedBox(
        height: 45,
        width: Get.width,
        child: GetBuilder<SetFormViewModel>(
          builder: (controller) {
            return ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: controller.navigationItem.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(
                      100,
                    ),
                    onTap: () {
                      controller.updateSelectTab(index);
                      clearPreviousData(controller, showSelectFormViewModel);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: controller.selectTab == index
                            ? Colors.grey.shade300
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(
                          100,
                        ),
                      ),
                      child: Text(
                        '${controller.navigationItem[index]}',
                        style: TextStyle(
                          color: controller.selectTab == index
                              ? Colors.black
                              : Colors.white,
                          fontSize: 15,
                          fontWeight: controller.selectTab == index
                              ? FontWeight.w500
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      preferredSize: Size(
        Get.width,
        30,
      ),
    ),
    centerTitle: true,
    title: Text(
      '${GetStorageServices.getOrganization()}',
    ),
    actions: [
      GetBuilder<SetFormViewModel>(
        builder: (setController) {
          return setController.pageSelected == -1 &&
                  setController.selectAllPage == -1
              ? Row(
                  children: [
                    Text('FontSize : ${(width! * 0.010).toStringAsFixed(0)}'),
                    SizedBox(
                      width: 20,
                    ),
                    Text('Heigth : ${(width * 0.02).toStringAsFixed(0)}'),
                    SizedBox(
                      width: 20,
                    ),
                    Text('Field Width : ${(width / 2.4).toStringAsFixed(0)}'),
                    SizedBox(
                      width: 20,
                    ),
                    EditFormOpen(showSelectFormViewModel, setFormViewModel),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                )
              : setController.pageSelected == 1
                  ? setFormViewModel?.saveCall == true
                      ? SizedBox()
                      : AddFormWidget(setFormViewModel, setController,
                          addFormViewModel, getAllFormViewModel, context)
                  : setController.pageSelected == 2
                      ? GetBuilder<ShowSelectFormViewModel>(
                          builder: (controller) {
                            try {
                              return (controller.getSelectForm['entries']
                                          as List)
                                      .isEmpty
                                  ? SizedBox()
                                  : Row(
                                      children: [
                                        Text(
                                            'FontSize : ${(width! * 0.010).toStringAsFixed(0)}'),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                            'Heigth : ${(width * 0.02).toStringAsFixed(0)}'),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                            'Field Width : ${(width / 2.4).toStringAsFixed(0)}'),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        controller.isLoader == true
                                            ? SizedBox()
                                            : IconButton(
                                                splashRadius: 20,
                                                onPressed: () async {
                                                  controller
                                                      .updateLoaderValue(true);
                                                  controller.updateDummyMap();
                                                  // (controller.dummyGetSelectForm[
                                                  //         'entries'] as List)
                                                  //     .forEach((element) {
                                                  //   (element as Map)
                                                  //       .remove('label_id');
                                                  // });

                                                  LoggerUtils.logI(
                                                      '==========ENTRIES-----${controller.dummyGetSelectForm['entries']}');
                                                  LoggerUtils.logI(
                                                      '==========IDS-----${controller.getSelectForm['_id']}');
                                                  int statusCode = await EditFormRepo.editFormRepo(
                                                      description: controller
                                                              .dummyGetSelectForm[
                                                          'description'],
                                                      menuType: controller
                                                              .dummyGetSelectForm[
                                                          'menuType'],
                                                      group: controller
                                                              .dummyGetSelectForm[
                                                          'group'],
                                                      name: controller
                                                              .dummyGetSelectForm[
                                                          'name'],
                                                      organization: controller
                                                              .dummyGetSelectForm[
                                                          'organization'],
                                                      roles: controller
                                                          .dummyGetSelectForm['roles'],
                                                      status: controller.dummyGetSelectForm['status'],
                                                      body: controller.dummyGetSelectForm['entries'],
                                                      urlId: controller.getSelectForm['_id'].toString());
                                                  LoggerUtils.logI(
                                                      '----STATUS CODE----${statusCode}');
                                                  if (statusCode == 200) {
                                                    controller
                                                        .updateLoaderValue(
                                                            false);

                                                    await getAllFormViewModel
                                                        ?.getAllFormViewModel(
                                                            loading: true);
                                                    await setFormViewModel
                                                        ?.getNavigationDataViewModel(
                                                            isLoading: true);
                                                    CommonSnackBar
                                                        .getSuccessSnackBar(
                                                            context!,
                                                            "Form Update Successfully");

                                                    try {
                                                      if (controller
                                                          .getSelectSaveForm
                                                          .isNotEmpty) {
                                                        for (int i = 0;
                                                            i <
                                                                controller
                                                                    .getSelectSaveForm
                                                                    .length;
                                                            i++) {
                                                          int statusCode =
                                                              await EditSavedFormRepo
                                                                  .editSavedFormRepo(
                                                                      body: {
                                                                'id':
                                                                    '${controller.getSelectSaveForm[i]['_id']}',
                                                                'payload': controller
                                                                        .getSelectSaveForm[
                                                                    i]['payload']
                                                              },
                                                                      formId:
                                                                          '${controller.getSelectForm['_id']}');

                                                          if (statusCode ==
                                                              200) {
                                                            print(
                                                                '---------SUCCESS FULL----------------------');
                                                          } else {
                                                            controller
                                                                .updateLoaderValue(
                                                                    false);
                                                            print(
                                                                '---------ERROR----------------------');
                                                          }
                                                        }
                                                      } else {
                                                        print(
                                                            '---------ERROR-1---------------------');
                                                      }
                                                    } catch (e) {
                                                      controller
                                                          .updateLoaderValue(
                                                              false);

                                                      print(
                                                          '-----ERROR SAVE DATA---- $e');
                                                    }
                                                    setFormViewModel
                                                        ?.updateSaveSelectedPage(
                                                            -1);
                                                    setFormViewModel
                                                        ?.updateSelectedPage(0);

                                                    setFormViewModel
                                                        ?.clearForm();
                                                    controller.getSelectForm
                                                        .clear();
                                                    controller.getSelectSaveForm
                                                        .clear();
                                                  } else {
                                                    print(
                                                        '----STATUS CODE 400----${statusCode}');

                                                    controller
                                                        .updateLoaderValue(
                                                            false);

                                                    CommonSnackBar
                                                        .getFailedSnackBar(
                                                            context!,
                                                            "Try Again");
                                                  }
                                                  controller
                                                      .updateLoaderValue(false);
                                                },
                                                icon: Icon(Icons.save),
                                              ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        controller.isLoader == true
                                            ? SizedBox()
                                            : IconButton(
                                                splashRadius: 20,
                                                onPressed: () {
                                                  deleteFormData(
                                                      scaffoldKey: scaffoldKey,
                                                      width: width,
                                                      context: context,
                                                      getAllFormViewModel:
                                                          getAllFormViewModel,
                                                      setFormViewModel:
                                                          setFormViewModel,
                                                      showSelectFormViewModel:
                                                          showSelectFormViewModel);
                                                },
                                                icon: Icon(Icons.delete),
                                              ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        controller.isLoader == true
                                            ? SizedBox()
                                            : IconButton(
                                                splashRadius: 20,
                                                onPressed: () async {
                                                  showDialog(
                                                    barrierDismissible: false,
                                                    context: context!,
                                                    builder: (context) {
                                                      return Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                                color: Colors
                                                                    .teal),
                                                      );
                                                    },
                                                  );
                                                  setController.selectedRoles =
                                                      controller.getSelectForm[
                                                              'roles'] ??
                                                          [];
                                                  setController
                                                          .selectedOrganization =
                                                      controller.getSelectForm[
                                                              'organization'] ??
                                                          [];
                                                  setController
                                                          .selectFormStatus =
                                                      controller.getSelectForm[
                                                              'status'] ??
                                                          '';
                                                  setController.selectedGroup =
                                                      controller.getSelectForm[
                                                              'group'] ??
                                                          [];

                                                  setController.titleController
                                                          .text =
                                                      controller.getSelectForm[
                                                          'name'];
                                                  setController
                                                          .desController.text =
                                                      controller.getSelectForm[
                                                          'description'];
                                                  setController
                                                          .selectTypeOfForm =
                                                      controller.getSelectForm[
                                                          'menuType'];

                                                  await setFormViewModel
                                                      ?.callAllApi();
                                                  Get.back();
                                                  showMainInfoDialog(
                                                      width: width,
                                                      context: context,
                                                      selectFormViewModel:
                                                          controller,
                                                      formController:
                                                          setFormViewModel,
                                                      getAllFormController:
                                                          getAllFormViewModel);
                                                },
                                                icon: Icon(Icons.settings),
                                              ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        controller.isLoader == true
                                            ? SizedBox()
                                            : IconButton(
                                                splashRadius: 20,
                                                onPressed: () {
                                                  controller.clearSelectForm();
                                                  print(
                                                      '------SHOW FORM CONTROLLER----${controller.getSelectForm}');
                                                },
                                                icon: Icon(Icons.close),
                                              )
                                      ],
                                    );
                            } catch (e) {
                              print('----APP BAR ERROR---$e');

                              return SizedBox();
                            }
                          },
                        )
                      : setController.selectAllPage == 0
                          ? SizedBox()
                          : SizedBox();
        },
      ),
      ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          'https://wallpapercave.com/fwp/wp11957548.jpg',
          height: 40,
          width: 40,
          fit: BoxFit.cover,
        ),
      ),
      SizedBox(
        width: 25,
      )
    ],
  );
}

/// ADD FORM DIALOG
showMainInfoDialog({
  required double width,
  BuildContext? context,
  GetAllFormViewModel? getAllFormController,
  SetFormViewModel? formController,
  ShowSelectFormViewModel? selectFormViewModel,
}) {
  showDialog(
    context: context!,
    barrierDismissible: false,
    builder: (context) => StatefulBuilder(
      builder: (context, setStat) {
        return Dialog(
          child: SizedBox(
            width: width / 3,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.04, vertical: width * 0.025),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Page',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        SizedBox(
                          width: width * 0.02,
                        ),
                        Expanded(
                          child: buildTextFormField(
                            textEditingController:
                                formController?.titleController,
                            label: 'Page Name',
                            enable: true,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    Row(
                      children: [
                        Text(
                          'Description',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        SizedBox(
                          width: width * 0.02,
                        ),
                        Expanded(
                          child: buildTextFormField(
                            textEditingController:
                                formController?.desController,
                            label: 'Type',
                            enable: true,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    Row(
                      children: [
                        Text(
                          'Navigation',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        SizedBox(
                          width: width * 0.02,
                        ),
                        buildDropdownButton(
                          dropDownValue: formController?.selectTypeOfForm,
                          dropDownValueList: formController?.navigationItem,
                          changeData: (val) {
                            formController?.updateSelectFormType(val!);
                            setStat(() {});
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    Row(
                      children: [
                        Text(
                          'Status',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        SizedBox(
                          width: width * 0.02,
                        ),
                        buildDropdownButton(
                          dropDownValue: formController?.selectFormStatus,
                          dropDownValueList: ['Active', 'Inactive'],
                          changeData: (val) {
                            formController?.updateSelectFormStatus(val!);
                            setStat(() {});
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    Row(
                      children: [
                        Text(
                          'Group',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        SizedBox(
                          width: width * 0.02,
                        ),
                        Flexible(
                          fit: FlexFit.loose,
                          child: DropdownButtonHideUnderline(
                            child: DropdownSearch<dynamic>.multiSelection(
                              validator: (val) {
                                if (val!.isEmpty) {
                                  CommonSnackBar.getWarningSnackBar(
                                      context, 'Please Select a Group');
                                  return 'Please Select a Group';
                                }
                                return null;
                              },
                              items: formController!.groupItems,
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Search Group'),
                              ),
                              onChanged: (List<dynamic> value) {
                                log('selectedGroup>>>>${formController.selectedGroup}');

                                formController.selectedGroup = value;
                                log('SELECTED GROUP==${formController.selectedGroup}');

                                log('LIST ${value.toString()}');
                              },
                              selectedItems: formController.selectedGroup == []
                                  ? []
                                  : formController.selectedGroup,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    Row(
                      children: [
                        Text(
                          'Organization',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        SizedBox(
                          width: width * 0.02,
                        ),
                        Flexible(
                          fit: FlexFit.loose,
                          child: DropdownButtonHideUnderline(
                            child: DropdownSearch<dynamic>.multiSelection(
                              validator: (val) {
                                if (val!.isEmpty) {
                                  CommonSnackBar.getWarningSnackBar(
                                      context, 'Please Select a Organization');
                                  return 'Please Select a Organization';
                                }
                                return null;
                              },
                              items: formController.organizationItems,
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Search Organization'),
                              ),
                              onChanged: (List<dynamic> value) {
                                log('selectedOrganization>>>>${formController.selectedOrganization}');

                                formController.selectedOrganization = value;
                                log('SELECTED ORGANIZATION==${formController.selectedOrganization}');

                                log('LIST ${value.toString()}');
                              },
                              selectedItems:
                                  formController.selectedOrganization == []
                                      ? []
                                      : formController.selectedOrganization,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    Row(
                      children: [
                        Text(
                          'Roles',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        SizedBox(
                          width: width * 0.02,
                        ),
                        Flexible(
                          fit: FlexFit.loose,
                          child: DropdownButtonHideUnderline(
                            child: DropdownSearch<dynamic>.multiSelection(
                              validator: (val) {
                                if (val!.isEmpty) {
                                  CommonSnackBar.getWarningSnackBar(
                                      context, 'Please Select a Roles');
                                  return 'Please Select a Roles';
                                }
                                return null;
                              },
                              items: formController.rolesItem,
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Search Roles'),
                              ),
                              onChanged: (List<dynamic> value) {
                                log('selectedRole>>>>${formController.selectedRoles}');

                                formController.selectedRoles = value;
                                log('SELECTED ROLES==${formController.selectedRoles}');

                                log('LIST ${value.toString()}');
                              },
                              selectedItems: formController.selectedRoles == []
                                  ? []
                                  : formController.selectedRoles,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            formController.updateSaveCall(false);
                            print(
                                '--------HELLOOO---${selectFormViewModel?.getSelectForm}');
                            selectFormViewModel?.getSelectForm['roles'] =
                                formController.selectedRoles;
                            selectFormViewModel?.getSelectForm['organization'] =
                                formController.selectedOrganization;
                            selectFormViewModel?.getSelectForm['status'] =
                                formController.selectFormStatus;
                            selectFormViewModel?.getSelectForm['group'] =
                                formController.selectedGroup;

                            selectFormViewModel?.getSelectForm['name'] =
                                formController.titleController.text;
                            selectFormViewModel?.getSelectForm['description'] =
                                formController.desController.text;
                            selectFormViewModel?.getSelectForm['menuType'] =
                                formController.selectTypeOfForm;
                            Navigator.pop(context);
                            print(
                                '-----FORM-------${selectFormViewModel?.getSelectForm}');
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: width * 0.01,
                                vertical: width * 0.008),
                            child: const Text("OK"),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            formController.updateSaveCall(false);

                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: width * 0.01,
                                vertical: width * 0.008),
                            child: const Text("CANCEL"),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    ),
  );
}

/// ADD FORM WIDGET
AddFormWidget(
    SetFormViewModel? setFormViewModel,
    SetFormViewModel controller,
    AddFormViewModel? addFormViewModel,
    GetAllFormViewModel? getAllFormViewModel,
    BuildContext? context) {
  return IconButton(
    splashRadius: 20,
    onPressed: () async {
      setFormViewModel?.updateSaveCall(true);
      LoggerUtils.logI('-----ALL MAP---${controller.dataOfMap}');
      if ((controller.dataOfMap['entries'] as List).isNotEmpty) {
        int? status =
            await addFormViewModel?.addFormRepo(body: controller.dataOfMap);

        if (status == 200) {
          getAllFormViewModel?.getAllFormViewModel(loading: true);
          setFormViewModel?.getNavigationDataViewModel();
          CommonSnackBar.getSuccessSnackBar(context!, 'Form Add Successfully');
          setFormViewModel?.clearForm();
          setFormViewModel?.updateSaveCall(false);
        } else {
          CommonSnackBar.getFailedSnackBar(context!, 'Something went wrong');
          setFormViewModel?.updateSaveCall(false);
        }
      } else {
        setFormViewModel?.updateSaveCall(false);

        CommonSnackBar.getWarningSnackBar(context!, 'Add Field first!');
      }
    },
    icon: Icon(Icons.save),
  );
}

/// OPEN EDIT FORM FROM OPEN FORM
EditFormOpen(ShowSelectFormViewModel? showSelectFormViewModel,
    SetFormViewModel? setFormViewModel) {
  return IconButton(
    splashRadius: 20,
    onPressed: () async {
      print(
          '----showSelectFormViewModel.getSelectForm-----${showSelectFormViewModel?.getSelectForm['_id']}');
      setFormViewModel?.updateSelectedPage(2);
      setFormViewModel?.updateSelectTab(0);
      await showSelectFormViewModel
          ?.showSelectFormViewModel(
              formId: showSelectFormViewModel.getSelectForm['_id'],
              loading: true)
          .then(
            (value) => showSelectFormViewModel.getEditFormSaveDataViewModel(
                label: showSelectFormViewModel.getSelectForm['entries'][0]
                    ['label'],
                id: showSelectFormViewModel.getSelectForm['_id']),
          );
    },
    icon: Icon(Icons.edit),
  );
}

/// CLEAR PREVIOUS DATA WHEN SWITCH BETWEEN 2 TABS
void clearPreviousData(SetFormViewModel controller,
    ShowSelectFormViewModel? showSelectFormViewModel) {
  controller.updateSaveSelectedPage(-1);
  controller.updateSelectedPage(0);
  controller.clearForm();
  showSelectFormViewModel?.getSelectForm.clear();
  showSelectFormViewModel?.getSelectSaveForm.clear();
}

/// FOR DELETE FORM
deleteFormData({
  GlobalKey<ScaffoldState>? scaffoldKey,
  double? width,
  BuildContext? context,
  GetAllFormViewModel? getAllFormViewModel,
  SetFormViewModel? setFormViewModel,
  ShowSelectFormViewModel? showSelectFormViewModel,
}) {
  showDialog(
    context: context!,
    builder: (context) {
      return AlertDialog(
        title: Text('Are you sure to delete this form?'),
        actions: [
          TextButton(
            onPressed: () async {
              Get.back();
              setFormViewModel?.updateSelectedPage(0);
              setFormViewModel?.updateSaveSelectedPage(-1);

              print(
                  '------FORMID---${showSelectFormViewModel?.getSelectForm['_id']}');
              int status = await DeleteFormRepo.deleteFormRepo(
                  formId: '${showSelectFormViewModel?.getSelectForm['_id']}');
              if (status.toString() == '200') {
                CommonSnackBar.getSuccessSnackBar(
                    scaffoldKey!.currentContext!, 'Form delete Successfully');
                await getAllFormViewModel?.getAllFormViewModel(loading: true);
                await setFormViewModel?.getNavigationDataViewModel();
                setFormViewModel?.clearForm();
              } else {
                CommonSnackBar.getFailedSnackBar(
                    context, 'Form not deleted Try Again!');
              }

              // CommonSnackBar.getSnackBar(context, Get.width, AppColor.mainColor,
              //     "Form Delete Successfully");
            },
            child: Text(
              'Yes',
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text(
              'No',
            ),
          ),
        ],
      );
    },
  );
}

/// REMOVE DROP DOWN
// GetBuilder<SetFormViewModel>(
//   builder: (controller) {
//     return Container(
//       decoration: BoxDecoration(border: Border.all()),
//       padding: EdgeInsets.symmetric(horizontal: 10),
//       alignment: Alignment.center,
//       child: Theme(
//         data: Theme.of(context!).copyWith(
//           splashColor: Colors.transparent,
//           hoverColor: Colors.transparent,
//           focusColor: Colors.transparent,
//         ),
//         child: DropdownButtonHideUnderline(
//           child: DropdownButton(
//             style: const TextStyle(
//                 color: Colors.black,
//                 backgroundColor: Colors.transparent),
//             dropdownColor: Colors.white,
//             elevation: 0,
//
//             hint: controller.selectMenu == ''
//                 ? Text(
//                     'Select Option',
//                     style: TextStyle(color: Colors.white),
//                   )
//                 : Text(
//                     '${controller.selectMenu}',
//                     style: TextStyle(color: Colors.white),
//                   ),
//             items: [
//               'Add Form',
//               'Edit Form',
//               'Field Names',
//               'EP_BASE_KEYS'
//             ].map(
//               (e) {
//                 return DropdownMenuItem(
//                   child: OnHover(
//                     builder: (isHovered) {
//                       final color =
//                           isHovered ? Colors.teal : Colors.black;
//                       return Text(
//                         '$e',
//                         style: TextStyle(color: color),
//                       );
//                     },
//                   ),
//                   value: e,
//                 );
//               },
//             ).toList(),
//             // value: dropDownValue,
//             onChanged: (value) async {
//               controller.updateSelectMenu(value);
//
//               if (controller.selectMenu == 'Add Form') {
//                 controller.updateSelectedPage(1);
//                 controller.updateSaveSelectedPage(-1);
//               } else if (controller.selectMenu == 'EP_BASE_KEYS') {
//                 final labelName = await CreateLabelRepo().getLabelName(
//                         labelId:
//                             '${getAllFormViewModel?.getAllForm![0]['entries'][0]['label_id']}') ??
//                     '';
//                 controller.updateSelectedPage(-1);
//                 controller.updateSaveSelectedPage(0);
//                 showSelectFormDialog(
//                     controller: controller,
//                     getAllFormController: getAllFormViewModel,
//                     width: width,
//                     context: context,
//                     labelName: labelName,
//                     selectFormIndex: 0,
//                     showSelectFormViewModel: showSelectFormViewModel,
//                     formId:
//                         '${getAllFormViewModel?.getAllForm![0]['_id']}');
//               } else if (controller.selectMenu == 'Field Names') {
//               } else {
//                 showEditFormDialog(
//                     width: width!,
//                     getAllFormController: getAllFormViewModel,
//                     formController: controller,
//                     context: context,
//                     selectFormViewModel: showSelectFormViewModel);
//               }
//             },
//           ),
//         ),
//       ),
//     );
//   },
// )
