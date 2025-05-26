
import 'package:flutter/material.dart';
import 'package:placc/recipes.dart';
import 'package:placc/crafting_input.dart';

class CraftableList extends StatelessWidget {
  final List<CraftableItem> items;

  const CraftableList({super.key, required this.items});

 
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length, // Tell the list how many items to build
      itemBuilder: (BuildContext context, int index) {
        // Get the current CraftableItem based on the index
        final CraftableItem item = items[index];

        return Card( // Provides a nice visual container for each item
          margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          child: InkWell( // Adds a ripple effect when tapped, indicating interactivity
            onTap: () {
             // Populate the CraftingInputDialog with the selected item
              showDialog(
                context: context,
                builder: (context) {
                  return CraftingInputDialog(itemToCraft: item);
                },
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  // Display the CraftableItem.icon
                  SizedBox(
                    width: 60, // Set a fixed width for the icon
                    height: 60, // Set a fixed height for the icon
                    child: item.icon, // Your Image widget
                  ),
                  const SizedBox(width: 16), // Add some spacing between the icon and text

                  // Display the CraftableItem.name
                  Expanded( // Ensures the text takes up available space and handles overflow
                    child: Text(
                      item.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis, // Add "..." if the name is too long
                    ),
                  ),

                  // OPTIONAL: Add a trailing icon, e.g., an arrow to indicate more details
                  const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}