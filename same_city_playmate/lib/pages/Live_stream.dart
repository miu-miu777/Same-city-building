import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';  //用于定时器
import 'package:video_player/video_player.dart';

void main() {
  runApp(Live_streamPage());
}

class Live_streamPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Live Streaming',
      debugShowCheckedModeBanner: false,//关闭debug标签
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LiveStreamingPage(),
    );
  }
}

class LiveStreamingPage extends StatefulWidget {
  @override
  _LiveStreamingPageState createState() => _LiveStreamingPageState();
}

class _LiveStreamingPageState extends State<LiveStreamingPage> {
  late VideoPlayerController _videoPlayerController;
  Future<void>? _initializeVideoPlayerFuture;
  final TextEditingController _controller = TextEditingController();
  final List<String> _messages = [];
  final Map<int, bool> _showMessages = {}; // 用于跟踪每条消息的显示状态
  final Map<int, double> _messageOpacity = {}; // 用于跟踪每条消息的透明度
  ScrollController? _scrollController; // ScrollController 声明
  bool _isFollowing = false; // 关注状态
  //点赞数
  Offset? _likePosition;
  bool _showLike = false;
  int _likeCount = 0;  // 使用可空类型 int?点赞数初始化

  // 关注按钮点击事件处理
  void _toggleFollow() {
    setState(() {
      _isFollowing = !_isFollowing;
    });

    final snackBar = SnackBar(
      content: Text(_isFollowing ? '关注成功' : '取消关注'),
      duration: Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse('视频直播流的URL'),
    );
    _initializeVideoPlayerFuture = _videoPlayerController.initialize();
    _videoPlayerController.setLooping(true);
    _videoPlayerController.play(); // 自动播放
    _scrollController = ScrollController(); // 初始化 ScrollController
  }

  @override
  void dispose() {
    _scrollController?.dispose(); // 释放 ScrollController
    _controller.dispose(); // 释放 TextEditingController
    _videoPlayerController.dispose();
    super.dispose();
  }

  // 点赞效果处理函数
  void _handleTap(TapDownDetails details) {
    setState(() {
      _likePosition = details.localPosition;
      _showLike = true;
      _likeCount++;  // 每次点击增加点赞数
    });

    // 3秒后隐藏点赞图标
    Timer(Duration(seconds: 3), () {
      setState(() {
        _showLike = false;
      });
    });
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _messages.add(_controller.text);
        int index = _messages.length - 1;
        _showMessages[index] = true;
        _messageOpacity[index] = 1.0;
        _controller.clear();
      });
      // 3秒后渐渐消失
      int index = _messages.length - 1;
      Future.delayed(Duration(seconds: 3), () {
        setState(() {
          _messageOpacity[index] = 0.0;
        });

        // 1秒后彻底移除
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            _showMessages[index] = false;
          });
        });
      });
      // 在新消息添加后，自动滚动到最新消息
      Future.delayed(Duration(milliseconds: 100), () {
        _scrollController?.animateTo(
          _scrollController!.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  void _requestToConnect() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,  // 允许全屏高度控制
      backgroundColor: Colors.transparent,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.4,  // 设置弹窗高度为屏幕高度的 40%
          widthFactor: 0.9,   // 设置弹窗宽度为屏幕宽度的 90%
          child: Container(
            decoration:const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),  // 设置圆角
              ),
            ),
            child: RequestToConnectContent(),
          ),
        );
      },
    );
  }

  void _joinActivity() {
    // 处理参加活动的逻辑
  }

  void _showProfileModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.66,
          widthFactor: 0.9,
          child: Container(
            decoration:const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: ProfileModalContent(),
          ),
        );
      },
    );
  }

