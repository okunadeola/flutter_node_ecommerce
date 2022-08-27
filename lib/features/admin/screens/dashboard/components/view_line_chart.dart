import 'package:ecom/constants/constants.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';


class ViewLineChart extends StatefulWidget {
  const ViewLineChart({Key? key}) : super(key: key);

  @override
  _ViewLineChartState createState() => _ViewLineChartState();
}

class _ViewLineChartState extends State<ViewLineChart> {
  List<Color> gradientColors = [
    primaryColor,
    secondaryColor,
  ];

  @override
  Widget build(BuildContext context) {
     TextStyle styles =  const TextStyle(
                      color: lightTextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    );
    return Container(
      padding: const EdgeInsets.fromLTRB(
        appPadding,
        appPadding * 1.5,
        appPadding,
        appPadding,
      ),
      child: LineChart(LineChartData(
          gridData: FlGridData(
            show: false,
          ),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                showTitles: true,               
               reservedSize: 22,
                getTitlesWidget: (double value, TitleMeta meta) {
                  switch(value.toInt()){
                  case 1:
                    return Text('SUN' , style: styles);
                  case 4:
                   return Text('MON' , style: styles);
                  case 7:
                  return Text('TUE' , style: styles);
                  case 10:
                   return Text('WED' , style: styles);
                  case 13:
                  return Text('THR' , style: styles);
                  case 16:
                  return Text('FRI' , style: styles);
                  case 19:
                  return Text('SAT' , style: styles);
                }
                      return const SizedBox();}
                
                )
                ),
            
            
         
          ),
          borderData: FlBorderData(
            show: false,
          ),
          minX: 0,
          maxX: 20,
          maxY: 0,
          minY: 6,
          lineBarsData: [
            LineChartBarData(
                spots: [
                  FlSpot(0, 3),
                  FlSpot(4, 2),
                  FlSpot(9, 4),
                  FlSpot(12, 3),
                  FlSpot(15, 5),
                  FlSpot(18, 3),
                  FlSpot(20, 4),
                ],
                isCurved: true,
                color: primaryColor,
                barWidth: 5,
                isStrokeCapRound: true,
                dotData: FlDotData(show: false),
                belowBarData: BarAreaData(
                    show: true,
                    gradient:LinearGradient(
                      colors:  gradientColors.map((e) => e.withOpacity(0.3)).toList(),
                      begin: const Alignment(0, 0),
                      end: const Alignment(0, 1.75),               
                    ),))
                    
          ])),
    );
  }
}
