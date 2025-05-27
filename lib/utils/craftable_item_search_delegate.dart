// lib/utils/craftable_item_search_delegate.dart

import 'package:flutter/material.dart';
import 'package:placc/recipes.dart';
import 'package:placc/craftable_list.dart';

// --- CRUCIAL CHANGE: Change SearchDelegate<CraftableItem> to SearchDelegate<void> ---
class CraftableItemSearchDelegate extends SearchDelegate<void> {
  final List<CraftableItem> allCraftableItems;

  CraftableItemSearchDelegate(this.allCraftableItems);

  // --- buildLeading: Icon on the left of the search bar (e.g., back arrow) ---
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null); // Now valid because the type is void
      },
    );
  }

  // --- buildActions: Icons on the right of the search bar (e.g., clear query) ---
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          if (query.isEmpty) {
            close(context, null); // Now valid because the type is void
          } else {
            query = '';
          }
        },
      ),
    ];
  }

  // --- buildResults: What to display when the user submits a search ---
  @override
  Widget buildResults(BuildContext context) {
    final List<CraftableItem> searchResults = allCraftableItems
        .where((item) =>
            item.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (searchResults.isEmpty) {
      return Center(
        child: Text(
          'No results found for "$query"',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      );
    }

    return CraftableList(items: searchResults);
  }

  // --- buildSuggestions: What to display as the user types ---
  @override
  Widget buildSuggestions(BuildContext context) {
    final List<CraftableItem> suggestionList = query.isEmpty
        ? []
        : allCraftableItems
            .where((item) =>
                item.name.toLowerCase().contains(query.toLowerCase()))
            .toList();

    if (suggestionList.isEmpty && query.isNotEmpty) {
      return Center(
        child: Text(
          'No suggestions for "$query"',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      );
    }

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        final CraftableItem item = suggestionList[index];
        return ListTile(
          leading: SizedBox(width: 40, height: 40, child: item.icon),
          title: Text(item.name),
          onTap: () {
            query = item.name;
            showResults(context);
          },
        );
      },
    );
  }
}