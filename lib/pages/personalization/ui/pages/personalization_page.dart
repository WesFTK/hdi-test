import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hdi_test/pages/personalization/ui/widgets/theme_selector.dart';
import 'package:hdi_test/widgets/section_header.dart';

class PersonalizationPage extends StatelessWidget {
  const PersonalizationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Personalization')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SectionHeader(
            icon: Icons.palette_outlined,
            title: 'Theme',
          ),
          const Gap(12),
          const ThemeSelector(),
        ],
      ),
    );
  }
}
