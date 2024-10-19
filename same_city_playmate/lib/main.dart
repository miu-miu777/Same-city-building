import 'dart:math';//类生成随机数、使用 sqrt() 和 pow() 函数进行数学计算，并且访问常量 pi。
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await initializeDateFormatting('zh_CN',''); // 替换为你的语言代码
  runApp(MyApp_kqy());
}

class MyApp_kqy extends StatelessWidget {
  const MyApp_kqy({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Playmate Demo',
      debugShowCheckedModeBanner: false,//关闭debug标签
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        // useMaterial3: true,
      ),
      home: const SplashScreen_kqy(), // 启动页面
    );
  }
}

class WelcomePage_kqy extends StatelessWidget {
  const WelcomePage_kqy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          '欢迎',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class SplashScreen_kqy extends StatefulWidget {
  const SplashScreen_kqy({super.key});

  @override
  State<SplashScreen_kqy> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen_kqy> {
  @override
  void initState() {
    super.initState();
    // 延迟2秒后跳转到主页面
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const MyHomePage_kqy(title: 'MyHome'),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const WelcomePage_kqy();
  }
}

class MyHomePage_kqy extends StatefulWidget {
  const MyHomePage_kqy({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage_kqy> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage_kqy> with SingleTickerProviderStateMixin {
  int _bottomNavIndex = 0; // 需要初始化
  late TabController _tabController; // 需要定义
  final TextStyle tabTextStyle_kqy = TextStyle(fontSize: 24.0); //定义导航栏字号

  @override
  void initState() {
    super.initState();
    // 初始化 TabController length规定顶部切换的页数
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose(); // 释放 TabController 资源
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // 去掉标题
        toolbarHeight: 5.0, // 设置顶部导航栏topbar的高度
        backgroundColor: Colors.black.withOpacity(0.2),//黑色透明度90%
        bottom: _bottomNavIndex == 0
            ? PreferredSize(
          preferredSize: Size.fromHeight(48.0), // 指定容器的高度
          child: Container(
            child: TabBar(
              controller: _tabController, // 这里将控制器传给 TabBar

              labelColor: Colors.black,
              unselectedLabelColor: Colors.white70,
              tabs:  [
                CustomTab(text: '推荐'),
                CustomTab(text: '附近'),
                CustomTab(text: '关注'),
              ],
            ),
          ),
        )
            : null,
      ),
      extendBodyBehindAppBar: true,
      body: IndexedStack(
        index: _bottomNavIndex,
        children: _bottomNavIndex == 0
            ? [
          TabBarView(
            controller: _tabController,
            children: [
              // 这是第一个页面即首页，显示PageView和PageIndicator
              _buildWidgetOptions()[0],

              //推荐页
              FindVideo_kqy(),

              //关注 --用发现页先代替 因为还没确定定位的事情
              FindVideo_kqy(),

              //附近
              FindVideo_kqy(),
            ],
          ),
        ]
            : _buildWidgetOptions(),
      ),

      //底部导航栏
      bottomNavigationBar: Container(
        // color: Colors.black, // 设置透明的黑色背景
        child: BottomNavigationBar(
          currentIndex: _bottomNavIndex,
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.yellow,
          onTap: (index) {
            _onItemTapped_kqy(index);
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '', // 首页
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.videocam),
              label: '', // 发布视频
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: '', // 消息
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: '', // 我的
            ),
          ],
        ),
      ),

    );
  }

  //底部导航栏链接的页面
  List<Widget> _buildWidgetOptions() {
    return [
      // 首页
      FindVideo_kqy(),

      //发布视频
      ListView.builder(
        physics: PageScrollPhysics(),
        itemCount: 10,
        itemBuilder: (context, index) => SizedBox(
          // height: MediaQuery.of(context).size.height,
          child: Container(
            // padding: EdgeInsets.only(top: 0),
            color: index % 2 == 0 ? Colors.yellow : Colors.white54,
            alignment: Alignment.center,
            child: Text('Item ${index + 1}'),
          ),
        ),
      ),

      // 消息页
      ListView.builder(
        physics: PageScrollPhysics(),
        itemCount: 10,
        itemBuilder: (context, index) => SizedBox(
          // height: MediaQuery.of(context).size.height,
          child: Container(
            // padding: EdgeInsets.only(top: 0),
            color: index % 2 == 0 ? Colors.purpleAccent : Colors.lightBlue,
            alignment: Alignment.center,
            child: Text('Item ${index + 1}'),
          ),
        ),
      ),
      // 我的页面
      ProfilePage_kqy(),
    ];
  }

  void _onItemTapped_kqy(int index) {
    setState(() {
      _bottomNavIndex = index;
      if (index != 0) {
        _tabController.index = 0; // 切换到默认的Tab页
      }
    });
  }


}

// 自定义的 Tab 组件
class CustomTab extends StatelessWidget {
  final String text;

