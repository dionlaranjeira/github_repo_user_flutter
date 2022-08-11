import 'package:github_repo_user/model/use_repositorys.dart';
import 'package:github_repo_user/services/github_api.dart';

class ListRepositorysViewModel {
  final GitHubApi _api = GitHubApi();

  List<UseRepositorys>? repos;
  Future<void> getUserRepositories(String userLoginId) async {
    final apiResult = await _api.getUserRepositories(userLoginId);

    List<UseRepositorys> listRepos = [];

    for (var repo in apiResult) {
      UseRepositorys r = UseRepositorys.fromJson(repo);
      listRepos.add(r);
    }
    repos = listRepos;
  }
}
