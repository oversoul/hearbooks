import 'package:hearbooks/core/constants/enums.dart';
import 'package:hearbooks/core/viewmodels/base_model.dart';

class HomeModel extends BaseModel {

  Future getPost(userId) async {
    setState(ViewState.Idle);
  }
}