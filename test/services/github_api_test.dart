import 'package:flutter_test/flutter_test.dart';
import 'package:github_repo_user/services/github_api.dart';

void main(){

  GitHubApi api = GitHubApi();

  test('Should call api.getRandomUsers and return List<Map<String, dynamic>>', () async {
    final List<Map<String, dynamic>> response = await api.getRandomUsers();
  });

}