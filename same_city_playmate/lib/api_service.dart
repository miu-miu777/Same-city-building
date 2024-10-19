import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    fetchData(); // 调用GET请求
    postData();  // 调用POST请求
  }

  // GET请求示例
  Future<void> fetchData() async {
    final url = Uri.parse('https://example.com/api'); // 替换为你的URL

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // 请求成功，解码JSON
        final data = json.decode(response.body);
        print('Response data: $data'); // 打印解码后的数据
      } else {
        // 请求失败
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      // 捕获异常
      print('Error: $e');
    }
  }

  // POST请求示例
  Future<void> postData() async {
    final url = Uri.parse('https://example.com/api'); // 替换为你的URL
    final headers = {
      'Content-Type': 'application/json', // 设置请求头
    };

    // 准备要发送的数据
    final body = json.encode({
      'key1': 'value1',
      'key2': 'value2',
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        // 请求成功，解码JSON
        final data = json.decode(response.body);
        print('Response data: $data'); // 打印解码后的数据
      } else {
        // 请求失败
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      // 捕获异常
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HTTP Request Example'),
      ),
      body: Center(
        child: Text('Check console for output'),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: MyHomePage()));
}
