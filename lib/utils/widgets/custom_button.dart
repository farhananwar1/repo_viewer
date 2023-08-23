import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onTap;

  const CustomButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.deepPurple, borderRadius: BorderRadius.circular(12)),
        height: 45.h,
        width: double.infinity,
        child: Text(
          'Login with Github',
          textAlign: TextAlign.center,
          style: GoogleFonts.ibmPlexSans(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    ));
  }
}
