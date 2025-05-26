import 'package:flutter/material.dart';
import 'package:placc/crafting_result.dart';
import 'package:placc/recipes.dart'; // Assuming CraftableItem, Totals, etc. are here

enum InputMode { budget, quantity }

class CraftingInputDialog extends StatefulWidget {
  final CraftableItem itemToCraft;

  const CraftingInputDialog({super.key, required this.itemToCraft});

  @override
  State<CraftingInputDialog> createState() => _CraftingInputDialogState();
}

class _CraftingInputDialogState extends State<CraftingInputDialog> {
  InputMode _selectedMode = InputMode.budget;
  final TextEditingController _inputController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Key for form validation

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  void _handleCalculate() {
    if (_formKey.currentState?.validate() ?? false) {
      final int? inputValue = int.tryParse(_inputController.text);

      if (inputValue == null || inputValue <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter a valid positive number.')),
        );
        return;
      }

      Totals result;
      if (_selectedMode == InputMode.budget) {
        result = widget.itemToCraft.calculateTotalByBudget(inputValue);
      } else { // InputMode.quantity
        result = widget.itemToCraft.calculateTotalByQuantity(inputValue);
      }

      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) {
          return CraftingResultDialog(totals: result, itemCrafted: widget.itemToCraft);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Media query to ensure keyboard doesn't hide content in a dialog
    final mediaQuery = MediaQuery.of(context);
    final bottomPadding = mediaQuery.viewInsets.bottom;

    return Dialog( // Using Dialog widget directly
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Padding(
        padding: EdgeInsets.only(
          bottom: bottomPadding + 16.0, // Add bottom padding to prevent keyboard overlap + dialog margin
          left: 16.0,
          right: 16.0,
          top: 16.0,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min, // Make column only as big as its children
            crossAxisAlignment: CrossAxisAlignment.center, // Center contents horizontally
            children: [
              // Close button at the top right
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context); // Pop back to the list
                  },
                ),
              ),
              // Item Icon and Name (displayed above the input section)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 80, // Larger icon for the dialog header
                    height: 80,
                    child: widget.itemToCraft.icon,
                  ),
                  const SizedBox(width: 16),
                  Flexible( // Use Flexible to prevent text overflow
                    child: Text(
                      widget.itemToCraft.name,
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Toggle buttons for input mode
              Center(
                child: ToggleButtons(
                  isSelected: [
                    _selectedMode == InputMode.budget,
                    _selectedMode == InputMode.quantity,
                  ],
                  onPressed: (int index) {
                    setState(() {
                      _selectedMode = index == 0 ? InputMode.budget : InputMode.quantity;
                      _inputController.clear(); // Clear input when mode changes
                    });
                  },
                  children: const <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text('Max Budget'),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text('Max Quantity'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Text input field
              TextFormField(
                controller: _inputController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: _selectedMode == InputMode.budget
                      ? 'Enter Max Budget'
                      : 'Enter Max Quantity',
                  border: const OutlineInputBorder(),
                  prefixIcon: _selectedMode == InputMode.budget
                      ? const Icon(Icons.attach_money)
                      : const Icon(Icons.numbers),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a value';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  if (int.parse(value) <= 0) {
                    return 'Value must be positive';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // Calculate & Craft button
              ElevatedButton(
                onPressed: _handleCalculate,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16.0),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                ),
                child: const Text(
                  'Calculate',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
