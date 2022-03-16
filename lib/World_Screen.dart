import 'package:covid19_apps/Model/WorldStaticModal.dart';
import 'package:covid19_apps/Services/static_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';


import 'countries_list_screen.dart';


class WorldScreen extends StatefulWidget {
  const WorldScreen({Key? key}) : super(key: key);

  @override
  _WorldScreenState createState() => _WorldScreenState();
}

class _WorldScreenState extends State<WorldScreen>with TickerProviderStateMixin{

  late final AnimationController _controller =AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this)..repeat();

  void dispose(){
    super.dispose();
    _controller.dispose();
  }
  final colorLsit =<Color>[
    const Color(0xfff80855),
    const Color(0xff58ea2f),
    const Color(0xff1140ce),
  ];
  @override
  Widget build(BuildContext context) {
    StaticServices staticServices =StaticServices();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*.01,),
              FutureBuilder(
                future: staticServices.fecthWorldStatesRecords(),
                  builder: (context ,AsyncSnapshot<WorldStaticModal> snapshot){
                  if(!snapshot.hasData){
                    return Expanded(
                      flex: 1,
                        child: SpinKitFadingCircle(
                          color: Colors.white,
                          size: 50.0,
                          controller: _controller,
                        ),);
                  }else{
                    return Column(
                      children: [
                        PieChart(
                          dataMap: {
                            'Total':double.parse(snapshot.data!.cases.toString()),
                            'Recovered':double.parse(snapshot.data!.recovered.toString()),
                            'Deaths':double.parse(snapshot.data!.deaths.toString()),
                          },
                          chartValuesOptions: const ChartValuesOptions(
                            showChartValuesInPercentage: true
                          ),
                          chartRadius: MediaQuery.of(context).size.width/3.2,
                          legendOptions: const LegendOptions(
                              legendPosition: LegendPosition.left
                          ),
                          animationDuration: const Duration(milliseconds: 1200),
                          chartType: ChartType.ring,
                          colorList: colorLsit,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height *.06),
                          child: Card(
                            child: Column(
                              children: [
                                ReusableRow(title: 'Total', value: snapshot.data!.cases.toString()),
                                ReusableRow(title: 'Deaths', value: snapshot.data!.deaths.toString()),
                                ReusableRow(title: 'Recovered', value: snapshot.data!.recovered.toString()),
                                ReusableRow(title: 'Active', value: snapshot.data!.active.toString()),
                                ReusableRow(title: 'Critical', value: snapshot.data!.critical.toString()),
                                ReusableRow(title: 'TodayDeaths', value: snapshot.data!.todayDeaths.toString()),
                                ReusableRow(title: 'TodayRecovered', value: snapshot.data!.todayRecovered.toString()),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap:(){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> CountriesScreen()));
                         },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.lightBlue,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Center(
                              child: Text('Treck Countires'),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
              }),

            ],
          ),
        ),
      ),
    );
  }
}
class ReusableRow extends StatelessWidget {
  String title, value;
   ReusableRow({Key? key,required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 5 ),
      child: Column(
        children: [
        Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value),
        ],
        ),
          SizedBox(height: 20,),
          Divider(),
        ],
      )
      );
  }
}

