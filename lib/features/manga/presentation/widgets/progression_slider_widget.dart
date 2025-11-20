// lib/widgets/progression_slider_card.dart

import 'package:flutter/material.dart';

///Design validé avec Slider interactif
class ProgressionSliderWidget extends StatefulWidget {
  final int currentChapter;
  final int totalChapters;
  final DateTime startedDate;
  final DateTime lastReadDate;
  final Function(int) onChapterChanged;

  const ProgressionSliderWidget({
    required this.currentChapter,
    required this.totalChapters,
    required this.startedDate,
    required this.lastReadDate,
    required this.onChapterChanged,
  });

  @override
  State<ProgressionSliderWidget> createState() =>
      _ProgressionSliderWidgetState();
}

class _ProgressionSliderWidgetState extends State<ProgressionSliderWidget> {
  late int _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.currentChapter;
  }

  @override
  Widget build(BuildContext context) {
    final progress = (_currentValue / widget.totalChapters * 100).toInt();

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E2E), // Fond sombre
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header avec pourcentage
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Progression',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '$progress%',
                style: const TextStyle(
                  color: Color(0xFF4ECDC4), // Cyan
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Barre de progression visuelle
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress / 100,
              backgroundColor: const Color(0xFF2D2D44),
              valueColor: const AlwaysStoppedAnimation(Color(0xFF4ECDC4)),
              minHeight: 12,
            ),
          ),

          const SizedBox(height: 16),

          // Dates
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Débuté le ${_formatDate(widget.startedDate)}',
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
              Text(
                _getRelativeTime(widget.lastReadDate),
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Slider interactif
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF16161F), // Fond encore plus sombre
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Page actuelle',
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '$_currentValue',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: ' / ${widget.totalChapters}',
                            style: const TextStyle(
                              color: Colors.white38,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SliderTheme(
                  data: SliderThemeData(
                    activeTrackColor: const Color(0xFF4ECDC4),
                    inactiveTrackColor: const Color(0xFF2D2D44),
                    thumbColor: const Color(0xFF4ECDC4),
                    overlayColor: const Color(0xFF4ECDC4).withOpacity(0.2),
                    thumbShape:
                        const RoundSliderThumbShape(enabledThumbRadius: 12),
                    trackHeight: 6,
                  ),
                  child: Slider(
                    value: _currentValue.toDouble(),
                    min: 0,
                    max: widget.totalChapters.toDouble(),
                    onChanged: (value) {
                      setState(() {
                        _currentValue = value.toInt();
                      });
                    },
                    onChangeEnd: (value) {
                      widget.onChapterChanged(value.toInt());
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day} ${_getMonth(date.month)} ${date.year}';
  }

  String _getMonth(int month) {
    const months = [
      'janvier',
      'février',
      'mars',
      'avril',
      'mai',
      'juin',
      'juillet',
      'août',
      'septembre',
      'octobre',
      'novembre',
      'décembre'
    ];
    return months[month - 1];
  }

  String _getRelativeTime(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) return 'Aujourd\'hui';
    if (difference.inDays == 1) return 'Il y a 1 jour';
    if (difference.inDays < 7) return 'Il y a ${difference.inDays} jours';
    return 'Il y a ${(difference.inDays / 7).floor()} semaines';
  }
}