  const CustomTab({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 可以在这里统一修改样式顶部跟底部导航航栏的字体大小
    return Tab(
      child: Text(
        text,
        style: TextStyle(fontSize: 24.0), // 统一样式
      ),
    );
  }
}

//发现页存储——kqy
class VideoNode {
  final String videoUrl;
  VideoNode? prev;
  VideoNode? next;

  VideoNode(this.videoUrl);
}

class VideoList {
  VideoNode? head;
  VideoNode? tail;
  int length = 0;

  void add(String videoUrl) {
    final newNode = VideoNode(videoUrl);
    if (head == null) {
      head = newNode;
      tail = newNode;
    } else {
      tail!.next = newNode;
      newNode.prev = tail;
      tail = newNode;
    }
    length++;
  }

  void extend(List<String> newVideos) {
    for (var video in newVideos) {
      add(video);
    }
  }

  VideoNode? getNodeAt(int index) {
    if (index < 0 || index >= length) return null;
    VideoNode? current = head;
    for (int i = 0; i < index; i++) {
      current = current?.next;
    }
    return current;
  }
}

class VideoController {
  VideoList videoList = VideoList();
  VideoNode? currentNode;

  VideoController() {
    // 初始化视频列表
    List<String> initialVideos = List.generate(10, (index) => '视频 $index');
    for (var video in initialVideos) {
      videoList.add(video);
    }
    currentNode = videoList.head;
  }

  String getCurrentVideoUrl() {
    return currentNode?.videoUrl ?? '';
  }

  void loadMoreVideos() {
    List<String> newVideos = List.generate(10, (index) => '视频 ${videoList.length + index}');
    videoList.extend(newVideos);
  }

  void moveToNext() {
    if (currentNode?.next != null) {
      currentNode = currentNode?.next;
    } else {
      // 如果到达尾部，加载更多视频
      loadMoreVideos();
      currentNode = videoList.getNodeAt(videoList.length - 10); // 回到新的第十个视频
    }
  }
}

//视频页无限加页面——kqy

class FindVideo_kqy extends StatefulWidget {
  @override
  _FindVideoState_kqy createState() => _FindVideoState_kqy();
}

class _FindVideoState_kqy extends State<FindVideo_kqy> {
  PageController _pageController = PageController();
  int _videoCount = 10;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(_pageListener);
  }

  void _pageListener() {
    if (_pageController.page!.toInt() == _videoCount - 1) {
      // 如果滚动到倒数第一个视频，加载更多
      setState(() {
        _videoCount += 5; // 示例增加更多视频
      });
    }
  }

  @override
  void dispose() {
    _pageController.removeListener(_pageListener);
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        itemCount: _videoCount,
        itemBuilder: (context, index) {
          return VideoPage(index: index,);
        },
        scrollDirection: Axis.vertical,
      ),
    );
  }
}

//视频播放

