import 'package:github_repo_user/model/user.dart';
import 'package:github_repo_user/model/user_details.dart';
import 'package:github_repo_user/services/github_api.dart';

class ListUsersViewModel {
  final GitHubApi _api = GitHubApi();

  List<User>? users;
  Future<void> getRandomUsers() async {
    print("Chamado--> getRandomUsers");
    users?.clear();
    final apiResult = await _api.getRandomUsers();

    List<User> listUsers = [];

    for (var user in apiResult) {
      User u = User.fromJson(user);
      listUsers.add(u);
    }
    users = listUsers;
  }

  UserDetail? userDetail;
  Future<void> getUserInformation(String userLoginId) async {
    print("Chamado--> getUserInformations");
    print("_query-->" + userLoginId);
    final apiResult = await _api.getUserInformation(userLoginId);
    print("apiResult-->" + apiResult.toString());
    userDetail = UserDetail.fromJson(apiResult);
    print("useDetail-->" + userDetail!.id.toString());
  }

}