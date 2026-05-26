import 'package:flutter/material.dart';

SizedBox spaceHeight(double height) {
  return SizedBox(height: height);
}

SizedBox spaceWidth(double width) {
  return SizedBox(width: width);
}

LinearGradient customGradientDesign() {
  return const LinearGradient(
    colors: [Color(0xff7F00FF), Color(0xffE100FF), Color(0xff00C6FF)],
  );
}

void showDeleteMemberDialog({
  required BuildContext context,
  required VoidCallback onDelete,
}) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "Delete Dialog",
    barrierColor: Colors.black.withOpacity(0.7),
    transitionDuration: const Duration(milliseconds: 320),

    pageBuilder: (_, __, ___) {
      return const SizedBox.shrink();
    },

    transitionBuilder: (context, animation, secondaryAnimation, child) {
      final curvedValue = Curves.easeInOutBack.transform(
        animation.value,
      );

      return Transform.scale(
        scale: curvedValue,

        child: Opacity(
          opacity: animation.value,

          child: Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 26),

              padding: const EdgeInsets.all(24),

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),

                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,

                  colors: [
                    const Color(0xff1B2230),
                    const Color(0xff10131A),
                  ],
                ),

                border: Border.all(
                  color: Colors.white.withOpacity(0.08),
                ),

                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.35),
                    blurRadius: 30,
                    offset: const Offset(0, 12),
                  ),

                  BoxShadow(
                    color: Colors.red.withOpacity(0.08),
                    blurRadius: 20,
                    spreadRadius: 1,
                  ),
                ],
              ),

              child: Material(
                color: Colors.transparent,

                child: Column(
                  mainAxisSize: MainAxisSize.min,

                  children: [

                    /// Top Icon
                    Container(
                      height: 82,
                      width: 82,

                      decoration: BoxDecoration(
                        shape: BoxShape.circle,

                        gradient: LinearGradient(
                          colors: [
                            Colors.red.withOpacity(0.25),
                            Colors.red.withOpacity(0.08),
                          ],
                        ),

                        border: Border.all(
                          color: Colors.red.withOpacity(0.25),
                        ),
                      ),

                      child: const Icon(
                        Icons.delete_outline_rounded,
                        color: Colors.red,
                        size: 42,
                      ),
                    ),

                    const SizedBox(height: 22),

                    /// Title
                    const Text(
                      "Delete Member",
                      textAlign: TextAlign.center,

                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.3,
                      ),
                    ),

                    const SizedBox(height: 12),

                    /// Message
                    const Text(
                      "Are you sure you want to permanently delete this member?",
                      textAlign: TextAlign.center,

                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        height: 1.6,
                      ),
                    ),

                    const SizedBox(height: 28),

                    /// Buttons
                    Row(
                      children: [

                        /// Cancel
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },

                            child: Container(
                              height: 52,

                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(16),

                                color: Colors.white.withOpacity(0.06),

                                border: Border.all(
                                  color: Colors.white10,
                                ),
                              ),

                              child: const Center(
                                child: Text(
                                  "Cancel",

                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 14),

                        /// Delete
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              onDelete();
                            },

                            child: Container(
                              height: 52,

                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(16),

                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xffFF4B4B),
                                    Color(0xffFF1E1E),
                                  ],
                                ),

                                boxShadow: [
                                  BoxShadow(
                                    color:
                                    Colors.red.withOpacity(0.30),
                                    blurRadius: 18,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),

                              child: const Center(
                                child: Text(
                                  "Delete",

                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}

Widget buildEmptyState({required String title, required String  subTitle, required IconData icon}) {
  return SizedBox(
    height: 450,
    child: Center(
      child: Column(
        mainAxisAlignment:
        MainAxisAlignment.center,

        children: [

          Icon(
            icon,
            size: 72,
            color: Colors.white.withOpacity(0.18),
          ),

          const SizedBox(height: 18),

           Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            subTitle,

            style: TextStyle(
              color: Colors.white.withOpacity(0.55),
              fontSize: 13,
            ),
          ),
        ],
      ),
    ),
  );
}
