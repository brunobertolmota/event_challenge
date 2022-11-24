import 'package:event_challenge/shared/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PurpleButton extends StatelessWidget {
  final Function onPressed;
  final String label;

  const PurpleButton({
    super.key,
    required this.onPressed,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 60,
        child: ElevatedButton(
          onPressed: () => onPressed(),
          child: Text(
            label,
            style: GoogleFonts.montserrat(
              textStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.white,
              ),
            ),
          ),
        ));
  }
}
