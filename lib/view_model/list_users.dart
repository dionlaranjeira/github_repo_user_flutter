import 'package:github_repo_user/model/user.dart';
import 'package:github_repo_user/services/github_api.dart';

class ListUsersViewModel {
  final GitHubApi _api = GitHubApi();

  List<User>? users;
  Future<void> getRandomUsers() async {
    final apiResult = await _api.getRandomUsers();

    List<User> listUsers = [];

    for (var user in apiResult) {
      User u = User.fromJson(user);
      listUsers.add(u);
    }
    users = listUsers;
  }
}