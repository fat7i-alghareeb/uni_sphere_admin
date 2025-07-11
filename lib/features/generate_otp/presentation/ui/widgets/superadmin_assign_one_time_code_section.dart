import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni_sphere_admin/shared/widgets/custom_picker.dart';
import 'package:uni_sphere_admin/shared/widgets/custom_reative_field.dart';
import 'package:uni_sphere_admin/shared/widgets/auth_button.dart';
import 'package:uni_sphere_admin/shared/widgets/spacing.dart';
import 'package:uni_sphere_admin/shared/imports/imports.dart';
import 'package:uni_sphere_admin/common/constant/app_strings.dart';
import 'package:uni_sphere_admin/features/generate_otp/presentation/ui/input_forms/assign_one_time_code_form.dart';
import 'package:uni_sphere_admin/features/generate_otp/presentation/ui/input_forms/assign_one_time_code_input_keys.dart';
import 'package:uni_sphere_admin/shared/entities/drop_down_data.dart';
import 'package:uni_sphere_admin/shared/entities/admin.dart';
import 'package:uni_sphere_admin/shared/entities/professor.dart';
import 'package:uni_sphere_admin/features/generate_otp/presentation/state/bloc/generate_otp_bloc.dart';
import 'package:uni_sphere_admin/features/grade_management/data/param/assign_one_time_code.dart';
import 'package:uni_sphere_admin/core/result_builder/result.dart';
import 'package:uni_sphere_admin/shared/states/bloc/info_bloc.dart';
import 'package:uni_sphere_admin/shared/utils/helper/show_error_overlay.dart';

class SuperAdminAssignOneTimeCodeSection extends StatelessWidget {
  final InfoState infoState;
  final GenerateOtpState otpState;
  const SuperAdminAssignOneTimeCodeSection(
      {super.key, required this.infoState, required this.otpState});