class VideoPage extends StatefulWidget {
  final int index;
  VideoPage({Key? key, required this.index}) : super(key: key);

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> with WidgetsBindingObserver {
  late VideoPlayerController _controller;
  bool _isShowPlayButton = false;
  List<Widget> _hearts = []; // 用于存储动态爱心的列表

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this); // 添加生命周期观察者
    _controller = VideoPlayerController.networkUrl(
      Uri.parse('https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'),
    )..initialize().then((_) {
      setState(() {}); // 确保初始化后显示第一帧
      _controller.setLooping(true); // 设置视频循环播放
      _controller.play(); // 自动播放
      _isShowPlayButton = false;
    });

    // 视频播放状态变化时的监听
    _controller.addListener(() {
      if (_controller.value.isPlaying) {
        if (_isShowPlayButton) {
          setState(() {
            _isShowPlayButton = false;
          });
        }
      } else {
        if (!_isShowPlayButton) {
          setState(() {
            _isShowPlayButton = true;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this); // 移除生命周期观察者
    _controller.dispose();
    _controller.pause(); // 暂停视频播放
    _controller.dispose(); // 释放控制器资源
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      if (_controller.value.isPlaying) {
        _controller.pause();
      }
    } else if (state == AppLifecycleState.resumed) {
      if (!_controller.value.isPlaying) {
        _controller.play();
      }
    }
  }

  void _togglePlayPause() {
    if (_controller.value.isPlaying) {
      _controller.pause();
    } else {
      _controller.play();
    }
    setState(() {
      _isShowPlayButton = !_controller.value.isPlaying;
    });
  }

  // 创建一个显示爱心的Widget
  Widget _buildHeart() {
    // 获取屏幕的大小
    final size = MediaQuery.of(context).size;
    // 生成随机位置
    final random = Random();
    final positionX = random.nextDouble() * size.width;
    final positionY = random.nextDouble() * size.height * 0.5; // 限制在上半部分

    return Positioned(
      left: positionX,
      top: positionY,
      child: Image.asset(
        'assets/heart.png',
        width: 50,
        height: 50,
        color: Colors.red,
      ),
    );
  }

  // 点击按钮时调用的方法
  void _handleLike() {
    setState(() {
      _hearts.add(_buildHeart());
    });

    // 动画效果
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _hearts.removeAt(0);
      });
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: _togglePlayPause,
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
            ),
          ),
          if (_isShowPlayButton)
            Center(
              child: IconButton(
                icon: Icon(
                  _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                  size: 100,
                ),
                onPressed: _togglePlayPause,
              ),
            ),

          Positioned(
            right: 16,
            top: MediaQuery.of(context).size.height * 0.3,
            child: Column(
              children: [
                SizedBox(height: 80),
                GestureDetector(
                  onTap: () {
                    // 导航到 ProfilePage
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfilePage()),
                    );
                  },
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/headPicture.png'),
                  ),
                ),
                Transform.translate(
                  offset: Offset(0, -20), // 向上移动图标
                  child: IconButton(
                    iconSize: 40,
                    icon: Icon(Icons.add_circle_outline, color: Colors.white),
                    onPressed: () {
                      _showSnackBar('关注成功');
                    },
                  ),
                ),
                Transform.translate(
                  offset: Offset(0, -20), // 向上移动点赞图标
                  child: IconButton(
                    iconSize: 40,
                    icon: Icon(Icons.thumb_up, color: Colors.white),
                    onPressed: _handleLike,
                  ),
                ),
                Transform.translate(
                  offset: Offset(0, -5), // 向上移动评论图标
                  child: IconButton(
                    iconSize: 40,
                    icon: Icon(Icons.comment, color: Colors.white),
                    onPressed: () => _showComments(context),
                  ),// 调用 _showComments 方法并传递 context                  ),
                ),
              ],
            ),
          ),





          Positioned(
            left: 16,
            bottom: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '九与鸟',
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  '来一波小狗🐶叫，很认真滴#鹦鹉🦜',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ),
          // 将爱心的列表添加到Stack中
          ..._hearts,
        ],
      ),
    );
  }
}

