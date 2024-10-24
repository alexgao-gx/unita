import 'package:get/get.dart';
import 'package:unitaapp/common/api/assessment_api.dart';
import 'package:unitaapp/common/models/assessment_model.dart';
import 'package:unitaapp/common/models/assessment_page_model.dart';

enum AssessmentType {
  GUT_HEALTH, // (肠道健康)
  BODY_TYPE, // (体型)
}

class AssessmentService extends GetxService {
  final RxList<AssessmentPageModel> _gutHealthRx = <AssessmentPageModel>[].obs;
  final RxList<AssessmentPageModel> _bodyTypeRx = <AssessmentPageModel>[].obs;

  /// Gut health assessment flow data source
  List<AssessmentPageModel> get gutHealthAssessments => _gutHealthRx;

  /// Body type assessment flow data source
  List<AssessmentPageModel> get bodyTypeAssessments => _bodyTypeRx;

  Future<void> fetchGutHealthAssessment() async {
    _gutHealthRx.value =
        await AssessmentAPI.fetchAssessmentList(AssessmentType.GUT_HEALTH);
  }

  Future<void> fetchBodyTypeAssessment() async {
    _bodyTypeRx.value =
    await AssessmentAPI.fetchAssessmentList(AssessmentType.BODY_TYPE);
  }
}
