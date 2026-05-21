import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/app_state_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _followingCount = 21;

  void _updateFollowingCount(bool isAdding) {
    setState(() {
      if (isAdding) {
        _followingCount++;
      } else {
        _followingCount--;
      }
    });
  }

  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppStateManager>(context);
    final displayUsername = appState.username.isEmpty ?
    'Student' : appState.username;

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        title: Text(
          displayUsername,
          style: GoogleFonts.lato(
            color: Colors.black87,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
                Icons.settings_outlined, color: Colors.black87, size: 28),
            onPressed: () {},
          ),
          const SizedBox(width: 10),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),

            const Hero(
              tag: 'user_avatar',
              child: CircleAvatar(
                radius: 70,
                backgroundColor: Colors.lightBlue,
                child: Icon(Icons.person, size: 80, color: Colors.white),
              ),
            ),

            const SizedBox(height: 15),

            Text(
              '@${displayUsername.toUpperCase()} · JOINED 2026',
              style: GoogleFonts.lato(
                  color: Colors.grey[600],
                  fontSize: 13,
                  fontWeight: FontWeight.bold
              ),
            ),

            const SizedBox(height: 25),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      const Icon(Icons.flag, color: Colors.amber, size: 30),
                      Text(
                          'Courses',
                          style: GoogleFonts.lato(
                              color: Colors.grey[600], fontSize: 13
                          )
                      ),
                    ],
                  ),

                  Container(width: 1, height: 40, color: Colors.grey[300]),

                  _buildStatColumn(_followingCount.toString(), 'Following'),
                  _buildStatColumn('33', 'Followers'),
                ],
              ),
            ),

            const SizedBox(height: 30),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton.icon(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => _buildAddFriendsSheet(context),
                  );
                },
                icon: const Icon(Icons.group_add_rounded),
                label: const Text(
                    '+ ADD FRIENDS', style: TextStyle(fontSize: 16)
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD81B60),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 0,
                ),
              ),
            ),

            const SizedBox(height: 35),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey[200]!, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Achievements',
                      style: GoogleFonts.lato(
                          color: Colors.black87,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(height: 15),
                    const LinearProgressIndicator(
                      value: 0.6,
                      backgroundColor: Color(0xFFEEEEEE),
                      color: Colors.orange,
                      minHeight: 10,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    const SizedBox(height: 10),
                    Text(
                        '60/100 points for next level',
                        style: GoogleFonts.lato(
                            color: Colors.grey[600],
                            fontSize: 13
                        )
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                    ),
                    tileColor: Colors.grey[50],
                    leading: const Icon(Icons.language, color: Colors.blue),
                    title: const Text(
                        'Visit Flutter Website',
                        style: TextStyle(fontWeight: FontWeight.w500)
                    ),
                    trailing: const Icon(
                        Icons.open_in_new,
                        size: 20,
                        color: Colors.grey
                    ),
                    onTap: () {
                      _launchURL('https://flutter.dev');
                    },
                  ),
                  const SizedBox(height: 10),
                  ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                    ),
                    tileColor: Colors.red[50],
                    leading: const Icon(Icons.logout, color: Colors.red),
                    title: const Text(
                        'Log out',
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold
                        )
                    ),
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();

                      if (!mounted) return;
                      Provider.of<AppStateManager>(
                          context, listen: false
                      ).logout();

                      context.go('/login');
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 120),
          ],
        ),
      ),
    );
  }

  Widget _buildStatColumn(String count, String label) {
    return Column(
      children: [
        Text(
          count,
          style: GoogleFonts.lato(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.lato(color: Colors.grey[600], fontSize: 13),
        ),
      ],
    );
  }

  Widget _buildAddFriendsSheet(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30)
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10)
                )
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  'Find Friends',
                  style: GoogleFonts.lato(
                      color: Colors.black87,
                      fontSize: 24,
                      fontWeight: FontWeight.bold)
              ),
              IconButton(icon: const Icon(
                  Icons.close,
                  color: Colors.black54
              ), onPressed: () => Navigator.pop(context)
              ),
            ],
          ),
          const SizedBox(height: 15),
          TextField(
            style: const TextStyle(color: Colors.black87),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[100],
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              hintText: 'Enter username or email',
              hintStyle: TextStyle(color: Colors.grey[400]),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _FriendSearchItem(
                    name: 'Dulat',
                    status: 'Learn Grammar',
                    onFollowChanged: _updateFollowingCount,
                  ),
                  _FriendSearchItem(
                    name: 'Alizhan',
                    status: 'Business Meetings',
                    onFollowChanged: _updateFollowingCount,
                  ),
                  _FriendSearchItem(
                    name: 'Maksat',
                    status: 'Food Vocabulary',
                    onFollowChanged: _updateFollowingCount,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _FriendSearchItem extends StatefulWidget {
  final String name;
  final String status;
  final Function(bool) onFollowChanged;

  const _FriendSearchItem({
    required this.name,
    required this.status,
    required this.onFollowChanged,
  });

  @override
  State<_FriendSearchItem> createState() => _FriendSearchItemState();
}

class _FriendSearchItemState extends State<_FriendSearchItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isFollowing = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 150), vsync: this);
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeOut)
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(_FriendSearchItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const CircleAvatar(
              backgroundColor: Colors.green, child: Icon(
              Icons.person,
              color: Colors.white)
          ),
          title: Text(
              widget.name,
              style: GoogleFonts.lato(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold
              )
          ),
          subtitle: Text(
              widget.status,
              style: GoogleFonts.lato(
                  color: Colors.grey[600], fontSize: 12
              )
          ),

          trailing: ScaleTransition(
            scale: _scaleAnimation,
            child: TextButton(
              onPressed: () {
                setState(() {
                  _isFollowing = !_isFollowing;
                });
                widget.onFollowChanged(_isFollowing);
              },
              style: TextButton.styleFrom(
                backgroundColor: _isFollowing ?
                Colors.grey[200] : Colors.blue[50],
                foregroundColor: _isFollowing ?
                Colors.black54 : Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
              ),
              child: Text(
                _isFollowing ? 'Following' : '+ FOLLOW',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        Divider(color: Colors.grey[200]),
      ],
    );
  }
}