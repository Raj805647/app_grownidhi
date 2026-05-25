import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
  });

  @override
  Size get preferredSize => const Size.fromHeight(78);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Colors.transparent,
      toolbarHeight: 78,

      flexibleSpace: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),

          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,

            colors: [
              Color(0xff10131A),
              Color(0xff1B2230),
            ],
          ),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.14),
              blurRadius: 24,
              offset: const Offset(0, 10),
            ),

            BoxShadow(
              color: const Color(0xff6C63FF).withOpacity(0.10),
              blurRadius: 18,
              spreadRadius: 1,
            ),
          ],
        ),
      ),

      leadingWidth: 78,

      leading: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          top: 12,
          bottom: 12,
        ),

        child: GestureDetector(
          onTap: () => Navigator.pop(context),

          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),

              color: Colors.white.withOpacity(0.06),

              border: Border.all(
                color: Colors.white.withOpacity(0.08),
              ),
            ),

            child: const Center(
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
        ),
      ),

      title: Padding(
        padding: const EdgeInsets.only(top: 6),

        child: Text(
          title,

          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.3,
            color: Colors.white,
          ),
        ),
      ),

      centerTitle: true,

      actions: [
        if (actions != null) ...actions!,

        const SizedBox(width: 12),
      ],
    );
  }
}

class CustomSliverAppBar extends StatelessWidget {
  final String title;
  final List<Widget>? actions;

  const CustomSliverAppBar({
    super.key,
    required this.title,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Colors.transparent,
      pinned: true,
      expandedHeight: 90,
      toolbarHeight: 78,

      flexibleSpace: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),

          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xff10131A),
              Color(0xff1B2230),
            ],
          ),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.14),
              blurRadius: 24,
              offset: const Offset(0, 10),
            ),

            BoxShadow(
              color: const Color(0xff6C63FF).withOpacity(0.10),
              blurRadius: 18,
              spreadRadius: 1,
            ),
          ],
        ),
      ),

      leadingWidth: 78,

      leading: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          top: 12,
          bottom: 12,
        ),

        child: GestureDetector(
          onTap: () => Navigator.pop(context),

          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),

              color: Colors.white.withOpacity(0.06),

              border: Border.all(
                color: Colors.white.withOpacity(0.08),
              ),
            ),

            child: const Center(
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
        ),
      ),

      title: Padding(
        padding: const EdgeInsets.only(top: 6),

        child: Text(
          title,

          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.3,
            color: Colors.white,
          ),
        ),
      ),

      centerTitle: true,

      actions: [
        if (actions != null) ...actions!,
        const SizedBox(width: 12),
      ],
    );
  }
}