String fan_lxr = '加入粉丝团';
String renshu_lxr = '1.2K';
String touxiang_lxr = 'assets/loading.jpg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
        onTapDown: _handleTap, // 捕捉点击事件，触发点赞效果
        child: Stack(
        children: [
          FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return AspectRatio(
                  aspectRatio: _videoPlayerController.value.aspectRatio,
                  child: VideoPlayer(_videoPlayerController),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
          // 直播播放区域
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black,
            child:const Center(
              child: Text(
                '直播页面',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
          ),
          // 顶部信息栏
          Positioned(
            top: 40,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 头像、昵称、关注按钮和加入粉丝团按钮
                GestureDetector(
                  onTap: _showProfileModal,  // 点击弹出个人主页弹窗
                  child: Row(
                    children: [
                     const CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage('assets/loading.jpg'),
                        // backgroundImage: NetworkImage(
                        //   '', // 替换为实际的图片链接
                        // ),
                      ),
                     const SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                         Row(
                            children: [
                              Text(
                                '主播昵称',
                                style: TextStyle(color: Colors.white, fontSize: 16),
                              ),
                              SizedBox(width: 20),
                              // 点赞数图标和文本
                              Row(
                                children: [
                                  Icon(Icons.local_fire_department, color: Colors.orange, size: 12),
                                  SizedBox(width: 2),
                                  Text(
                                      '$_likeCount',
                                      style: TextStyle(color: Colors.white, fontSize: 10)
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              // 加关注按钮
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _isFollowing ? Colors.grey[300] : Colors.white,
                                  foregroundColor: Colors.blue,
                                  minimumSize:const Size(55, 20),   // 按钮大小
                                ),
                                onPressed: _toggleFollow,
                                child: Text(
                                  _isFollowing ? '已关注' : '+关注',
                                  style:const TextStyle(fontSize: 10),
                                ),
                              ),
                             const SizedBox(width: 12), // 加大空白宽度以右移按钮
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.blue,
                                  minimumSize:const Size(70, 20),
                                ),
                                onPressed: () {
                                  // 处理加入粉丝团操作
                                },
                                child: Text(
                                  fan_lxr,
                                  style:const TextStyle(fontSize: 10),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // 观众数量
                Row(
                  children: [
                   const Icon(Icons.person, color: Colors.white),
                   const SizedBox(width: 4),
                    Text(
                      renshu_lxr,
                      style:const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // 点赞图标显示
          if (_showLike && _likePosition != null)
            Positioned(
              left: _likePosition!.dx,
              top: _likePosition!.dy,
              child: Icon(Icons.favorite, color: Colors.pink[200], size: 50),  // 点赞效果图标
            ),

          // 底部工具栏上方的评论和热卖订单区域
          Positioned(
            bottom: 120, // 留出足够空间给底部工具栏
            left: 20,
            right: 20,
            child: Row(
              children: [
                // 左侧的评论区
                Expanded(
                  flex: 2, // 占屏幕的2/3宽度
                  child: Container(
                    height: 100, // 评论区高度
                    color: Colors.black.withOpacity(0.5),
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: _messages.length,
                      itemBuilder: (context, index) {
                        if (!_showMessages[index]!) return SizedBox.shrink();
                        return AnimatedOpacity(
                            opacity: _messageOpacity[index]!,
                            duration: Duration(seconds: 1),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                          child: Text(
                            _messages[index],
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(width: 10),
                // 右侧的热卖订单窗口
                Expanded(
                  flex: 1, // 占屏幕的1/3宽度
                  child: Container(
                    height: 270, // 热卖窗口高度
                    color: Colors.red.withOpacity(0.8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                       const Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '热门活动',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView(
                            padding: EdgeInsets.only(top: 0),  //去除默认的顶部间距
                            children: [
                              Image.asset(
                                'assets/chuchuang.jpg',  // 图片路径
                                width: double.infinity,     // 让图片宽度适应屏幕
                                height: 170,                // 图片高度
                                fit: BoxFit.fill,          // 图片填充方式
                              ),
                              ListTile(
                                title: Text('活动1', style: TextStyle(color: Colors.white)),
                                subtitle: Text('¥100', style: TextStyle(color: Colors.white70)),
                              ),
                              Image.asset(
                                'assets/chuchuang.jpg',  // 图片路径
                                width: double.infinity,     // 让图片宽度适应屏幕
                                height: 150,                // 图片高度
                                fit: BoxFit.fill,          // 图片填充方式
                              ),
                              ListTile(
                                title: Text('活动2', style: TextStyle(color: Colors.white)),
                                subtitle: Text('¥200', style: TextStyle(color: Colors.white70)),
                              ),
                              // 添加更多的订单信息
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // 底部工具栏，包括输入框、发送按钮、请求连麦按钮、参加活动按钮、礼物按钮和分享按钮
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Row(
              children: [
                // 请求连麦按钮
                IconButton(
                  icon:const Icon(Icons.mic, color: Colors.white),
                  onPressed: _requestToConnect,
                ),
                // 参加活动按钮
                IconButton(
                  icon:const Icon(Icons.event, color: Colors.white),
                  onPressed: _joinActivity,
                ),
                // 礼物按钮
                IconButton(
                  icon:const Icon(Icons.card_giftcard, color: Colors.white),
                  onPressed: () {
                    // 发送礼物功能
                  },
                ),
                // 分享按钮
                IconButton(
                  icon:const Icon(Icons.share, color: Colors.white),
                  onPressed: () {
                    // 分享直播
                  },
                ),
                // 输入框和发送按钮在最右侧
                Expanded(
                  child: Row(
                    children: [
                      // 输入框
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          decoration: InputDecoration(
                            hintText: '请输入',
                            hintStyle:const TextStyle(color: Colors.white54,),
                            filled: true,
                            fillColor: Colors.black54,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          style:const TextStyle(color: Colors.white),
                        ),
                      ),
                     const SizedBox(width: 8),
                      // 发送按钮在输入框的右边
                      IconButton(
                        icon:const Icon(Icons.send, color: Colors.white),
                        onPressed: _sendMessage,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
        ),
    );
  }
}

// 申请连麦弹窗内容
class RequestToConnectContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          const Text(
            '申请连麦',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            '请输入您的连麦请求信息：',
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 20),
          const TextField(
            decoration: InputDecoration(
              hintText: '输入申请信息',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)), // 内部边框圆角
                borderSide: BorderSide.none, // 去掉边框线
              ),
              filled: true,
              fillColor: Color(0xFFF3E5FF), // 让背景透明，使用外部容器的背景色
              contentPadding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 10.0), // 增加垂直和水平内边距
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // 处理连麦申请逻辑
              Navigator.pop(context); // 关闭弹窗
            },
            child:const Text(
              '提交申请',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

// 个人主页弹窗内容
class ProfileModalContent extends StatelessWidget {
  String zhubonicheng_lxr = '主播昵称';
  String placeholder_lxr  = 'assets/loading.jpg';
  String jianjie_lxr  = '小号偶尔直播: @曦月的小日常(拍戏日常 偶尔直播对生活进行…）';
  String touxiang_lxr = 'assets/loading.jpg';
  String allziliao_lxr = '查看完整资料';
  String chuchuang_lxr = 'assets/chuchuang.jpg';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(  // 添加垂直滚动
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 15),
          ClipOval(
             child: Image(//FadeInImage.assetNetwork(
            //   placeholder: placeholder_lxr, // 图片网络地址
              image: AssetImage(touxiang_lxr),
              width: 100, // 设定宽度
              height: 100, // 设定高度
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            zhubonicheng_lxr,
            style:const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
         const SizedBox(height: 12),
          Text(
            jianjie_lxr,
            textAlign: TextAlign.center,
            style:const TextStyle(fontSize: 14, color: Colors.black54),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // 跳转个人主页详情逻辑
            },
            child: Text(allziliao_lxr),
          ),
          const SizedBox(height: 24),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: const Text(
              '个人橱窗',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(20),
            height: 300,
            decoration: BoxDecoration(
              color: Colors.blueGrey[100],
              borderRadius:const BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ), //添加圆角
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,   //每列三个
                      crossAxisSpacing: 4,   // 设置物品之间的横向间距
                      mainAxisSpacing: 20,    // 设置物品之间的纵向间距
                      childAspectRatio: 0.9,    // 物品宽高比
                    ),
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return _buildShowcaseItem('商品${index + 1}',
                          'assets/chuchuang.jpg${index + 1}');
                    },
                  ),
                ],
              ),
            ),

          ),
    ],
      ),
    );
  }

  Widget _buildShowcaseItem(String title, String imageUrl) {
    return Container(
      margin: const EdgeInsets.only(right: 20.0),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: AssetImage(chuchuang_lxr),
                fit: BoxFit.fill,
              ),
            ),
          ),
         const SizedBox(height: 8,width: 8,),
          Text(
            title,
            style:const TextStyle(fontSize: 12, color: Colors.black),
          ),
        ],
      ),
    );
  }
}





