import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:foodie/enums/auth_mode.dart';
import 'package:foodie/models/user_info_model.dart';
import 'package:foodie/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
class UserScopedModel extends Model {
  List<User> _users=[];
  List<UserInfo> _usersInfo=[];
  User _authenticatedUser;
  UserInfo _authenticatedUserInfo;
  User get authenticatedUser{
    return _authenticatedUser;
  }
  UserInfo get authenticatedUserInfo{
    return _authenticatedUserInfo;
  }
  bool _isLoading= false;
  List<User> get users{
    return List.from(_users);
  }
  List<UserInfo> get usersInfo{
    return List.from(_usersInfo);
  }
  bool get isLoading{
    return _isLoading;
  }
  Future<bool> addUserInfo(Map<String, dynamic> userInfo)async{
    _isLoading=true;
    notifyListeners();
    try{

      final http.Response response =await http.post('https://newone-2ec23-default-rtdb.firebaseio.com/users.json',
          body: json.encode(userInfo));
      final Map<String , dynamic> responseData =json.decode(response.body);
      UserInfo userInfoWithId = UserInfo(
        id: responseData["name"],
        userName: userInfo["username"],
        email: userInfo["email"],
        userType: 'custom'


      );
      _isLoading=false;
      notifyListeners();
      _usersInfo.add(userInfoWithId);
      return Future.value(true);
    }catch (e){
      _isLoading=false;
      notifyListeners();
      return Future.value(false);
    }

  }
  Future<bool> fetchUserInfo ()async{
    _isLoading=true;
    notifyListeners();
    try{
      final http.Response response =await http.get('https://newone-2ec23-default-rtdb.firebaseio.com/users.json');
      print(" data: ${response.body}");
      final Map<String, dynamic> fetchData=json.decode(response.body);
      final List<UserInfo> usersInfo=[];
      fetchData.forEach((String id, dynamic userInfoData) {
        UserInfo userInfo=UserInfo(
          id: id,
         email: userInfoData["email"],
          userName: userInfoData["username"],
          userId:userInfoData["localId"],
          userType: userInfoData["userType"],
        );
        usersInfo.add(userInfo);

      });
      _usersInfo=usersInfo;
      
      _isLoading=false;
      notifyListeners();
      return Future.value(true);
    }catch (e){
      _isLoading=false;
      return Future.value(false);
    }
  }
   Future<UserInfo> getUserInfo(String userId)async{
   final bool response = await fetchUserInfo();
    UserInfo foundUserInfo;
    if(response){
      for(int i=0 ; i<_usersInfo.length;i++){
        if(_usersInfo[i].userId==userId){
          foundUserInfo=_usersInfo[i];
          break;
        }
      }
    }
    return Future.value(foundUserInfo);
    print(foundUserInfo);
   }
  UserInfo getUserDetails(String userId){
    fetchUserInfo();
    UserInfo foundUserInfo;

      for(int i=0 ; i<_usersInfo.length;i++){
        if(_usersInfo[i].userId==userId){
          foundUserInfo=_usersInfo[i];
          break;
        }

    }
    return foundUserInfo;
  }
  Future <Map<String, dynamic>>
  authenticate(String email, String password,{AuthMode authMode=AuthMode.SignIn,Map<String,dynamic>userInfo})async{
    _isLoading=true;
    notifyListeners();
    Map<String , dynamic> authData={
      "email":email,
      "password": password,
      "returnSecureToken":true
    };

    String message;
    bool hasError = false;
    try{
      http.Response response;
      if(authMode==AuthMode.SignUp){
        response= await http.post("https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyDpilK--w6RgZPi-a8-Rlue7xx-f6zemVU",
            body: json.encode(authData),
            headers: {'Content-Type':'application/json'}
        );
      }else if(authMode==AuthMode.SignIn){
        response= await http.post("https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyDpilK--w6RgZPi-a8-Rlue7xx-f6zemVU",
            body: json.encode(authData),
            headers: {'Content-Type':'application/json'}
        );
      }

      Map<String, dynamic> responseBody=json.decode(response.body);
      SharedPreferences  preferenes= await SharedPreferences.getInstance();
      if(responseBody.containsKey('idToken')){
        _authenticatedUser = User(
            id: responseBody["localId"],
            email: responseBody["email"],
            token: responseBody["idToken"],

        );
        if(authMode==AuthMode.SignIn){
          _authenticatedUserInfo ==await getUserInfo(responseBody["localId"]);
          preferenes.setString("username", _authenticatedUserInfo.userName);
          preferenes.setString("email", _authenticatedUserInfo.email);
          preferenes.setString("userType", _authenticatedUserInfo.userType);

          message='Welcome back';
        }else if(authMode==AuthMode.SignUp){
          userInfo["localId"]=responseBody["localId"];
          addUserInfo(userInfo);
          preferenes.setString("username", userInfo["username"]);
          preferenes.setString("email", userInfo["email"]);
          preferenes.setString("userType", userInfo["userType"]);
          message='Welcome Here';
        }
        preferenes.setString("token", responseBody["idToken"]);
        preferenes.setString("token", responseBody["expiresIn"]);

      }else{
        hasError=true;
        if(responseBody['error']['message'] == 'EMAIL_EXIST'){
          hasError=true;
          message="Email already exists";
        }else if(responseBody['error']['message'] == 'EMAIL_NOT_FOUND'){
          hasError=true;
          message= "Email does not exists";
        }else if(responseBody['error']['message'] == 'INVALID_PASSWORD'){
          hasError=true;
          message= "Incorrect password";
        }
      }
      _isLoading=false;
      notifyListeners();
      return {
        'message':message,
        'hasError':hasError
      };
    }catch(e){
        _isLoading = false;
        notifyListeners();
        return {
          'message':'Creating account failed',
          'hasError': !hasError,
        };
    }
  }
  void autoLogin()async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
     String token = preferences.getString('token');
     if (token != null){
       _authenticatedUserInfo = null;
       _authenticatedUser = null;
       notifyListeners();
     }
  }
  void logout(){
    _authenticatedUser=null;
    _authenticatedUser= null;
  }
}