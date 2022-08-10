import 'package:github_repo_user/model/repository.dart';
import 'package:github_repo_user/services/github_api.dart';

class ListRepositorysViewModel {
  final GitHubApi _api = GitHubApi();

  List<Repository>? repos;
  Future<void> getUserRepositories(String userLoginId) async {
    final apiResult = await _api.getUserRepositories(userLoginId);

    List<Repository> listRepos = [];

    for (var repo in apiResult) {
      Repository r = Repository.fromJson(repo);
      listRepos.add(r);
    }
    repos = listRepos;
  }
}
