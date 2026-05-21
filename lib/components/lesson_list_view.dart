import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as old_provider;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/app_cache.dart';
import '../models/app_state_manager.dart';
import '../models/lesson.dart';
import '../providers.dart';
import '../screens/favorites_screen.dart';
import 'card1.dart';

class LessonListView extends ConsumerStatefulWidget {
  final List<Lesson> lessons;
  final VoidCallback onThemeToggle;

  const LessonListView({
    super.key,
    required this.lessons,
    required this.onThemeToggle,
  });

  @override
  ConsumerState<LessonListView> createState() => _LessonListViewState();
}

class _LessonListViewState extends ConsumerState<LessonListView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String _activeSearch = '';
  final SearchController _searchController = SearchController();

  // --- ANIMATION 1: Variable for screen transparency ---
  double _currentOpacity = 0.0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 150), () {
      if (mounted) {
        setState(() {
          _currentOpacity = 1.0;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final planManager = ref.watch(planManagerProvider);
    final count = planManager.cartItems.length;

    final appState = old_provider.Provider.of<AppStateManager>(
        context, listen: false
    );
    final currentLang = old_provider.Provider.of<AppStateManager>(context)
        .selectedLanguage;

    var filteredLessons = currentLang == 'All'
        ? widget.lessons
        : widget.lessons.where((l) => l.language == currentLang).toList();

    if (_activeSearch.isNotEmpty) {
      filteredLessons = filteredLessons.where((l) =>
          l.title.toLowerCase().contains(_activeSearch.toLowerCase())
      ).toList();
    }

    final languages = ['All', ...widget.lessons.map((l) => l.language).toSet()];

    return Scaffold(
      key: _scaffoldKey,

      // --- ANIMATION 1: Wrapping the entire ScrollView in AnimatedOpacity ---
      body: AnimatedOpacity(
        opacity: _currentOpacity,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              expandedHeight: 120.0,
              pinned: true,
              backgroundColor: Theme.of(context).primaryColor,
              actions: [
                IconButton(
                  icon: const Icon(Icons.favorite, color: Colors.white),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FavoritesScreen()
                      ),
                    );
                  },
                ),
                // --- ANIMATION 2: Smooth change of theme icons with rotation
                IconButton(
                  onPressed: widget.onThemeToggle,
                  icon: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    transitionBuilder: (
                        Widget child, Animation<double> animation
                        )
                    {
                      return ScaleTransition(
                        scale: animation,
                        child: RotationTransition(
                          turns: animation,
                          child: child,
                        ),
                      );
                    },
                    child: Icon(
                      Theme.of(context).brightness == Brightness.dark
                          ? Icons.nightlight_round
                          : Icons.wb_sunny,
                      key: ValueKey<Brightness>(Theme.of(context).brightness),
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
              flexibleSpace: const FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  'Langly',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Container(
                height: 130,
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: languages.length,
                  itemBuilder: (context, index) {
                    final lang = languages[index];
                    final isSelected = currentLang == lang;
                    String flagPath = lang == 'All'
                        ? 'assets/flags/all.jpg'
                        : 'assets/flags/${lang.toLowerCase()}.jpg';

                    return GestureDetector(
                      onTap: () => appState.changeLanguage(lang),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Column(
                          children: [
                            // --- ANIMATION 3: Smooth increase of the flag ---
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeOut,
                              width: isSelected ? 80 : 70,
                              height: isSelected ? 65 : 55,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    isSelected ? 16 : 12
                                ),
                                border: Border.all(
                                  color: isSelected ? Colors
                                      .lightBlue : Colors.grey[300]!,
                                  width: isSelected ? 3 : 1,
                                ),
                                boxShadow: isSelected
                                    ? [const BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 6,
                                    offset: Offset(0, 4)
                                )]
                                    : [],
                                image: DecorationImage(
                                  image: AssetImage(flagPath),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(lang, style: TextStyle(
                                fontSize: 12,
                                fontWeight: isSelected ? FontWeight
                                    .bold : FontWeight.normal
                            )),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // Search and History
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: SearchAnchor(
                  searchController: _searchController,
                  viewOnSubmitted: (value) {
                    if (value.trim().isNotEmpty) {
                      appState.addSearchTerm(value.trim());
                      setState(() => _activeSearch = value.trim());
                      _searchController.closeView(value);
                    }
                  },
                  builder: (context, controller) {
                    return SearchBar(
                      controller: controller,
                      onTap: () => controller.openView(),
                      onChanged: (value) {
                        if (value.isEmpty) setState(() => _activeSearch = '');
                      },
                      leading: const Icon(Icons.search, color: Colors.grey),
                      hintText: 'Search courses (e.g. Grammar)',
                      trailing: _activeSearch.isNotEmpty ? [
                        IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            controller.clear();
                            setState(() => _activeSearch = '');
                          },
                        )
                      ] : null,
                    );
                  },
                  suggestionsBuilder: (context, controller) {
                    final history = appState.searchHistory;
                    return [
                      if (history.isEmpty)
                        const Padding(
                          padding: EdgeInsets.all(20),
                          child: Center(child: Text('No recent searches',
                              style: TextStyle(color: Colors.grey))),
                        )
                      else
                        ...history.map((term) => ListTile(
                          leading: const Icon(Icons.history),
                          title: Text(term),
                          onTap: () {
                            controller.closeView(term);
                            setState(() => _activeSearch = term);
                          },
                        )).toList(),
                    ];
                  },
                ),
              ),
            ),

            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 15),
                child: Text('Courses for you', style: TextStyle(
                    fontSize: 24, fontWeight: FontWeight.bold)
                ),
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.8,
                ),
                delegate: SliverChildBuilderDelegate(
                      (context, index) => Card1(lesson: filteredLessons[index]),
                  childCount: filteredLessons.length,
                ),
              ),
            ),

            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 30, 20, 10),
                child: Text("Friend's Activity",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold
                    )
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: SizedBox(
                height: 110,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 260,
                      margin: const EdgeInsets.only(right: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8, offset: const Offset(0, 4))],
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                              backgroundColor: Theme.of(context).primaryColor,
                              child: const Icon(
                                  Icons.person, color: Colors.white
                              )
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(index % 2 == 0 ?
                                'Inayat finished "Reading"' :
                                'Maksat started "Greetings"',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13
                                    )
                                ),
                                const Text('Just now', style: TextStyle(
                                    color: Colors.grey, fontSize: 11)
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                              Icons.bolt, color: Colors.orange, size: 20
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 120)),
          ],
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Scaffold.of(context).openEndDrawer(),
        backgroundColor: const Color(0xFF06B6D4),
        icon: const Icon(Icons.assignment_turned_in, color: Colors.white),
        label: Text(
          '$count Lessons in plan',
          style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}