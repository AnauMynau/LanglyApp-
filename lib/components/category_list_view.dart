import 'package:flutter/material.dart';

class CategoryListView extends StatelessWidget {
  final String selectedLanguage;
  final Function(String) onLanguageSelected;

  const CategoryListView({
    super.key,
    required this.languages,
    required this.selectedLanguage,
    required this.onLanguageSelected,
  });

  final List<String> languages;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: languages.length,
        separatorBuilder: (context, index) => const SizedBox(width: 15),
        itemBuilder: (context, index) {
          final lang = languages[index];
          final isSelected = selectedLanguage == lang;

          String flagPath = lang == 'All'
              ? 'assets/flags/all.jpg'
              : 'assets/flags/${lang.toLowerCase()}.jpg';

          return GestureDetector(
            onTap: () => onLanguageSelected(lang),
            child: Column(
              children: [
                Container(
                  width: 70,
                  height: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? Colors.lightBlue : Colors.grey[300]!,
                      width: isSelected ? 3 : 1,
                    ),
                    image: DecorationImage(
                      image: AssetImage(flagPath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  lang,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight:
                    isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}