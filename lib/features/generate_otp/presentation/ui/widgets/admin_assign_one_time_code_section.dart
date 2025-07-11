import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni_sphere_admin/shared/widgets/custom_reative_field.dart';
import 'package:uni_sphere_admin/shared/widgets/auth_button.dart';
import 'package:uni_sphere_admin/shared/widgets/spacing.dart';
import 'package:uni_sphere_admin/shared/imports/imports.dart';
import 'package:uni_sphere_admin/common/constant/app_strings.dart';
import 'package:uni_sphere_admin/features/generate_otp/presentation/ui/input_forms/assign_one_time_code_form.dart';
import 'package:uni_sphere_admin/features/generate_otp/presentation/ui/input_forms/assign_one_time_code_input_keys.dart';
import 'package:uni_sphere_admin/shared/states/bloc/info_bloc.dart';
import 'package:uni_sphere_admin/features/generate_otp/presentation/state/bloc/generate_otp_bloc.dart';
import 'package:uni_sphere_admin/features/grade_management/data/param/assign_one_time_code.dart';
import 'package:uni_sphere_admin/core/result_builder/result.dart';
import 'package:uni_sphere_admin/shared/utils/helper/show_error_overlay.dart';

class AdminAssignOneTimeCodeSection extends StatelessWidget {
  final InfoState infoState;
  final GenerateOtpState otpState;
  const AdminAssignOneTimeCodeSection(
      {super.key, required this.infoState, required this.otpState});

  @override
  Widget build(BuildContext context) {
    final studentResult = infoState.unregisteredStudent;
    final isLoadingStudent = studentResult.isLoading();
    final student = studentResult.getDataWhenSuccess();
    final form = AssignOneTimeCodeForm.formGroup;
    final showAssignSection = student != null &&
        form.control(AssignOneTimeCodeInputKeys.studentNumber).value != null &&
        (form.control(AssignOneTimeCodeInputKeys.oneTimeCode).value == null ||
            form.control(AssignOneTimeCodeInputKeys.oneTimeCode).value == '');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomReactiveField(
          controller: AssignOneTimeCodeInputKeys.studentNumber,
          title: AppStrings.enterStudentNumber,
          hintText: AppStrings.enterStudentNumber,
          keyboardType: TextInputType.text,
        ),
        12.verticalSpace,
        AuthButton.primary(
          title: AppStrings.checkStudent,
          isLoading: isLoadingStudent,
          onPressed: () {
            final studentNumber = form
                .control(AssignOneTimeCodeInputKeys.studentNumber)
                .value as String?;
            if (studentNumber == null || studentNumber.isEmpty) {
              showErrorOverlay(context, AppStrings.thisFieldRequired);
              return;
            }
            context.read<InfoBloc>().add(GetUnregisteredStudentsByMajorEvent(
                studentNumber: studentNumber));
            // Clear oneTimeCode field when searching for a new student
            form.control(AssignOneTimeCodeInputKeys.oneTimeCode).reset();
          },
          context: context,
        ),
        20.verticalSpace,
        if (infoState.unregisteredStudent.isError())
          Builder(
            builder: (context) {
              showErrorOverlay(
                  context, infoState.unregisteredStudent.getError());
              return SizedBox.shrink();
            },
          ),
        if (showAssignSection)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${AppStrings.studentName}: ${student.name}',
                  style: context.textTheme.bodyLarge),
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
                  if (student.id.isEmpty) {
                    showErrorOverlay(context, AppStrings.anErrorOccurred);
                    return;
                  }
                  final assign = AssignOneTimeCode(
                    targetRole: TargetRole.student,
                    studentId: student.id,
                    oneTimeCode: code,
                  );
                  context.read<GenerateOtpBloc>().add(
                        AssignOneTimeCodeToStudentEvent(
                            assignOneTimeCode: assign),
                      );
                  // After assignment, clear the form and student
                  AssignOneTimeCodeForm.clear();
                  // Optionally, you can trigger a Bloc event to clear the student from InfoBloc if needed
                  // context.read<InfoBloc>().add(ClearUnregisteredStudentEvent());
                },
                context: context,
              ),
            ],
          ),
      ],
    );
  }
}
