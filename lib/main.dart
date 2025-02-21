import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Game Dev Learning',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const FirstScreen(),
    );
  }
}

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  FirstScreenState createState() => FirstScreenState();
}

class FirstScreenState extends State<FirstScreen> {
  late Future<void> _loadDataFuture;

  @override
  void initState() {
    super.initState();
    _loadDataFuture = _loadData();
  }

  Future<void> _loadData() async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate a network call
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Game Development Guide',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder(
        future: _loadDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  'Image/gameDev.png',
                  width: 600,
                  height: 240,
                  fit: BoxFit.cover,
                ),
                const TitleSection(
                  title: 'Master Game Development',
                  subtitle: 'Essential Skills for Future Game Creators',
                ),
                ButtonSection(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SecondScreen(),
                      ),
                    );
                  },
                ),
                Column(
                  children: [
                    SizedBox(height: 16), // Відступ зверху 16px
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        24.0,
                        5.0,
                        24.0,
                        5.0,
                      ), // Відступи по боках та зверху
                      child: Text(
                        'Dive into the world of game development by learning the core concepts such as game engines, AI, physics, and design. Whether you are an indie developer or a professional, understanding these fundamentals will help you build amazing games.',
                        textAlign:
                            TextAlign
                                .justify, // Вирівнювання тексту (опціонально)
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  final List<String> gameDevTopics = const [
    'Game Engines',
    '2D vs 3D Game Development',
    'Game Physics',
    'Artificial Intelligence in Games',
    'Game Design Principles',
    'Networking in Multiplayer Games',
    'Virtual Reality and AR',
    'Game Monetization Strategies',
    'Shader Programming',
    'Level Design',
    'Character Animation',
    'Sound Design for Games',
    'UI/UX in Games',
    'Game Prototyping',
    'Storytelling in Games',
    'Performance Optimization',
    'Indie Game Development',
    'Mobile vs PC Game Development',
    'Game Marketing & Publishing',
    'Ethics in Game Development',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Game Dev Topics')),
      body: ListView.builder(
        itemCount: gameDevTopics.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: Colors.deepPurple.shade50,
            child: ListTile(
              leading: const Icon(
                Icons.videogame_asset,
                color: Colors.deepPurple,
              ),
              title: Text(
                gameDevTopics[index],
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: const Text(
                'Essential knowledge for every game developer.',
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.deepPurple,
              ),
            ),
          );
        },
      ),
    );
  }
}

class TitleSection extends StatelessWidget {
  const TitleSection({super.key, required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                Text(subtitle, style: TextStyle(color: Colors.grey[600])),
              ],
            ),
          ),
          const FavoriteWidget(),
        ],
      ),
    );
  }
}

class ButtonSection extends StatelessWidget {
  final VoidCallback onPressed;
  const ButtonSection({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        textStyle: const TextStyle(fontSize: 18),
      ),
      child: const Text(
        'Discover Game Dev Topics',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

class FavoriteWidget extends StatefulWidget {
  const FavoriteWidget({super.key});

  @override
  State<FavoriteWidget> createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  bool _isFavorited = false;
  int _favoriteCount = 99;

  void _toggleFavorite() {
    setState(() {
      _isFavorited = !_isFavorited;
      _favoriteCount += _isFavorited ? 1 : -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon:
              _isFavorited
                  ? const Icon(Icons.star)
                  : const Icon(Icons.star_border),
          color: Colors.red[500],
          onPressed: _toggleFavorite,
        ),
        Text('$_favoriteCount'),
      ],
    );
  }
}
