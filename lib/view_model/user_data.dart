import 'package:github_repo_user/model/user.dart';
import 'package:github_repo_user/services/github_api.dart';

class UserViewModel{
  final GitHubApi _api = GitHubApi();

  User? user;
  Future<void> getUserInformation(String userLoginId) async {
    final apiResult = await _api.getUserInformation(userLoginId);
    user = User.fromJson(apiResult);
  }

}