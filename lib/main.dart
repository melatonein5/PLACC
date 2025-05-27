import 'package:flutter/material.dart';
// Core project imports
import 'package:placc/craftable_list.dart'; // Your widget for displaying the list
import 'package:placc/recipes.dart'; // Contains CraftableItem and other core classes

// NEW: Import for the item type enum
import 'package:placc/models/craftable_item_type.dart';
import 'package:placc/utils/craftable_item_search_delegate.dart';

// NEW: Import the url_launcher package
import 'package:url_launcher/url_launcher.dart'; // <--- NEW IMPORT

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const ColorScheme customColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Colors.red,
    onPrimary: Colors.white,
    secondary: Color(0xFF3b4cca),
    onSecondary: Color(0xFFB3A125),
    error: Colors.red,
    onError: Colors.white,
    surface: Colors.white,
    onSurface: Colors.black,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PLACC',
      theme: ThemeData(
        colorScheme: customColorScheme,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
        ),
      ),
      home: const MyHomePage(title: 'Pokémon Legends: Arceus Crafting Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final List<CraftableItem> _allCraftableItems;
  List<CraftableItem> _filteredCraftableItems = [];
  CraftableItemType _selectedFilterType = CraftableItemType.all;

  @override
  void initState() {
    super.initState();
    _allCraftableItems = [
      // Poké Balls
      PokeBall(),
      GreatBall(),
      UltraBall(),
      HeavyBall(),
      LeadenBall(),
      GigatonBall(),
      FeatherBall(),
      WingBall(),
      JetBall(),

      // Cakes
      MushroomCake(),
      HoneyCake(),
      GrainCake(),
      BeanCake(),
      SaltCake(),

      // Bombs
      SmokeBomb(),
      ScatterBang(),

      OldGateau(),
    ];

    _filterItems(); // Apply the initial filter (all items by default)
  }

  /// Filters the [_allCraftableItems] based on [_selectedFilterType].
  void _filterItems() {
    setState(() {
      if (_selectedFilterType == CraftableItemType.all) {
        _filteredCraftableItems = List.from(_allCraftableItems);
      } else {
        _filteredCraftableItems = _allCraftableItems
            .where((item) => item.itemTypes.contains(_selectedFilterType))
            .toList();
      }
    });
  }

  // --- NEW: Function to launch URLs ---
  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url)) {
      // Show an error message if the URL cannot be launched
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $urlString')),
      );
    }
  }

   void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('About PLACC'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Pokémon Legends: Arceus Crafting Calculator (PLACC)\n\n'
                  'Version: 1.0.0\n'
                  'Developed by Joseph McCallum-Nattrass\n\n'
                  'This app helps you calculate crafting costs and manage recipes for Pokémon Legends: Arceus.\n\n'
                  'All data is based on in-game information from Jublife Village crafting shop prices and recipes.\n\n'
                  'Disclaimer: This is a fan-made application and is not affiliated with Nintendo, Game Freak, or The Pokémon Company.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Text(
                  'Special Thanks:',
                  style: Theme.of(context).textTheme.titleSmall,
                  textAlign: TextAlign.center,
                ),
                Text('/u/epsilon12 for their Google Sheets Crafting Calculator', textAlign: TextAlign.center),
                Text('lichen on Eevee Expo for their Sprite Pack', textAlign: TextAlign.center),
                Text('Bulbapedia for their sprites', textAlign: TextAlign.center),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Text(
                'Crafting Categories',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.apps),
              title: const Text('All Items'),
              onTap: () {
                setState(() {
                  _selectedFilterType = CraftableItemType.all;
                  _filterItems();
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.sports_baseball),
              title: const Text('Poké Balls'),
              onTap: () {
                setState(() {
                  _selectedFilterType = CraftableItemType.pokeball;
                  _filterItems();
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.cake),
              title: const Text('Cakes'),
              onTap: () {
                setState(() {
                  _selectedFilterType = CraftableItemType.cake;
                  _filterItems();
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.local_fire_department),
              title: const Text('Bombs'),
              onTap: () {
                setState(() {
                  _selectedFilterType = CraftableItemType.bomb;
                  _filterItems();
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.medication),
              title: const Text('Medicine'),
              onTap: () {
                setState(() {
                  _selectedFilterType = CraftableItemType.medicine;
                  _filterItems();
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),

      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        title: GestureDetector(
          onTap: () {
            showSearch(
              context: context,
              delegate: CraftableItemSearchDelegate(_allCraftableItems),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2), // Corrected: Use .withOpacity
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Row(
              children: [
                const Icon(Icons.search, color: Colors.white),
                const SizedBox(width: 8.0),
                Text(
                  'Search items...',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white70),
                ),
              ],
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              _showAboutDialog();
            },
            tooltip: 'About',
          ),
          IconButton(
            icon: const Icon(Icons.public),
            onPressed: () {
              // --- NEW: Bluesky link functionality ---
              _launchUrl('https://bsky.app/profile/jmnetwork.uk'); // Replace with actual Bluesky link
            },
            tooltip: 'Bluesky',
          ),
          IconButton(
            icon: const Icon(Icons.code),
            onPressed: () {
              // --- NEW: GitHub link functionality ---
              _launchUrl('https://github.com/melatonein5/PLACC'); // Replace with actual GitHub link
            },
            tooltip: 'GitHub',
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Available Recipes:',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          const Divider(),
          Expanded(
            child: CraftableList(items: _filteredCraftableItems),
          ),
          const Divider(),
        ],
      ),
    );
  }
}