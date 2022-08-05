import 'package:flutter_test/flutter_test.dart';
import 'package:github_repo_user/model/user.dart';
import 'package:github_repo_user/services/github_api.dart';

void main(){

  GitHubApi api = GitHubApi();

  test('Should call api.getRandomUsers and return List<Map<String, dynamic>>', () async {
    final List<Map<String, dynamic>> response = await api.getRandomUsers();
  });

  test("Shold return an List<User>", () async{

    final response  = await api.getRandomUsers();

    List<User> listUsers = [];

    for(var user in response){
      User u = User.fromJson(user);
      listUsers.add(u);
    }

  });

}