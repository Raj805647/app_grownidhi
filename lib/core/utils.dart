import 'package:flutter/material.dart';

final List<Map<String, String>> data = [
  {"title": "Learn Anytime", "desc": "Access courses anytime, anywhere"},
  {"title": "Live Classes", "desc": "Join live sessions with experts"},
  {"title": "Quick Tests", "desc": "Practice & improve your skills"},
];

final List<Map<String, dynamic>> pages = [
  {
    "icon": Icons.menu_book_outlined,
    "title": "Learn Anytime, Anywhere",
    "subtitle":
    "Access thousands of courses for SSC, Banking, Railway, UPSC and more"
  },
  {
    "icon": Icons.flash_on_outlined,
    "title": "Bite-Sized Learning",
    "subtitle":
    "Master complex topics with our microlearning approach in just 5-10 minutes"
  },
  {
    "icon": Icons.emoji_events_outlined,
    "title": "Track Your Progress",
    "subtitle":
    "Earn XP, maintain streaks, and compete on leaderboards"
  },
];

final List<Map<String, String>> certificates = [
  {
    "course": "SSC CGL Complete Course",
    "grade": "Distinction",
    "score": "92%",
    "date": "February 15, 2026",
  },
  {
    "course": "Banking Reasoning & Aptitude",
    "grade": "Excellence",
    "score": "88%",
    "date": "January 28, 2026",
  },
  {
    "course": "Python Programming Basics",
    "grade": "Distinction",
    "score": "95%",
    "date": "January 10, 2026",
  },
];

final List<String> tabs = [
  "All",
  "SSC",
  "Banking",
  "Railway",
  "UPSC",
  "Programming"
];

final List<Map<String, dynamic>> courses = [
  {
    "title": "SSC CGL Complete Course",
    "category": "SSC",
    "level": "Intermediate",
    "lessons": "45 lessons",
    "duration": "12h 30m",
    "progress": 0.35,
    "color": Colors.orange,
  },
  {
    "title": "Banking Reasoning & Aptitude",
    "category": "Banking",
    "level": "Beginner",
    "lessons": "32 lessons",
    "duration": "8h 45m",
    "progress": 0.65,
    "color": Colors.green,
  },
];