// 博主页带关注
class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isFollowing = false; // 关注状态

  final String backgroundImage = 'https://via.placeholder.com/800x400'; // 背景图URL
  final String avatarImage = 'https://via.placeholder.com/80'; // 头像图URL
  final String username = '用户名';
  final String userId = '用户ID';
  final int likesCount = 123;
  final int followersCount = 456;
  final int followingCount = 78;
  final String signature = '这是一段个性签名';
  final int worksCount = 5;

  void toggleFollow() {
    setState(() {
      isFollowing = !isFollowing; // 切换关注状态
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // 背景图
            Image.network(
              backgroundImage,
              fit: BoxFit.cover,
              height: 250,
              width: double.infinity,
            ),
            // 内容部分
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10), // 留出返回键的位置
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.black), // 改为黑色
                        onPressed: () {
                          Navigator.pop(context); // 返回上一页
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 8), // 为头像留出一些空间
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(avatarImage),
                      ),
                      SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(username, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white)),
                          Text(userId, style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 66),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text('$likesCount', style: TextStyle(fontSize: 24, color: Colors.black)),
                          Text('获赞数', style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                      Column(
                        children: [
                          Text('$followersCount', style: TextStyle(fontSize: 24, color: Colors.black)),
                          Text('粉丝', style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                      Column(
                        children: [
                          Text('$followingCount', style: TextStyle(fontSize: 24, color: Colors.black)),
                          Text('关注', style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(signature, style: TextStyle(color: Colors.white)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center, // 居中对齐
                    children: [
                      SizedBox(
                        width: 160, // 增大按钮宽度
                        child: ElevatedButton(
                          onPressed: toggleFollow,
                          child: Text(isFollowing ? '已关注' : '关注'),
                        ),
                      ),
                      SizedBox(width: 40), // 减少间距
                      SizedBox(
                        width: 160, // 增大按钮宽度
                        child: ElevatedButton(
                          onPressed: () {
                            // 处理私信逻辑
                          },
                          child: Text('私信'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text('作品', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
                  SizedBox(height: 10),
                  GridView.builder(
                    shrinkWrap: true, // 使 GridView 可以嵌套在 Column 中
                    physics: NeverScrollableScrollPhysics(), // 防止 GridView 滚动
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1,
                    ),
                    itemCount: worksCount,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Center(child: Text('作品 ${index + 1}')),
                      );
                    },
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






// 视频评论区
class Comment {
  final String username; // 用户名
  final String avatarUrl; // 头像链接
  final String text; // 评论文本
  final DateTime timestamp; // 时间戳
  int likes; // 点赞数

  Comment(this.username, this.avatarUrl, this.text, this.timestamp, {this.likes = 0});
}

// 显示评论的函数
void _showComments(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // 允许控制底部弹出框的高度
    builder: (context) {
      return ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)), // 设置圆角
        child: Container(
          height: MediaQuery.of(context).size.height * 0.5, // 高度为屏幕的50%
          child: CommentsPage(), // 显示评论页面
        ),
      );
    },
  );

}

// 定义评论页面类
class CommentsPage extends StatefulWidget {
  @override
  _CommentsPageState createState() => _CommentsPageState(); // 创建状态
}

// 评论页面的状态类
class _CommentsPageState extends State<CommentsPage> {
  final List<Comment> _comments = []; // 评论列表
  final TextEditingController _controller = TextEditingController(); // 文本输入控制器

  // 添加评论的方法
  void _addComment() {
    if (_controller.text.isNotEmpty) { // 检查输入是否为空
      setState(() {
        // 添加新评论到列表
        _comments.add(Comment('用户${_comments.length + 1}',
            'https://via.placeholder.com/40',
            _controller.text,
            DateTime.now())); // 使用当前时间作为时间戳
        _controller.clear(); // 清空输入框
      });
    }
  }

  // 删除评论的方法
  void _deleteComment(int index) {
    setState(() {
      _comments.removeAt(index); // 从列表中删除指定索引的评论
    });
  }

  // 点赞评论的方法
  void _likeComment(int index) {
    setState(() {
      _comments[index].likes++; // 增加评论的点赞数
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: _comments.length, // 列表项的数量
            itemBuilder: (context, index) {
              final comment = _comments[index]; // 获取当前评论
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(comment.avatarUrl), // 显示用户头像
                ),
                title: Text(comment.username), // 显示用户名
                subtitle: Text(comment.text), // 显示评论文本
                trailing: Row(
                  mainAxisSize: MainAxisSize.min, // 设置行的最小宽度
                  children: [
                    IconButton(
                      icon: Icon(Icons.thumb_up), // 点赞图标
                      onPressed: () => _likeComment(index), // 点赞时调用相应方法
                    ),
                    Text('${comment.likes}'), // 显示点赞数
                    IconButton(
                      icon: Icon(Icons.delete), // 删除图标
                      onPressed: () => _deleteComment(index), // 删除时调用相应方法
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0), // 设置边距
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller, // 绑定输入控制器
                  decoration: InputDecoration(
                    hintText: '输入评论...', // 输入框提示文字
                    border: OutlineInputBorder(), // 设置边框样式
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send), // 发送图标
                onPressed: _addComment, // 点击发送时调用添加评论的方法
              ),
            ],
          ),
        ),
      ],
    );
  }
}






//个人信息页——kqy


class ProfilePage_kqy extends StatefulWidget {
  @override
  _ProfilePageState_kqy createState() => _ProfilePageState_kqy();
}

class _ProfilePageState_kqy extends State<ProfilePage_kqy> {
  String _currentTab = '喜欢';

  // 预留的接口函数
  Future<void> _fetchUserData() async {
    // 这里调用后端接口
    // await ApiService.getUserData();
  }

  @override
  void initState() {
    super.initState();
    _fetchUserData(); // 初始化时获取用户数据
  }

  void _onTabChanged(String tab) {
    setState(() {
      _currentTab = tab;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 背景图层（只显示在上半部分）
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 250, // 根据需要设置背景高度
            child: Image.asset(
              'assets/bei.png',
              fit: BoxFit.cover,
            ),
          ),
          // 内容层
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 头像
                  Center(
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage('assets/headPicture.png'), // 头像照片
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey, width: 2),
                          ),
                          child: IconButton(
                            icon: Icon(Icons.camera_alt, color: Colors.black),
                            onPressed: () {
                              // 处理点击事件
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  // 用户名
                  Center(
                    child: Text(
                      '九与鸟  ID:123456',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 8),
                  // 简介
                  Center(
                    child: Text(
                      '本人是一名爱鸟人士，经营一家宠物店',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 16),
                  // 关注数
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildStatColumn('关注', '100'),
                      _buildStatColumn('粉丝', '200'),
                      _buildStatColumn('作品', '300'),
                    ],
                  ),
                  SizedBox(height: 16),
                  // 按钮
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // 处理点击事件
                          },
                          child: Text('编辑个人资料'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  // 喜欢收藏导航栏
                  Container(
                    margin: EdgeInsets.only(bottom: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildNavItem('喜欢'),
                        _buildNavItem('收藏'),
                      ],
                    ),
                  ),
                  // 色块布局
                  Container(
                    height: 700, // 设置色块布局的高度，避免与其他内容重叠
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                      ),
                      itemCount: 12, // 8行3列总共24个色块
                      itemBuilder: (context, index) {
                        return Container(
                          color: _currentTab == '喜欢'
                              ? Colors.primaries[index % Colors.primaries.length]
                              : Colors.accents[index % Colors.accents.length],
                          height: 100, // 设置色块的高度
                          width: double.infinity, // 使色块宽度填充满列
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatColumn(String title, String value) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(title, style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildNavItem(String title) {
    return GestureDetector(
      onTap: () => _onTabChanged(title),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: _currentTab == title ? Colors.black : Colors.grey,
            ),
          ),
          if (_currentTab == title)
            Container(
              margin: EdgeInsets.only(top: 4),
              width: 20,
              height: 2,
              color: Colors.black,
            ),
        ],
      ),
    );
  }
}
