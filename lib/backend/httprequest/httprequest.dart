import 'dart:convert';

import 'package:distributorsapp/backend/config/config.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class HttprequestService {
  Future<Map<String, dynamic>> getToken() async {
    final String basicAuth = 'Basic ' +
        base64Encode(utf8.encode('${Config.username}:${Config.password}'));
    Map<String, dynamic> responseRequest = {
      "messages": [
        {
          "code": 500,
          "message": "SOMETHING WENT WRONG",
        }
      ],
      "response": {}
    };
    try {
      final response = await http.post(
        Uri.parse(Config.getTokenUrl),
        headers: {
          'Authorization': basicAuth,
          'Content-Type': 'application/json',
          // Add other headers if needed`
        },
      ).timeout(Duration(seconds: 30));

      if (response.statusCode == 200) {
        // Successful response
        responseRequest = json.decode(response.body);
        print('isLogin response: $responseRequest');
        if (responseRequest['messages'][0]['code'].toString() == "0") {
          return responseRequest;
        } else {
          return responseRequest;
        }
      } else {
        // Handle error responses
        print('isLogin response Error: ${response.statusCode}');
        print('isLogin Response body: ${response.body}');
        return responseRequest;
      }
    } catch (e) {
      print("isLogin error: $e");
      return responseRequest;
    }
  }

  Future<Map<String, dynamic>> isLogin(Map<String, dynamic> item) async {
    Map<String, dynamic> responseRequest = {
      "messages": [
        {
          "code": 500,
          "message": "SOMETHING WENT WRONG",
        }
      ],
      "response": {}
    };

    //emmanueltest@token1234

    //print('token: $token');

    try {
      final response = await http
          .post(
            Uri.parse(Config.loginUrl),
            headers: {
              'Authorization': 'Bearer ${Config.bearerTokenapi}',
              'Content-Type': 'application/json',
              // Add other headers if needed`
            },
            body: jsonEncode(item),
          )
          .timeout(Duration(seconds: 30));

      if (response.statusCode == 200) {
        // Successful response
        responseRequest = json.decode(response.body);
        print('isLogin response: $responseRequest');
        if (responseRequest['messages'][0]['code'].toString() == "0") {
          return responseRequest;
        } else {
          return responseRequest;
        }
      } else {
        // Handle error responses
        print('isLogin response Error: ${response.statusCode}');
        print('isLogin Response body: ${response.body}');
        return responseRequest;
      }
    } catch (e) {
      print("isLogin error: $e");
      return responseRequest;
    }
  }

  Future<Map<String, dynamic>> registerUser(Map<String, dynamic> item) async {
    Map<String, dynamic> responseRequest = {
      "messages": [
        {
          "code": 500,
          "message": "SOMETHING WENT WRONG",
        }
      ],
      "response": {}
    };

    //emmanueltest@token1234

    //print('token: $token');
    print('registerUser item: $item');

    try {
      final response = await http
          .post(
            Uri.parse(Config.registerUserUrl),
            headers: {
              'Authorization': 'Bearer ${Config.bearerTokenapi}',
              'Content-Type': 'application/json',
              // Add other headers if needed`
            },
            body: jsonEncode(item),
          )
          .timeout(Duration(seconds: 30));

      if (response.statusCode == 200) {
        // Successful response
        responseRequest = json.decode(response.body);
        print('registerUser response: $responseRequest');
        if (responseRequest['messages'][0]['code'].toString() == "0") {
          return responseRequest;
        } else {
          return responseRequest;
        }
      } else {
        // Handle error responses
        print('registerUser response Error: ${response.statusCode}');
        print('registerUser Response body: ${response.body}');
        return responseRequest;
      }
    } catch (e) {
      print("registerUser error: $e");
      return responseRequest;
    }
  }

  Future<Map<String, dynamic>> getUserInfo(Map<String, dynamic> item) async {
    Map<String, dynamic> responseRequest = {
      "messages": [
        {
          "code": 500,
          "message": "SOMETHING WENT WRONG",
        }
      ],
      "response": {}
    };

    //emmanueltest@token1234

    //print('token: $token');

    try {
      final response = await http
          .post(
            Uri.parse(Config.getUserInfoUrl),
            headers: {
              'Authorization': 'Bearer ${Config.bearerTokenapi}',
              'Content-Type': 'application/json',
              // Add other headers if needed`
            },
            body: jsonEncode(item),
          )
          .timeout(Duration(seconds: 30));

      if (response.statusCode == 200) {
        // Successful response
        responseRequest = json.decode(response.body);
        print('getUserInfo response: $responseRequest');
        if (responseRequest['messages'][0]['code'].toString() == "0") {
          return responseRequest;
        } else {
          return responseRequest;
        }
      } else {
        // Handle error responses
        print('getUserInfo response Error: ${response.statusCode}');
        print('getUserInfo Response body: ${response.body}');
        return responseRequest;
      }
    } catch (e) {
      print("getUserInfo error: $e");
      return responseRequest;
    }
  }

  Future<Map<String, dynamic>> updateFilipayCard(
      Map<String, dynamic> item) async {
    Map<String, dynamic> responseRequest = {
      "messages": [
        {
          "code": 500,
          "message": "SOMETHING WENT WRONG",
        }
      ],
      "response": {}
    };

    print('updateFilipayCard body request: $item');

    //emmanueltest@token1234

    //print('token: $token');

    try {
      final response = await http
          .put(
            Uri.parse(Config.updateFilipayCardBalanceUrl),
            headers: {
              'Authorization': 'Bearer ${Config.bearerTokenapi}',
              'Content-Type': 'application/json',
              // Add other headers if needed`
            },
            body: jsonEncode(item),
          )
          .timeout(Duration(seconds: 30));

      if (response.statusCode == 200) {
        // Successful response
        responseRequest = json.decode(response.body);
        print('updateFilipayCard response: $responseRequest');
        if (responseRequest['messages'][0]['code'].toString() == "0") {
          return responseRequest;
        } else {
          return responseRequest;
        }
      } else {
        // Handle error responses
        print('updateFilipayCard response Error: ${response.statusCode}');
        print('updateFilipayCard Response body: ${response.body}');
        return responseRequest;
      }
    } catch (e) {
      print("updateFilipayCard error: $e");
      return responseRequest;
    }
  }

  Future<Map<String, dynamic>> getBalance(Map<String, dynamic> item) async {
    Map<String, dynamic> responseRequest = {
      "messages": [
        {
          "code": 500,
          "message": "SOMETHING WENT WRONG",
        }
      ],
      "response": {}
    };

    print('getBalance body request: $item');

    //emmanueltest@token1234

    //print('token: $token');

    try {
      final response = await http
          .post(
            Uri.parse(Config.getBalanceUrl),
            headers: {
              'Authorization': 'Bearer ${Config.bearerTokenapi}',
              'Content-Type': 'application/json',
              // Add other headers if needed`
            },
            body: jsonEncode(item),
          )
          .timeout(Duration(seconds: 30));

      if (response.statusCode == 200) {
        // Successful response
        responseRequest = json.decode(response.body);
        print('getBalance response: $responseRequest');
        if (responseRequest['messages'][0]['code'].toString() == "0") {
          return responseRequest;
        } else {
          return responseRequest;
        }
      } else {
        // Handle error responses
        print('getBalance response Error: ${response.statusCode}');
        print('getBalance Response body: ${response.body}');
        return responseRequest;
      }
    } catch (e) {
      print("getBalance error: $e");
      return responseRequest;
    }
  }

  Future<Map<String, dynamic>> getTransactionHistory(String id) async {
    Map<String, dynamic> responseRequest = {
      "messages": [
        {
          "code": 500,
          "message": "SOMETHING WENT WRONG",
        }
      ],
      "response": {}
    };

    //emmanueltest@token1234

    //print('token: $token');

    try {
      final response = await http.get(
        Uri.parse("${Config.getTransactionHistoryUrl}$id"),
        headers: {
          'Authorization': 'Bearer ${Config.bearerTokenapi}',
          'Content-Type': 'application/json',
          // Add other headers if needed`
        },
      ).timeout(Duration(seconds: 30));

      if (response.statusCode == 200) {
        // Successful response
        responseRequest = json.decode(response.body);
        print('getTransactionHistory response: $responseRequest');
        if (responseRequest['messages'][0]['code'].toString() == "0") {
          return responseRequest;
        } else {
          return responseRequest;
        }
      } else {
        // Handle error responses
        print('getTransactionHistory response Error: ${response.statusCode}');
        print('getTransactionHistory Response body: ${response.body}');
        return responseRequest;
      }
    } catch (e) {
      print("getTransactionHistory error: $e");
      return responseRequest;
    }
  }

  Future<Map<String, dynamic>> checkRefNum(String id) async {
    Map<String, dynamic> responseRequest = {
      "messages": [
        {
          "code": 500,
          "message": "SOMETHING WENT WRONG",
        }
      ],
      "response": {}
    };

    //emmanueltest@token1234

    //print('token: $token');

    try {
      final response = await http.get(
        Uri.parse("${Config.checkRefNumUrl}$id"),
        headers: {
          'Authorization': 'Bearer ${Config.bearerTokenapi}',
          'Content-Type': 'application/json',
          // Add other headers if needed`
        },
      ).timeout(Duration(seconds: 30));

      if (response.statusCode == 200) {
        // Successful response
        responseRequest = json.decode(response.body);
        print('checkRefNum response: $responseRequest');
        if (responseRequest['messages'][0]['code'].toString() == "0") {
          return responseRequest;
        } else {
          return responseRequest;
        }
      } else {
        // Handle error responses
        print('checkRefNum response Error: ${response.statusCode}');
        print('checkRefNum Response body: ${response.body}');
        return responseRequest;
      }
    } catch (e) {
      print("getTransactionHistory error: $e");
      return responseRequest;
    }
  }

  Future<Map<String, dynamic>> getBanks() async {
    Map<String, dynamic> responseRequest = {
      "messages": [
        {
          "code": 500,
          "message": "SOMETHING WENT WRONG",
        }
      ],
      "response": {}
    };

    //emmanueltest@token1234

    //print('token: $token');

    try {
      final response = await http.get(
        Uri.parse("${Config.getBankIdUrl}"),
        headers: {
          'Authorization': 'Bearer ${Config.bearerTokenapi}',
          'Content-Type': 'application/json',
          // Add other headers if needed`
        },
      ).timeout(Duration(seconds: 30));

      if (response.statusCode == 200) {
        // Successful response
        responseRequest = json.decode(response.body);
        print('getBanks response: $responseRequest');
        if (responseRequest['messages'][0]['code'].toString() == "0") {
          return responseRequest;
        } else {
          return responseRequest;
        }
      } else {
        // Handle error responses
        print('getBanks response Error: ${response.statusCode}');
        print('getBanks Response body: ${response.body}');
        return responseRequest;
      }
    } catch (e) {
      print("getBanks error: $e");
      return responseRequest;
    }
  }

  Future<Map<String, dynamic>> sandBoxRequest(Map<String, dynamic> item) async {
    final Map<String, String> headers = {
      'accept': 'application/json',
      'x-api-key': Config.isLive ? Config.liveApiToken : Config.sanboxApiToken,
      'Content-Type': 'application/json',
    };
    Map<String, dynamic> responseRequest = {
      "messages": [
        {
          "code": 500,
          "message": "SOMETHING WENT WRONG",
        }
      ],
      "response": {}
    };

    print('sandBoxRequest body request: $item');

    //emmanueltest@token1234

    //print('token: $token');

    try {
      final response = await http
          .post(
            Uri.parse(
                Config.isLive ? Config.sandboxUrlLive : Config.sandboxUrl),
            headers: headers,
            body: jsonEncode(item),
          )
          .timeout(Duration(seconds: 30));

      if (response.statusCode == 200) {
        // Successful response
        responseRequest = json.decode(response.body);
        print('sandBoxRequest response: $responseRequest');
        if (responseRequest['messages'][0]['code'].toString() == "0") {
          return responseRequest;
        } else {
          return responseRequest;
        }
      } else {
        // Handle error responses
        print('sandBoxRequest response Error: ${response.statusCode}');
        print('sandBoxRequest Response body: ${response.body}');
        return responseRequest;
      }
    } catch (e) {
      print("sandBoxRequest error: $e");
      return responseRequest;
    }
  }
}
