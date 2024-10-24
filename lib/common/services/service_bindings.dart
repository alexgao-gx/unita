import 'package:get/get.dart';
import 'package:unitaapp/common/services/assessment_service.dart';


class ServiceBindings extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut<AssessmentService>(() => AssessmentService());
  }
}

