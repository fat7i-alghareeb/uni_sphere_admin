import 'package:reactive_forms/reactive_forms.dart';
import 'announcement_creation_input_keys.dart';

class MajorAnnouncementForm {
  static final formGroup = FormGroup({
    AnnouncementCreationInputKeys.subjectId: FormControl<String>(
      validators: [Validators.required],
    ),
    AnnouncementCreationInputKeys.titleEn: FormControl<String>(
      validators: [Validators.required],
    ),
    AnnouncementCreationInputKeys.titleAr: FormControl<String>(
      validators: [Validators.required],
    ),
    AnnouncementCreationInputKeys.contentEn: FormControl<String>(
      validators: [Validators.required],
    ),
    AnnouncementCreationInputKeys.contentAr: FormControl<String>(
      validators: [Validators.required],
    ),
  });

  static void clear() {
    formGroup.reset();
  }
}
