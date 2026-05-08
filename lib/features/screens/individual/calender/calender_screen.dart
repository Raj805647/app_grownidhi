import 'package:app_grownidhi/features/screens/individual/calender/calender_provider.dart';
import 'package:app_grownidhi/widget/ui_design.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../widget/help_widget.dart';
import '../../../../widget/page_entry_animation.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CalenderProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xfff5f7fb),
      body: Stack(
        children: [
          AppGradientBackground(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                pageEntryAnimation(
                  direction: SlideDirection.top,
                  child: _buildTitle(),
                ),

                spaceHeight(16),

                pageEntryAnimation(
                  direction: SlideDirection.left,
                  child: _buildMonthSwitcher(),
                ),

                spaceHeight(16),

                pageEntryAnimation(
                  direction: SlideDirection.right,
                  child: _buildCalendarGrid(provider),
                ),

                spaceHeight(20),

                pageEntryAnimation(
                  direction: SlideDirection.bottom,
                  child: _buildEventsSection(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget pageEntryAnimation({
    required Widget child,
    required SlideDirection direction,
    Duration duration = const Duration(milliseconds: 700),
  }) {
    Offset beginOffset;

    switch (direction) {
      case SlideDirection.top:
        beginOffset = const Offset(0, -0.3);
        break;
      case SlideDirection.bottom:
        beginOffset = const Offset(0, 0.3);
        break;
      case SlideDirection.left:
        beginOffset = const Offset(-0.3, 0);
        break;
      case SlideDirection.right:
        beginOffset = const Offset(0.3, 0);
        break;
    }

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: duration,
      curve: Curves.easeOutCubic,
      builder: (context, value, _) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(
              beginOffset.dx * (1 - value) * 100,
              beginOffset.dy * (1 - value) * 100,
            ),
            child: Transform.scale(scale: 0.95 + (value * 0.05), child: child),
          ),
        );
      },
      child: child,
    );
  }

  /// 🔥 EVENT CARD (FLOATING ANIMATION)
  Widget _buildTitle() {
    return const Row(
      children: [
        Text(
          "Calendar",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 6),
        Icon(Icons.calendar_today, color: Colors.green),
      ],
    );
  }

  Widget _buildMonthSwitcher() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xff0f2027), Color(0xff2c5364)],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.arrow_back_ios, color: Colors.white),
          Text(
            "February 2026",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Icon(Icons.arrow_forward_ios, color: Colors.white),
        ],
      ),
    );
  }

  Widget _buildCalendarGrid(CalenderProvider provider) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 12),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Text("Sun"),
              Text("Mon"),
              Text("Tue"),
              Text("Wed"),
              Text("Thu"),
              Text("Fri"),
              Text("Sat"),
            ],
          ),
          spaceHeight(10),

          GridView.builder(
            shrinkWrap: true,
            itemCount: 28,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
            ),
            itemBuilder: (context, index) {
              int day = index + 1;
              bool isSelected = provider.selectedDay == day;

              return GestureDetector(
                onTap: () => provider.selectDay(day),
                child:AnimatedScale(
                scale: isSelected ? 1.1 : 1.0,
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOut,
                child: Container(
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    gradient: isSelected
                        ? const LinearGradient(
                      colors: [Colors.green, Colors.lightGreen],
                    )
                        : null,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "$day",
                    style: TextStyle(
                      color: isSelected
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
              ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEventsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Upcoming Events",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        spaceHeight(10),

        eventCard(
          "15",
          "Life Insurance Premium",
          "February 15, 2026",
          Colors.blue,
        ),

        eventCard(
          "20",
          "Term Insurance Due",
          "February 20, 2026",
          Colors.orange,
        ),
      ],
    );
  }

  Widget eventCard(String day, String title, String date, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color,
            child: Text(day, style: const TextStyle(color: Colors.white)),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
              Text(date, style: const TextStyle(color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }
}
