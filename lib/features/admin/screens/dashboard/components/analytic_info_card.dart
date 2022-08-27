import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


import '../../../../../constants/constants.dart';
import '../../../models/analytic_info_model.dart';

class AnalyticInfoCard extends StatelessWidget {
  const AnalyticInfoCard({Key? key, required this.info}) : super(key: key);

  final AnalyticInfo info;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.3,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: appPadding,
          vertical: appPadding / 2,
        ),
        decoration: BoxDecoration(
            color: secondaryColor, borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${info.count}",
                  style: const TextStyle(
                    color: textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(appPadding / 2),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      color: info.color!.withOpacity(0.1),
                      shape: BoxShape.circle),
                  child: SvgPicture.asset(
                    info.svgSrc!,
                    color: info.color,
                  ),
                )
              ],
            ),
            Text(
              info.title!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: textColor,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ),
    );
  }
}
