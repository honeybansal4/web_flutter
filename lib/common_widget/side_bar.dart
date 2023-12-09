import 'dart:developer';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_demo_satish/common_widget/app_colors.dart';
import 'package:web_demo_satish/common_widget/common_snackbar.dart';
import 'package:web_demo_satish/common_widget/drop_down.dart';
import 'package:web_demo_satish/common_widget/text_field.dart';
import 'package:web_demo_satish/model/Apis/api_response.dart';
import 'package:web_demo_satish/view_model/get_all_form_view_model.dart';
import 'package:web_demo_satish/view_model/set_form_view_model.dart';
import 'package:web_demo_satish/view_model/show_form_view_model.dart';

Container sideBar(
    {double? width,
    SetFormViewModel? formController,
    ShowSelectFormViewModel? showSelectFormViewModel,
    GetAllFormViewModel? getAllFormController}) {
  return Container(
    width: width! * 0.14,
    height: Get.height,
    decoration: const BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Color(0xffD9D9D9),
          blurRadius: 2,
          spreadRadius: 2,
          offset: Offset(0, 1),
        )
      ],
    ),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (formController?.selectTab == 0)
            InkWell(
              onTap: () async {
                await getAllFormController?.getAllFormViewModel(loading: false);
                formController?.updateSelectAllPage(0);
                formController?.updateSelectedPage(-1);
              },
              child: Container(
                height: 55,
                padding: EdgeInsets.only(
                  left: width * 0.01,
                ),
                margin: EdgeInsets.only(bottom: width * 0.01),
                width: double.infinity,
                color: formController?.selectAllPage == 0
                    ? Colors.grey.shade300
                    : Colors.transparent,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Application Forms',
                    style: TextStyle(
                      fontWeight: formController?.selectAllPage == 0
                          ? FontWeight.w600
                          : FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),

          /// FORM ACTION LIST  EDIT HOME LIKE
          if (formController?.selectTab == 0)
            ListView.builder(
              itemCount: formController!.pages.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, mainIndex) {
                return InkWell(
                  onTap: () async {
                    formController.updateSelectedPage(mainIndex);
                    formController.updateSaveSelectedPage(-1);
                    formController.updateSelectAllPage(-1);

                    formController.clearForm();
                    showSelectFormViewModel?.getSelectForm.clear();
                    showSelectFormViewModel?.getSelectSaveForm.clear();

                    if (mainIndex == 1) {
                      formController.updateSaveCall(true);
                      await formController.callAllApi();
                      showAddFormDialog(
                          width: width,
                          context: context,
                          selectFormViewModel: showSelectFormViewModel,
                          formController: formController,
                          getAllFormController: getAllFormController);
                    }

                    if (mainIndex == 2) {
                      showEditFormDialog(
                          width: width,
                          context: context,
                          selectFormViewModel: showSelectFormViewModel,
                          formController: formController,
                          getAllFormController: getAllFormController);
                    }
                  },
                  child: Container(
                    height: 55,
                    padding: EdgeInsets.only(
                      left: width * 0.01,
                    ),
                    margin: EdgeInsets.only(bottom: width * 0.01),
                    width: double.infinity,
                    color: formController.pageSelected == mainIndex
                        ? Colors.grey.shade300
                        : Colors.transparent,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        formController.pages[mainIndex],
                        style: TextStyle(
                          fontWeight: formController.pageSelected == mainIndex
                              ? FontWeight.w600
                              : FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),

          /// SAVE FORM LIST
          ListView.builder(
            itemCount: getAllFormController!.getAllForm!.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              try {
                return getAllFormController.getAllForm![index]['menuType']
                                .toString()
                                .toLowerCase() ==
                            formController
                                ?.navigationItem[formController.selectTab]
                                .toString()
                                .toLowerCase() &&
                        formController?.selectTab != 0
                    ? InkWell(
                        onTap: () async {
                          showSelectFormViewModel?.updateLoaderValue(true);
                          formController?.updateSaveSelectedPage(index);
                          formController?.updateSelectedPage(-1);
                          formController?.updateSelectAllPage(-1);
                          clearSearchFormValue(showSelectFormViewModel!);

                          await showSelectFormViewModel
                              ?.showSelectFormViewModel(
                                  formId: getAllFormController
                                      .getAllForm![index]['_id'])
                              .then((value) async {
                            await showSelectFormViewModel.isIdFormViewModel(
                              id: '${showSelectFormViewModel.getSelectForm['_id']}',
                            );
                          });

                          try {
                            final getLabelName = showSelectFormViewModel
                                ?.getSelectForm['entries'][0]['label'];
                            formController?.clearForm();
                            showSelectFormDialog(
                                controller: formController,
                                getAllFormController: getAllFormController,
                                width: width,
                                context: context,
                                labelName: getLabelName,
                                selectFormIndex: index,
                                showSelectFormViewModel:
                                    showSelectFormViewModel,
                                formId:
                                    '${getAllFormController.getAllForm![index]['_id']}');
                          } catch (e) {
                            catchErrorOpenForm(
                                context, showSelectFormViewModel!);

                            print('------ERROR----$e');
                          }
                        },
                        child: Container(
                          height: 55,
                          padding: EdgeInsets.only(
                            left: width * 0.01,
                          ),
                          width: double.infinity,
                          margin: EdgeInsets.only(bottom: width * 0.01),
                          color: formController?.savePageSelected == index
                              ? Colors.grey.shade300
                              : Colors.transparent,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              getAllFormController.getAllForm![index]
                                          ['description']
                                      .toString()
                                      .isNotEmpty
                                  ? getAllFormController.getAllForm![index]
                                      ['description']
                                  : 'NAN',
                              style: TextStyle(
                                fontWeight:
                                    formController?.savePageSelected == index
                                        ? FontWeight.w600
                                        : FontWeight.w500,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      )
                    : getAllFormController.getAllForm![index]['menuType']
                                    .toString()
                                    .toLowerCase() ==
                                'Application'.toLowerCase() &&
                            formController?.selectTab == 0
                        ? InkWell(
                            onTap: () async {
                              showSelectFormViewModel?.updateLoaderValue(true);
                              formController?.updateSaveSelectedPage(index);
                              formController?.updateSelectedPage(-1);
                              formController?.updateSelectAllPage(-1);
                              clearSearchFormValue(showSelectFormViewModel!);

                              await showSelectFormViewModel
                                  ?.showSelectFormViewModel(
                                      formId: getAllFormController
                                          .getAllForm![index]['_id'])
                                  .then((value) async {
                                await showSelectFormViewModel.isIdFormViewModel(
                                  id: '${showSelectFormViewModel.getSelectForm['_id']}',
                                );
                              });
                              try {
                                final getLabelName = showSelectFormViewModel
                                    ?.getSelectForm['entries'][0]['label'];
                                formController?.clearForm();
                                showSelectFormDialog(
                                    controller: formController,
                                    getAllFormController: getAllFormController,
                                    width: width,
                                    context: context,
                                    labelName: getLabelName,
                                    selectFormIndex: index,
                                    showSelectFormViewModel:
                                        showSelectFormViewModel,
                                    formId:
                                        '${getAllFormController.getAllForm![index]['_id']}');
                              } catch (e) {
                                catchErrorOpenForm(
                                    context, showSelectFormViewModel!);

                                print('------ERROR App----$e');
                              }
                            },
                            child: Container(
                              height: 55,
                              padding: EdgeInsets.only(
                                left: width * 0.01,
                              ),
                              width: double.infinity,
                              margin: EdgeInsets.only(bottom: width * 0.01),
                              color: formController?.savePageSelected == index
                                  ? Colors.grey.shade300
                                  : Colors.transparent,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  getAllFormController.getAllForm![index]
                                      ['description'],
                                  style: TextStyle(
                                    fontWeight:
                                        formController?.savePageSelected ==
                                                index
                                            ? FontWeight.w600
                                            : FontWeight.w500,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : SizedBox();
              } catch (e) {
                return Text('ERROR 404');
              }
            },
          ),
        ],
      ),
    ),
  );
}

/// ADD FORM DIALOG
showAddFormDialog({
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
                            formController!.updateSaveCall(false);

                            if (formController.titleController.text.isNotEmpty &&
                                formController.desController.text.isNotEmpty &&
                                formController.selectTypeOfForm.isNotEmpty &&
                                formController
                                    .selectedOrganization.isNotEmpty &&
                                formController.selectedRoles.isNotEmpty &&
                                formController.selectedGroup.isNotEmpty) {
                              /// ADD NEW FORM FIELD
                              // formController.setGroupName();

                              setStat(() {});
                              Navigator.pop(context);
                            } else if (formController
                                .titleController.text.isEmpty) {
                              CommonSnackBar.getWarningSnackBar(
                                  context, 'Please Enter Form Name!');
                            } else if (formController
                                .desController.text.isEmpty) {
                              CommonSnackBar.getWarningSnackBar(
                                  context, 'Please Enter Form Description!');
                            } else if (formController
                                .selectTypeOfForm.isEmpty) {
                              CommonSnackBar.getWarningSnackBar(
                                  context, 'Please Select Form Type!');
                            } else if (formController.selectedRoles.isEmpty) {
                              CommonSnackBar.getWarningSnackBar(
                                  context, 'Please Select Role!');
                            } else if (formController
                                .selectedOrganization.isEmpty) {
                              CommonSnackBar.getWarningSnackBar(
                                  context, 'Please Select Organization!');
                            } else if (formController
                                .selectFormStatus.isEmpty) {
                              CommonSnackBar.getWarningSnackBar(
                                  context, 'Please Select Status!');
                            } else {
                              CommonSnackBar.getFailedSnackBar(
                                  context, 'Something went wrong!');
                            }
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
                            formController!.updateSaveCall(false);

                            formController.desController.clear();
                            formController.titleController.clear();
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

/// SHOW SELECT EDIT FORM DIALOG
void showEditFormDialog({
  required double width,
  BuildContext? context,
  GetAllFormViewModel? getAllFormController,
  SetFormViewModel? formController,
  ShowSelectFormViewModel? selectFormViewModel,
}) {
  TextEditingController searchController = TextEditingController();
  showDialog(
    barrierDismissible: false,
    context: context!,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setStat) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 100),
                padding: EdgeInsets.all(20),
                width: 400,
                // height: 600,
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Please Select Form',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            IconButton(
                              splashRadius: 20,
                              onPressed: () {
                                formController?.updateSaveSelectedPage(-1);
                                formController?.updateSelectedPage(0);
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.clear),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(),
                        SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: searchController,
                          onChanged: (val) {
                            setStat(() {});
                          },
                          decoration: InputDecoration(
                              hintText: 'Search Form',
                              border: const OutlineInputBorder(),
                              prefixIcon: Icon(Icons.search)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(),
                        SizedBox(
                          height: 20,
                        ),
                        ListView.builder(
                          itemCount: getAllFormController!.getAllForm!.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return getAllFormController.getAllForm![index]
                                        ['name']
                                    .toString()
                                    .toLowerCase()
                                    .contains(searchController.text
                                        .toString()
                                        .toLowerCase()
                                        .toString())
                                ? InkWell(
                                    onTap: () async {
                                      formController?.updateSelectedPage(2);

                                      Get.back();

                                      await selectFormViewModel
                                          ?.showSelectFormViewModel(
                                            loading: true,
                                            formId:
                                                '${getAllFormController.getAllForm![index]['_id']}',
                                          )
                                          .then(
                                            (value) => selectFormViewModel
                                                .getFormSaveDataViewModel(
                                              labelId: selectFormViewModel
                                                      .getSelectForm['entries']
                                                  [0]['label_id'],
                                              id: selectFormViewModel
                                                  .getSelectForm['_id'],
                                            ),
                                          );
                                    },
                                    child: Container(
                                      height: 60,
                                      padding: EdgeInsets.only(
                                        left: width * 0.01,
                                      ),
                                      margin:
                                          EdgeInsets.only(bottom: width * 0.01),
                                      width: 100,
                                      decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          border: Border.all()),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          '${getAllFormController.getAllForm![index]['name']}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : SizedBox();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    },
  );
}

/// SELECT SHOW FORM DIALOG
showSelectFormDialog(
    {double? width,
    SetFormViewModel? controller,
    ShowSelectFormViewModel? showSelectFormViewModel,
    GetAllFormViewModel? getAllFormController,
    BuildContext? context,
    String? labelName,
    int? selectFormIndex,
    String? formId}) {
  return showDialog(
    barrierDismissible: false,
    context: context!,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setStat) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 100),
                padding: EdgeInsets.all(20),
                width: 500,
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text('Please Select Form',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () async {
                                showSelectFormViewModel
                                    ?.updateLoaderValue(false);

                                controller?.updateShowForm(false);

                                showSelectFormViewModel
                                    ?.updateSelectedSaveData(-1);
                                showSelectFormViewModel?.updateSave(false);
                                Get.back();

                                await showSelectFormViewModel
                                    ?.showSelectFormViewModel(
                                        loading: true,
                                        formId: getAllFormController
                                                ?.getAllForm![selectFormIndex!]
                                            ['_id'])
                                    .then((value) => showSelectFormViewModel
                                            .getFormSaveDataViewModel(
                                          labelId: showSelectFormViewModel
                                                  .getSelectForm['entries'][0]
                                              ['label_id'],
                                          id: showSelectFormViewModel
                                              .getSelectForm['_id'],
                                          labelValue: showSelectFormViewModel
                                                  .getSelectForm['entries'][0]
                                              ['label'],
                                        ));
                              },
                              child: Container(
                                padding: EdgeInsets.all(
                                  5,
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border.all()),
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Icon(Icons.add)),
                              ),
                            ),
                            Spacer(),
                            IconButton(
                              splashRadius: 20,
                              onPressed: () async {
                                showSelectFormViewModel
                                    ?.updateLoaderValue(false);

                                controller?.updateShowForm(false);

                                showSelectFormViewModel
                                    ?.updateSelectedSaveData(-1);
                                showSelectFormViewModel?.updateSave(false);
                                Get.back();

                                await showSelectFormViewModel
                                    ?.showSelectFormViewModel(
                                        loading: true,
                                        formId: getAllFormController
                                                ?.getAllForm![selectFormIndex!]
                                            ['_id'])
                                    .then((value) => showSelectFormViewModel.getFormSaveDataViewModel(
                                        labelId: showSelectFormViewModel
                                                .getSelectForm['entries'][0]
                                            ['label_id'],
                                        id: showSelectFormViewModel
                                            .getSelectForm['_id'],
                                        labelValue: showSelectFormViewModel
                                            .getSelectForm['entries'][0]['label']));
                              },
                              icon: Icon(Icons.clear),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            GetBuilder<ShowSelectFormViewModel>(
                              builder: (controller) {
                                if (controller.searchIdFormApiResponse.status ==
                                    Status.LOADING) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                if (controller.searchIdFormApiResponse.status ==
                                    Status.COMPLETE) {
                                  return Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey.shade500)),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    alignment: Alignment.center,
                                    child: Theme(
                                      data: ThemeData(
                                        splashColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                          style: const TextStyle(
                                              color: Colors.black),
                                          dropdownColor: Colors.white,
                                          hint: controller.isIdDropDownValue ==
                                                      null ||
                                                  controller
                                                          .isIdDropDownValue ==
                                                      'null' ||
                                                  controller
                                                      .isIdDropDownValue.isEmpty
                                              ? Text('Select Option')
                                              : Text(
                                                  controller.isIdDropDownValue[
                                                          'label']
                                                      .toString(),
                                                  style: TextStyle(
                                                      color:
                                                          AppColor.mainColor),
                                                ),

                                          items:
                                              controller.isIdFormData.map((e) {
                                            return DropdownMenuItem(
                                              child: OnHover(
                                                builder: (isHovered) {
                                                  final color = isHovered
                                                      ? AppColor.mainColor
                                                      : Colors.black;
                                                  return Text(
                                                    controller.isIdFormData
                                                            .isEmpty
                                                        ? 'No Result Found'
                                                        : '${e['label']}',
                                                    style:
                                                        TextStyle(color: color),
                                                  );
                                                },
                                              ),
                                              value: e,
                                            );
                                          }).toList(),
                                          // value: dropDownValue,
                                          onChanged: (val) {
                                            if (controller
                                                .isIdFormData.isNotEmpty) {
                                              controller
                                                  .updateSearchFormValue(val!);
                                              print(
                                                  '----SELECT SAVE DATA--${controller.isIdDropDownValue}');
                                            } else {
                                              print('-----NO DATA FOUND-----');
                                            }
                                            setStat(() {});
                                          },
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return Center(
                                    child: Text('Something went wrong'),
                                  );
                                }
                              },
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: TextField(
                                controller: controller?.searchController,
                                onChanged: (val) {
                                  // if (val.isNotEmpty) {
                                  //   controller?.updateShowForm(false);
                                  // } else {
                                  //   controller?.updateShowForm(true);
                                  // }
                                  controller?.updateSearch(val);
                                  setStat(() {});
                                },
                                decoration: InputDecoration(
                                  hintText: 'Search Form',
                                  border: const OutlineInputBorder(),
                                  prefixIcon: IconButton(
                                    splashRadius: 20,
                                    onPressed: () async {
                                      if (showSelectFormViewModel!
                                          .isIdDropDownValue.isNotEmpty) {
                                        // controller?.updateShowForm(true);
                                        setStat(() {});
                                        await showSelectFormViewModel
                                            .searchFormViewModel(
                                                // isLoading: false,
                                                searchText: controller
                                                    ?.searchPage
                                                    .toLowerCase(),
                                                id: showSelectFormViewModel
                                                        .isIdDropDownValue[
                                                    'label_id'],
                                                name: showSelectFormViewModel
                                                    .getSelectForm['name']);
                                      } else {
                                        CommonSnackBar.getWarningSnackBar(
                                            context, 'Select Name First');
                                      }
                                    },
                                    icon: Icon(Icons.search),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(),
                        SizedBox(
                          height: 20,
                        ),
                        GetBuilder<ShowSelectFormViewModel>(
                          builder: (controller) {
                            if (controller.searchFormApiResponse.status ==
                                Status.LOADING) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (controller.searchFormApiResponse.status ==
                                Status.COMPLETE) {
                              print(
                                  '---------------${controller.searchFormData}');
                              try {
                                return ListView.builder(
                                  itemCount: controller.searchFormData.length,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return InkWell(
                                      onTap: () async {
                                        print(
                                            '--------------------${getAllFormController?.getAllForm![selectFormIndex!]['_id']}');
                                        showSelectFormViewModel
                                            ?.updateLoaderValue(false);

                                        showSelectFormViewModel
                                            ?.updateSelectedSaveData(index);

                                        showSelectFormViewModel
                                            ?.updateSave(true);
                                        showSelectFormViewModel
                                            ?.updateSearchLabel(controller
                                                .searchFormData[index]['value']
                                                .toString());

                                        Get.back();

                                        await showSelectFormViewModel
                                            ?.showSelectFormViewModel(
                                                loading: true,
                                                formId: getAllFormController
                                                        ?.getAllForm![
                                                    selectFormIndex!]['_id'])
                                            .then(
                                              (value) => controller
                                                  .getFormSaveDataViewModel(
                                                      labelId: controller
                                                              .searchFormData[
                                                          index]['label_id'],
                                                      id: controller
                                                          .getSelectForm['_id'],
                                                      labelValue: controller
                                                              .searchFormData[
                                                          index]['value'])
                                                  .then((value) {
                                                String formIndex =
                                                    '${controller.getSelectSaveForm.indexWhere((element) => element['payload'].any((element1) => element1['label'] == controller.isIdDropDownValue['label'] && element1['value'] == controller.searchFormData[index]['value']))}';

                                                if (controller.getSelectSaveForm
                                                        .length ==
                                                    1) {
                                                  controller
                                                      .updateSelectedSaveData(
                                                          0);
                                                } else if (controller
                                                        .getSelectSaveForm
                                                        .length >
                                                    1) {
                                                  controller
                                                      .updateSelectedSaveData(
                                                          int.parse(formIndex));
                                                } else {
                                                  print('-----NO DATA FOUND');
                                                }
                                              }),
                                            );
                                        print(
                                            '-----SELECT SAVE FORM----${controller.selectedSaveForm}');
                                      },
                                      child: Container(
                                        height: 55,
                                        padding: EdgeInsets.only(
                                          left: width! * 0.01,
                                        ),
                                        margin: EdgeInsets.only(
                                            bottom: width * 0.01),
                                        width: 100,
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade300,
                                            border: Border.all()),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            controller.searchFormData[index]
                                                    ['value']
                                                .toString(),
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              } catch (e) {
                                return Text('$e');
                              }
                            } else {
                              return Center(
                                child: Text(''),
                              );
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    },
  ).whenComplete(() {
    controller?.clearSearch();
  });
}

/// CATCH ERROR WHILE SELECT FORMS
catchErrorOpenForm(
    BuildContext context, ShowSelectFormViewModel showSelectFormViewModel) {
  showSelectFormViewModel.updateLoaderValue(false);

  if (showSelectFormViewModel.getSelectForm.containsKey('ok') == true) {
    if (showSelectFormViewModel.getSelectForm['ok'] == false) {
      CommonSnackBar.getWarningSnackBar(
          context, '${showSelectFormViewModel.getSelectForm['message']}');
    }
  } else if ((showSelectFormViewModel.getSelectForm['entries'] as List)
      .isEmpty) {
    CommonSnackBar.getWarningSnackBar(context, 'No Label Found');
  } else {
    CommonSnackBar.getWarningSnackBar(context, 'Something went wrong');
  }
}

/// CLEAR SERCH FORM VALUE WHILE OPEN OTHER FORM
clearSearchFormValue(ShowSelectFormViewModel showSelectFormViewModel) {
  showSelectFormViewModel.isIdFormData = [];
  showSelectFormViewModel.searchFormData = [];
  showSelectFormViewModel.isIdDropDownValue = {};
}
