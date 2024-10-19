import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// 创建数据模型
class User {
  final String username;
  final String avatarUrl;

  User({required this.username, required this.avatarUrl});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      avatarUrl: json['avatar_url'],
    );
  }
}

class Comment {
  final String content;
  final User user;

  Comment({required this.content, required this.user});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      content: json['content'],
      user: User.fromJson(json['user']),
    );
  }
}

class Video {
  final String videoUrl;
  final List<Comment> comments;
  final int commentCount;
  final int likeCount;
  final User user;

  Video({
    required this.videoUrl,
    required this.comments,
    required this.commentCount,
    required this.likeCount,
    required this.user,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      videoUrl: json['video_url'],
      comments: (json['comments'] as List)
          .map((comment) => Comment.fromJson(comment))
          .toList(),
      commentCount: json['comment_count'],
      likeCount: json['like_count'],
      user: User.fromJson(json['user']),
    );
  }
}

// 发起网络请求
Future<Video> fetchVideo(String videoId) async {
  final response = await http.get(
    Uri.parse('https://yourserver.com/api/videos/$videoId'),//替换成后端给的接口地址
  );

  if (response.statusCode == 200) {
    // 如果服务器返回200 OK，则解析JSON数据
    return Video.fromJson(jsonDecode(response.body));
  } else {
    // 如果服务器返回错误状态码，抛出异常
    throw Exception('Failed to load video');
  }
}

// UI
class VideoScreenComment extends StatelessWidget {
  final String videoId;

  VideoScreenComment({required this.videoId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Page'),
      ),
      body: FutureBuilder<Video>(
        future: fetchVideo(videoId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('数据未找到'));
          } else {
            final video = snapshot.data!;
            return Column(
              children: [
                // 显示视频
                VideoPlayer(video.videoUrl),

                // 显示用户信息
                Padding(
                  padding: const EdgeInsets.only(top: 80.0, bottom: 10.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30, // 调整头像大小
                      backgroundImage: NetworkImage(video.user.avatarUrl),
                    ),
                    title: Text(video.user.username),
                  ),
                ),

                // 显示点赞数量和评论数量
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(Icons.thumb_up, size: 30), // 调整图标大小
                      Text('Likes: ${video.likeCount}', style: TextStyle(fontSize: 18)),
                      Icon(Icons.comment, size: 30), // 调整图标大小
                      Text('Comments: ${video.commentCount}', style: TextStyle(fontSize: 18)),
                    ],
                  ),
                ),

                // 显示评论
                Expanded(
                  child: ListView.builder(
                    itemCount: video.comments.length,
                    itemBuilder: (context, index) {
                      final comment = video.comments[index];
                      return ListTile(
                        leading: CircleAvatar(
                          radius: 25, // 调整评论头像大小
                          backgroundImage: NetworkImage(comment.user.avatarUrl),
                        ),
                        title: Text(comment.content, style: TextStyle(fontSize: 16)),
                        subtitle: Text(comment.user.username, style: TextStyle(fontSize: 14)),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

// // 假设有一个简单的 VideoPlayer 组件
class VideoPlayer extends StatelessWidget {
  final String videoUrl;

  VideoPlayer(this.videoUrl);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Placeholder(), // 这里应该替换为实际的视频播放器
    );
  }
}