import 'package:github_repo_user/util/colors_languages.dart';

void main(){

  Map<String, dynamic> colors = ColorsLanguage.colors as Map<String, dynamic>;

  colors.forEach((key, value) {
    if(key == "java"){
    print("key-->" + key);
    print("Value-->" + value["color"]);}
  });

}