  @override
  Widget build(BuildContext context) {
    final form = AssignOneTimeCodeForm.formGroup;
    final targetType =
        form.control(AssignOneTimeCodeInputKeys.targetType).value as String?;
    final adminList = infoState.admins.getDataWhenSuccess() ?? [];
    final professorList = infoState.professors.getDataWhenSuccess() ?? [];
    final isLoadingAdmins = infoState.admins.isLoading();
    final isLoadingProfessors = infoState.professors.isLoading();
    final selectedAdminId = form
        .control(AssignOneTimeCodeInputKeys.selectedAdminId)
        .value as String?;
    final selectedProfessorId = form
        .control(AssignOneTimeCodeInputKeys.selectedProfessorId)
        .value as String?;
    final showAssignSection = (targetType == 'admin' &&
            selectedAdminId != null &&
            selectedAdminId.isNotEmpty) ||
        (targetType == 'professor' &&
            selectedProfessorId != null &&
            selectedProfessorId.isNotEmpty);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomPickerField(
          data: [
            DropDownData(id: 'admin', name: AppStrings.admin),
            DropDownData(id: 'professor', name: AppStrings.professor),
          ],
          hintText: AppStrings.selectRole,
          title: AppStrings.selectRole,
          onSelect: (name, id) {
            if (id == null) {
              AssignOneTimeCodeForm.clear();
              return;
            }
            form.control(AssignOneTimeCodeInputKeys.targetType).value = id;
            form.control(AssignOneTimeCodeInputKeys.selectedAdminId).reset();
            form
                .control(AssignOneTimeCodeInputKeys.selectedProfessorId)
                .reset();
            form.control(AssignOneTimeCodeInputKeys.oneTimeCode).reset();
            if (id == 'admin') {
              context
                  .read<InfoBloc>()
                  .add(GetUnregisteredAdminsByFacultyEvent());
            } else if (id == 'professor') {
              context.read<InfoBloc>().add(GetProfessorsEvent());
            }
          },
          selectedItem: targetType == null
              ? null
              : DropDownData(
                  id: targetType,
                  name: targetType == 'admin'
                      ? AppStrings.admin
                      : AppStrings.professor,
                ),
          enableSearch: false,
          width: double.infinity,
          isLoading: false,
          readOnly: false,
        ),
        16.verticalSpace,
        if (targetType == 'admin')
          isLoadingAdmins
              ? Center(child: CircularProgressIndicator())
              : CustomPickerField(
                  data: adminList
                      .map((a) => DropDownData(id: a.id, name: a.name))
                      .toList(),
                  hintText: AppStrings.selectAdmin,
                  title: AppStrings.selectAdmin,
                  onSelect: (name, id) {
                    if (id == null) {
                      form
                          .control(AssignOneTimeCodeInputKeys.selectedAdminId)
                          .reset();
                      form
                          .control(AssignOneTimeCodeInputKeys.oneTimeCode)
                          .reset();
                      return;
                    }
                    form
                        .control(AssignOneTimeCodeInputKeys.selectedAdminId)
                        .value = id;
                  },
                  selectedItem:
                      selectedAdminId == null || selectedAdminId.isEmpty
                          ? null
                          : DropDownData(
                              id: selectedAdminId,
                              name: adminList
                                  .firstWhere(
                                    (a) => a.id == selectedAdminId,
                                    orElse: () => Admin(id: '', name: ''),
                                  )
                                  .name,
                            ),
                  enableSearch: true,
                  width: double.infinity,
                  isLoading: false,
                  readOnly: false,
                ),
        if (targetType == 'professor')
          isLoadingProfessors
              ? Center(child: CircularProgressIndicator())
              : CustomPickerField(
                  data: professorList
                      .map((p) => DropDownData(id: p.id, name: p.name))
                      .toList(),
                  hintText: AppStrings.selectProfessor,
                  title: AppStrings.selectProfessor,
                  onSelect: (name, id) {
                    if (id == null) {
                      form
                          .control(
                              AssignOneTimeCodeInputKeys.selectedProfessorId)
                          .reset();
                      form
                          .control(AssignOneTimeCodeInputKeys.oneTimeCode)
                          .reset();
                      return;
                    }
                    form
                        .control(AssignOneTimeCodeInputKeys.selectedProfessorId)
                        .value = id;
                  },
                  selectedItem:
                      selectedProfessorId == null || selectedProfessorId.isEmpty
                          ? null
                          : DropDownData(
                              id: selectedProfessorId,
                              name: professorList
                                  .firstWhere(
                                    (p) => p.id == selectedProfessorId,
                                    orElse: () => Professor(id: '', name: ''),
                                  )
                                  .name,
                            ),
                  enableSearch: true,
                  width: double.infinity,
                  isLoading: false,
                  readOnly: false,
                ),
        16.verticalSpace,
        if (showAssignSection)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (targetType == 'admin')
                Text(
                  '${AppStrings.userName}: ${adminList.firstWhere((a) => a.id == selectedAdminId, orElse: () => Admin(id: '', name: '')).name}',
                  style: context.textTheme.bodyLarge,
                ),
              if (targetType == 'professor')
                Text(
                  '${AppStrings.userName}: ${professorList.firstWhere((p) => p.id == selectedProfessorId, orElse: () => Professor(id: '', name: '')).name}',
                  style: context.textTheme.bodyLarge,
                ),
              16.verticalSpace,
              CustomReactiveField(
                controller: AssignOneTimeCodeInputKeys.oneTimeCode,
                title: AppStrings.enterOneTimeCode,
                hintText: AppStrings.enterOneTimeCode,
                keyboardType: TextInputType.text,
              ),
              16.verticalSpace,
              AuthButton.primary(
                title: AppStrings.generateOneTimeCode,
                isLoading: otpState.result.isLoading(),
                onPressed: () {
                  final codeStr = form
                      .control(AssignOneTimeCodeInputKeys.oneTimeCode)
                      .value as String?;
                  if (codeStr == null || codeStr.isEmpty) {
                    showErrorOverlay(context, AppStrings.thisFieldRequired);
                    return;
                  }
                  final code = int.tryParse(codeStr);
                  if (code == null) {
                    showErrorOverlay(context, AppStrings.thisFieldRequired);
                    return;
                  }
                  if (targetType == 'admin') {
                    final adminId = selectedAdminId;
                    if (adminId == null || adminId.isEmpty) {
                      showErrorOverlay(context, AppStrings.anErrorOccurred);
                      return;
                    }
                    final assign = AssignOneTimeCode(
                      targetRole: TargetRole.admin,
                      adminId: adminId,
                      oneTimeCode: code,
                    );
                    context.read<GenerateOtpBloc>().add(
                          AssignOneTimeCodeGeneralEvent(
                              assignOneTimeCode: assign),
                        );
                  } else if (targetType == 'professor') {
                    final professorId = selectedProfessorId;
                    if (professorId == null || professorId.isEmpty) {
                      showErrorOverlay(context, AppStrings.anErrorOccurred);
                      return;
                    }
                    final assign = AssignOneTimeCode(
                      targetRole: TargetRole.professor,
                      professorId: professorId,
                      oneTimeCode: code,
                    );
                    context.read<GenerateOtpBloc>().add(
                          AssignOneTimeCodeGeneralEvent(
                              assignOneTimeCode: assign),
                        );
                  }
                },
                context: context,
              ),
            ],
          ),
      ],
    );
  }
}
