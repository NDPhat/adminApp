import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class ItemManager extends StatelessWidget {
  ItemManager(
      {Key? key,
      required this.lop,
      required this.ten,
      required this.onTap,
      required this.imageLink,
      required this.colorBorder,
      required this.childLeft})
      : super(key: key);
  final String lop, ten;
  String imageLink;
  final VoidCallback onTap;
  final Color colorBorder;
  final Widget childLeft;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: colorBorder),
          borderRadius: const BorderRadius.all(Radius.circular(25))),
      height: 13.h,
      width: 90.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: 60.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircleAvatar(
                  backgroundColor: colorBorder.withOpacity(0.5),
                  radius:
                      SizerUtil.deviceType == DeviceType.tablet ? 8.w : 10.w,
                  child: Padding(
                    padding: const EdgeInsets.all(8), // Border radius
                    child: ClipOval(
                        child: imageLink.isNotEmpty
                            ? Image.network(
                                imageLink,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                "assets/images/dashboard/profile.png")),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        ten,
                        style: GoogleFonts.aBeeZee(
                            color: colorBorder, fontSize: 16),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        lop,
                        style: GoogleFonts.aBeeZee(
                            color: colorBorder, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 8.h,
            width: 5.w,
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(width: 2, color: colorBorder),
              ),
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: SizedBox(width: 20.w, child: childLeft),
          )
        ],
      ),
    );
  }
}
