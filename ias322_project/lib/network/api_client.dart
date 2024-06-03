import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:ias322_project/models/user.dart';
import 'package:ias322_project/network/local_storage.dart';

class ApiClient {
  final dio = Dio(BaseOptions(
    // baseUrl: "https://api-dev.sindbad.tech/api/",
    baseUrl: "http://localhost:8080/",
    // baseUrl: "https://test.sindbad.tech/api/",
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 8),
  ));

  Future<String?> getUserId() async {
    String? token = LocalStorage.getString(LocalStorageKeys.userId);
    return token;
  }

  Future<String> signUp(String name, String email, String contactNumber,
      String password, DateTime birthDate) async {
    try {
      Map<String, dynamic> formData = {
        'name': name,
        'email': email,
        'password': password,
        'contact_number': contactNumber,
        'birth_date': birthDate.toString().split(" ")[0],
      };
      if (kDebugMode) {
        print(formData);
      }
      final response =
          await dio.post("http://localhost:8080/auth/signup", data: formData);
      if (response.statusCode! < 400) {
        LocalStorage.setString(
            LocalStorageKeys.userId, response.data['user_id']);
        return "OK";
      } else {
        return "Error Occurred";
      }
    } on DioException catch (e) {
      if (e.response != null) {
        return e.response!.data;
      } else {
        return "Error Occurred";
      }
    }
  }

  Future<String> login(String email, String password) async {
    try {
      Map<String, dynamic> formData = {"email": email, "password": password};
      if (kDebugMode) {
        print(formData);
      }
      final response =
          await dio.post("http://localhost:8080/auth/login", data: formData);
      if (response.statusCode! < 400) {
        print(response.data);
        LocalStorage.setString(
            LocalStorageKeys.userId, response.data['user_id']);
      }
      return "OK";
    } on DioException catch (e) {
      if (e.response != null) {
        return e.response!.data['detail'];
      } else {
        return "Error Occurred";
      }
    }
  }

  Future<User?> getUser() async {
    String? token = await getUserId();
    try {
      Map<String, String> headers = {"Authorization": "Bearer $token"};
      final response = await dio.get("http://localhost:8080/user",
          options: Options(headers: headers));

      if (response.statusCode == 200) {
        final user = User.fromJson(response.data);
        return user;
      } else {
        throw "Failed to get user";
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }

  Future<String> updateUser(form) async {
    String? token = await getUserId();
    Map<String, String> headers = {
      "Authorization": "Bearer $token",
    };

    try {
      final response = await dio.put("http://localhost:8080/user/update",
          data: form, options: Options(headers: headers));
      if (response.statusCode! < 400) {
        return "OK";
      } else {
        return "Error Occurred";
      }
    } on DioException catch (e) {
      if (e.response != null) {
        return e.response!.data['detail'];
      } else {
        return "Error Occurred";
      }
    }
  }

  Future<String?> logout() async {
    try {
      await LocalStorage.remove(LocalStorageKeys.userId);
      return "OK";
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }

  Future<dynamic> createQuestion(String title, String question) async {
    String? token = await getUserId();
    Map<String, String> headers = {
      "Authorization": "Bearer $token",
    };
    Map<String, dynamic> formData = {
      "title": title,
      "question": question,
    };
    final response = await dio.post("http://localhost:8080/question",
        data: formData, options: Options(headers: headers));
    if (response.statusCode! < 400) {
      return response.data;
    } else {
      return "Error Occurred";
    }
  }

  Future<dynamic> addAnswer(String answer, String questionId) async {
    String? token = await getUserId();
    Map<String, String> headers = {
      "Authorization": "Bearer $token",
    };
    Map<String, dynamic> formData = {
      "answer": answer,
      "question_id": questionId,
    };
    final response = await dio.post(
      "http://localhost:8080/answer/$questionId",
      data: formData,
      options: Options(headers: headers),
    );
    if (response.statusCode! < 400) {
      return response.data;
    } else {
      return "Error Occurred";
    }
  }

  Future<String> updateAnswer(form) async {
    String? token = await getUserId();
    Map<String, String> headers = {
      "Authorization": "Bearer $token",
    };
    final response = await dio.put(
      "http://localhost:8080/answer/${form['answer_id']}",
      data: form,
      options: Options(headers: headers),
    );
    if (response.statusCode! < 400) {
      return "OK";
    } else {
      return "Error Occurred";
    }
  }

  Future<String> deleteAnswer(form) async {
    String? token = await getUserId();
    Map<String, String> headers = {
      "Authorization": "Bearer $token",
    };
    final response = await dio.delete(
      "http://localhost:8080/answer/${form['answer_id']}",
      data: form,
      options: Options(headers: headers),
    );
    if (response.statusCode! < 400) {
      return "OK";
    } else {
      return "Error Occurred";
    }
  }

  Future<dynamic> getAnswers(String questionId) async {
    try {
      final response =
          await dio.get("http://localhost:8080/answer/$questionId");
      if (response.statusCode! < 400) {
        return response.data;
      } else {
        return [];
      }
    } on DioException catch (e) {
      if (e.response != null) {
        return e.response!.data['detail'];
      } else {
        return "Error Occurred";
      }
    }
  }

  Future<dynamic> getQuestions() async {
    try {
      final response = await dio.get("http://localhost:8080/question");
      if (response.statusCode! < 400) {
        return response.data;
      } else {
        return [];
      }
    } on DioException catch (e) {
      if (e.response != null) {
        return e.response!.data['detail'];
      } else {
        return "Error Occurred";
      }
    }
  }

  Future<String> deleteQuestion(form) async {
    String? token = await getUserId();
    Map<String, String> headers = {
      "Authorization": "Bearer $token",
    };
    final response = await dio.delete(
      "http://localhost:8080/question/${form['question_id']}",
      data: form,
      options: Options(headers: headers),
    );
    if (response.statusCode! < 400) {
      return "OK";
    } else {
      return "Error Occurred";
    }
  }

  Future<String> updateQuestion(form) async {
    String? token = await getUserId();
    Map<String, String> headers = {
      "Authorization": "Bearer $token",
    };
    final response = await dio.put(
      "/question/${form['question_id']}",
      data: form,
      options: Options(headers: headers),
    );
    if (response.statusCode! < 400) {
      return "OK";
    } else {
      return "Error Occurred";
    }
  }

  Future<dynamic> getQuestionWithAnswers(String questionId) async {
    try {
      final response =
          await dio.get("http://localhost:8080/question/$questionId");
      if (response.statusCode! < 400) {
        return response.data;
      } else {
        return [];
      }
    } on DioException catch (e) {
      if (e.response != null) {
        return e.response!.data['detail'];
      } else {
        return "Error Occurred";
      }
    }
  }

  Future<dynamic> getChats() async {
    try {
      String? token = await getUserId();
      Map<String, String> headers = {
        "Authorization": "Bearer $token",
      };
      final response = await dio.get("http://localhost:8080/chat",
          options: Options(headers: headers));
      if (response.statusCode! < 400) {
        print(response.data);
        return response.data;
      } else {
        return [];
      }
    } on DioException catch (e) {
      if (e.response != null) {
        return e.response!.data['detail'];
      } else {
        return "Error Occurred";
      }
    }
  }

  Future<String> createChat() async {
    String? token = await getUserId();
    Map<String, String> headers = {
      "Authorization": "Bearer $token",
    };
    final response = await dio.post("http://localhost:8080/chat",
        options: Options(headers: headers));
    if (response.statusCode! < 400) {
      return response.data['chat_id'];
    } else {
      return "Error Occurred";
    }
  }

  Future<dynamic> getChatList() async {
    try {
      String? token = await getUserId();
      Map<String, String> headers = {
        "Authorization": "Bearer $token",
      };
      final response = await dio.get("http://localhost:8080/chat",
          options: Options(headers: headers));

      if (response.statusCode! < 400) {
        return response.data;
      } else {
        return [];
      }
    } on DioException catch (e) {
      if (e.response != null) {
        return e.response!.data['detail'];
      } else {
        return "Error Occurred";
      }
    }
  }

  Future<dynamic> getChat(String chatId) async {
    try {
      String? token = await getUserId();
      Map<String, String> headers = {
        "Authorization": "Bearer $token",
      };
      final response = await dio.get("http://localhost:8080/chat/$chatId",
          options: Options(headers: headers));
      if (response.statusCode! < 400) {
        return response.data;
      } else {
        return [];
      }
    } on DioException catch (e) {
      if (e.response != null) {
        return e.response!.data['detail'];
      } else {
        return "Error Occurred";
      }
    }
  }

  Future<String> deleteChat(String chatId) async {
    String? token = await getUserId();
    Map<String, String> headers = {
      "Authorization": "Bearer $token",
    };
    final response = await dio.delete(
      "http://localhost:8080/chat/$chatId",
      options: Options(headers: headers),
    );
    if (response.statusCode! < 400) {
      return "OK";
    } else {
      return "Error Occurred";
    }
  }

  Future<dynamic> sendMessage(String chatId, String message) async {
    print(chatId);
    String? token = await getUserId();
    Map<String, String> headers = {
      "Authorization": "Bearer $token",
    };
    final response = await dio.post(
      "http://localhost:8080/message/$chatId",
      data: {"message": message},
      options: Options(headers: headers),
    );
    if (response.statusCode! < 400) {
      return response.data;
    } else {
      return "Error Occurred";
    }
  }

  Future<dynamic> getMessages(String chatId) async {
    try {
      String? token = await getUserId();
      Map<String, String> headers = {
        "Authorization": "Bearer $token",
      };
      final response = await dio.get("http://localhost:8080/message/$chatId",
          options: Options(headers: headers));
      if (response.statusCode! < 400) {
        return response.data;
      } else {
        return [];
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print(e.response!.data);
        return e.response!.data['detail'];
      } else {
        return "Error Occurred";
      }
    }
  }

  Future<String> deleteMessages(String chatId) async {
    String? token = await getUserId();
    Map<String, String> headers = {
      "Authorization": "Bearer $token",
    };
    final response = await dio.delete(
      "http://localhost:8080/message/$chatId",
      options: Options(headers: headers),
    );
    if (response.statusCode! < 400) {
      return "OK";
    } else {
      return "Error Occurred";
    }
  }

  Future<dynamic> getGoals() async {
    String? token = await getUserId();
    Map<String, String> headers = {"Authorization": "Bearer $token"};
    final response = await dio.get("http://localhost:8080/goal",
        options: Options(headers: headers));
    if (response.statusCode! < 400) {
      print(response.data);
      return response.data;
    } else {
      return [];
    }
  }

  Future<dynamic> createGoal(String name, int target) async {
    String? token = await getUserId();
    Map<String, String> headers = {
      "Authorization": "Bearer $token",
    };

    Map<String, dynamic> formData = {
      "title": name,
      "target": target,
    };
    final response = await dio.post("http://localhost:8080/goal",
        data: formData, options: Options(headers: headers));
    if (response.statusCode! < 400) {
      return response.data[0];
    } else {
      return "Error Occurred";
    }
  }

  Future<dynamic> updateGoal(
      String name, int target, int done, String id) async {
    String? token = await getUserId();
    Map<String, String> headers = {"Authorization": "Bearer $token"};
    Map<String, dynamic> formData = {
      "goal_id": id,
      "name": name,
      "target": target,
      "done": done
    };
    final response = await dio.put("http://localhost:8080/goal/$id",
        data: formData, options: Options(headers: headers));

    if (response.statusCode! < 400) {
      return response.data;
    } else {
      return "Error Occurred";
    }
  }

  Future<String> deleteGoal(String id) async {
    String? token = await getUserId();
    Map<String, String> headers = {
      "Authorization": "Bearer $token",
    };
    final response = await dio.delete(
      "http://localhost:8080/goal/$id",
      options: Options(headers: headers),
    );
    if (response.statusCode! < 400) {
      return "OK";
    } else {
      return "Error Occurred";
    }
  }
}
