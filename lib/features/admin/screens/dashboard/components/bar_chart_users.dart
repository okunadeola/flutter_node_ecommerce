import 'package:ecom/constants/constants.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarChartUsers extends StatelessWidget {
  const BarChartUsers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
        TextStyle styles =  const TextStyle(
                      color: lightTextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    );
         return BarChart(BarChartData(
        borderData: FlBorderData(border: Border.all(width: 0)),
        groupsSpace: 15,
        titlesData: FlTitlesData(
            show: true,
            bottomTitles:  AxisTitles(
                sideTitles: SideTitles(
                showTitles: true,
               
               reservedSize: appPadding,
                getTitlesWidget: (double value, TitleMeta meta) {
                  if (value == 2) {
                    return  Text('jan 6', style: styles);
                  } if (value == 4) {
                    return   Text('jan 8' , style: styles);
                  }if (value == 6) {
                     return  Text('jan 10' , style: styles);
                  } if (value == 8) {
                    return  Text('jan 12' , style: styles);
                  }if (value == 10) {
                   return  Text('jan 14' , style: styles);
                  }if (value == 12) {
                     return  Text('jan 16' , style: styles);
                  }if (value == 14) {
                     return  Text('jan 18' , style: styles);
                  }else {
                    return const SizedBox();
                  }                
                }
                )
                ),
            leftTitles:  AxisTitles(
                sideTitles: SideTitles(
                showTitles: true,               
               reservedSize: appPadding,
                getTitlesWidget: (double value, TitleMeta meta) {
                   if (value == 2) {
                  return   Text('1K' , style: styles);
                } if (value == 6) {
                  return  Text('2K' , style: styles);
                } if (value == 10) {
                  return  Text('3K' , style: styles);
                }if (value == 14) {
                  return  Text('4K' , style: styles);
                }else {
                     return const SizedBox();
                }
                
                }
                )
                ),
         
        ),
        barGroups: [
          BarChartGroupData(x: 1, barRods: [
            BarChartRodData(
              toY: 10,
              width: 20,
              color: primaryColor,
              borderRadius: BorderRadius.circular(5)
            )
          ]),
          BarChartGroupData(x: 2, barRods: [
            BarChartRodData(
                toY: 3,
                width: 20,
                 color: primaryColor,
                borderRadius: BorderRadius.circular(5)
            )
          ]),
          BarChartGroupData(x: 3, barRods: [
            BarChartRodData(
                toY: 12,
                width: 20,
                 color: primaryColor,
                borderRadius: BorderRadius.circular(5)
            )
          ]),
          BarChartGroupData(x: 4, barRods: [
            BarChartRodData(
                toY: 8,
                width: 20,
                   color: primaryColor,
                borderRadius: BorderRadius.circular(5)
            )
          ]),
          BarChartGroupData(x: 5, barRods: [
            BarChartRodData(
                toY: 6,
                width: 20,
                    color: primaryColor,
                borderRadius: BorderRadius.circular(5)
            )
          ]),
          BarChartGroupData(x: 6, barRods: [
            BarChartRodData(
                toY: 10,
                width: 20,
                    color: primaryColor,
                borderRadius: BorderRadius.circular(5)
            )
          ]),
          BarChartGroupData(x: 7, barRods: [
            BarChartRodData(
                toY: 16,
                width: 20,
                    color: primaryColor,
                borderRadius: BorderRadius.circular(5)
            )
          ]),
          BarChartGroupData(x: 8, barRods: [
            BarChartRodData(
                toY: 6,
                width: 20,
                    color: primaryColor,
                borderRadius: BorderRadius.circular(5)
            )
          ]),
          BarChartGroupData(x: 9, barRods: [
            BarChartRodData(
                toY: 4,
                width: 20,
                    color: primaryColor,
                borderRadius: BorderRadius.circular(5)
            )
          ]),
          BarChartGroupData(x: 10, barRods: [
            BarChartRodData(
                toY: 9,
                width: 20,
                    color: primaryColor,
                borderRadius: BorderRadius.circular(5)
            )
          ]),
          BarChartGroupData(x: 11, barRods: [
            BarChartRodData(
                toY: 12,
                width: 20,
                    color: primaryColor,
                borderRadius: BorderRadius.circular(5)
            )
          ]),
          BarChartGroupData(x: 12, barRods: [
            BarChartRodData(
                toY: 2,
                width: 20,
                    color: primaryColor,
                borderRadius: BorderRadius.circular(5)
            )
          ]),
          BarChartGroupData(x: 13, barRods: [
            BarChartRodData(
                toY: 13,
                width: 20,
                    color: primaryColor,
                borderRadius: BorderRadius.circular(5)
            )
          ]),
          BarChartGroupData(x: 14, barRods: [
            BarChartRodData(
                toY: 15,
                width: 20,
                    color: primaryColor,
                borderRadius: BorderRadius.circular(5)
            )
          ]),
        ]));
  }
}
