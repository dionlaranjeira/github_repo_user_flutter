import 'package:github_repo_user/model/user_details.dart';
import 'package:github_repo_user/services/github_api.dart';

class UserViewModel{
  final GitHubApi _api = GitHubApi();

  UserDetail? userDetail;
  Future<void> getUserInformation(String userLoginId) async {
    final apiResult = await _api.getUserInformation(userLoginId);
    userDetail = UserDetail.fromJson(apiResult);
  }

}