import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:github_repo_user/model/user.dart';
import 'package:github_repo_user/model/user_details.dart';
import 'package:github_repo_user/services/github_api.dart';

class ListUsersViewModel {
  final GitHubApi _api = GitHubApi();

  List<User>? users;
  Future<void> getRandomUsers() async {
    users?.clear();
    final apiResult = await _api.getRandomUsers();

    List<User> listUsers = [];
    List<Contact> contacts = await _init();

    for (var user in apiResult) {
      User u = User.fromJson(user);
      u.contactId = _verifyPhoneContacts(contacts, u.login!);
      listUsers.add(u);
    }
    users = listUsers;
  }

  Future<List<Contact>> _init() async {
    if (await FlutterContacts.requestPermission(readonly: true)) {
      List<Contact> contacts = await FlutterContacts.getContacts();
      return contacts;
    }
    return [];
  }

  String? _verifyPhoneContacts(List<Contact> contacts, String name) {
    if (contacts.isEmpty) {
      return null;
    }
    var found;
    for (Contact contact in contacts) {
      if (contact.name.first.contains(name) || contact.name.last.contains(name)) {
        found = contact.id;
        break;
      }
    }
    return found;
  }

  UserDetail? userDetail;
  Future<void> getUserInformation(String userLoginId) async {
    final apiResult = await _api.getUserInformation(userLoginId);
    userDetail = UserDetail.fromJson(apiResult);
  }

}