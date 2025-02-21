import 'package:flourish/src/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// class ThemeText {
//   static TextTheme lightTextTheme = TextTheme(
//       headlineLarge: GoogleFonts.montserrat(
//         fontSize: 32,
//         fontWeight: FontWeight.bold,
//         color: Colors.black87,
//       ),
//       headlineMedium: GoogleFonts.montserrat(
//         fontSize: 24,
//         fontWeight: FontWeight.w600,
//         color: Colors.black87,
//       ),
//       headlineSmall: GoogleFonts.montserrat(
//         fontSize: 16,
//         fontWeight: FontWeight.w600,
//         color: Colors.black87,
//       ));
//   static TextTheme darkTextTheme = TextTheme(
//       headlineLarge: GoogleFonts.montserrat(
//         fontSize: 32,
//         fontWeight: FontWeight.bold,
//         color: Colors.white,
//       ),
//       headlineMedium: GoogleFonts.montserrat(
//         fontSize: 24,
//         fontWeight: FontWeight.w600,
//         color: Colors.white,
//       ));
// }

class ThemeText {
  static TextTheme lightTextTheme = TextTheme(
      headlineMedium: GoogleFonts.poppins(
        color: slate600,
      ),
      headlineSmall: GoogleFonts.poppins(
        color: slate600,
      ),
      bodyMedium: GoogleFonts.poppins(
        color: slate400,
      ));
  static TextTheme darkTextTheme = TextTheme(
      headlineMedium: GoogleFonts.poppins(
        color: light,
      ),
      headlineSmall: GoogleFonts.poppins(
        color: light,
      ),
      bodyMedium: GoogleFonts.poppins(
        color: light,
      ));
}
