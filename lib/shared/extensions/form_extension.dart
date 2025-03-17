// 📦 Package imports:
import 'package:reactive_forms/reactive_forms.dart';

extension FormGroupExtensions on FormGroup {
  T? getValue<T>(String controlName) {
    final control = this.control(controlName);
    return control.value as T?;
  }

  void setValue<T>(String controlName, T value) {
    final control = this.control(controlName);
    control.value = value;
  }

  void resetForm() {
    reset();
  }
}
