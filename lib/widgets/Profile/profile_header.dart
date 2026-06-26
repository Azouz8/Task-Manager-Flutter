import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final int completedCount;

  const ProfileHeader({super.key, required this.completedCount});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); //[cite: 2]

    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              width: 128,
              height: 128,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: theme.colorScheme.primary, //[cite: 2]
                  width: 4,
                ),
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/scholar_avatar.png',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: theme.cardColor, //[cite: 2]
                    child: Icon(
                      Icons.person,
                      size: 60,
                      color: theme.textTheme.displayMedium?.color, //[cite: 2]
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: theme.colorScheme.primary, //[cite: 2]
                border: Border.all(
                  color: theme.scaffoldBackgroundColor,
                  width: 3,
                ), //[cite: 2]
              ),
              child: Icon(
                Icons.verified,
                color: theme.colorScheme.inversePrimary, //[cite: 2]
                size: 20,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'Ziad Alaa',
          style: theme.textTheme.headlineMedium, //[cite: 2]
        ),
        const SizedBox(height: 4),
        Text(
          'MASTER SCHOLAR',
          style: theme.textTheme.displaySmall?.copyWith(
            //[cite: 2]
            color: theme.colorScheme.primaryContainer, //[cite: 2]
            letterSpacing: 0.05,
          ),
        ),
      ],
    );
  }
}
