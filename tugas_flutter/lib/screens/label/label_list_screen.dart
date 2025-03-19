import 'package:flutter/material.dart';
import 'package:flutter_todo_app/screens/label/label_form_screen.dart';
import 'package:provider/provider.dart';
import '../../providers/label_provider.dart';
import '../../widgets/label_chip.dart';
import '../../widgets/custom_app_bar.dart';

class LabelListScreen extends StatelessWidget {
  const LabelListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Labels'),
      body: Consumer<LabelProvider>(
        builder: (context, labelProvider, _) {
          if (labelProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (labelProvider.error != null) {
            return Center(child: Text('Error: ${labelProvider.error}'));
          }
          return ListView.builder(
            itemCount: labelProvider.labels.length,
            itemBuilder: (context, index) {
              final label = labelProvider.labels[index];
              return LabelChip(label: label);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to Label Form Screen
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => const LabelFormScreen()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
