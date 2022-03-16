import 'package:covid19_apps/Services/static_services.dart';
import 'package:covid19_apps/detail_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesScreen extends StatefulWidget {
  const CountriesScreen({Key? key}) : super(key: key);

  @override
  _CountriesScreenState createState() => _CountriesScreenState();
}

class _CountriesScreenState extends State<CountriesScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    StaticServices staticServices = StaticServices();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: searchController,
                onChanged: (value){
                  setState(() {

                  });
                },
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    hintText: 'Search with country name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    )),
              ),
            ),
            Expanded(
                child: FutureBuilder(
              future: staticServices.countriesListApi(),
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                if (!snapshot.hasData){
                  return ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index){
                    return Shimmer.fromColors(
                      baseColor: Colors.grey.shade700,
                      highlightColor: Colors.grey.shade100,
                      child: Column(
                        children: [
                          ListTile(
                            title: Container(
                              height: 10,
                              width: 89,
                              color: Colors.white,
                            ),
                            subtitle: Container(
                              height: 10,
                              width: 89,
                              color: Colors.white,
                            ),
                            leading: Container(
                              height: 10,
                              width: 89,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    );
                  });
                }else {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        String name=snapshot.data![index]['country'];

                        if(searchController.text.isNotEmpty){
                          return Column(
                            children: [
                              InkWell(
                                onTap:(){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailScreen(
                                      name: snapshot.data![index]['country'],
                                      image: snapshot.data![index]['countryInfo']['flag'],
                                      totalCases: snapshot.data![index]['cases'],
                                      todayRecovered:snapshot.data![index]['recovered'],
                                      active:snapshot.data![index]['active'],
                                      critical: snapshot.data![index]['critical'],
                                      totalRecovered: snapshot.data![index]['totalRecovered'],
                                      test: snapshot.data![index]['test'],
                                  )));
                          },
                                child: ListTile(
                                  title: Text(snapshot.data![index]['country']),
                                  subtitle: Text(
                                      snapshot.data![index]['cases'].toString()),
                                  leading: Image(
                                    height: 50,
                                    width: 50,
                                    image: NetworkImage(snapshot.data![index]
                                    ['countryInfo']['flag']),
                                  ),
                                ),
                              )
                            ],
                          );
                        }else if(name.toLowerCase().contains(searchController.text.toLowerCase())){
                          return Column(
                            children: [
                              InkWell(
                                onTap:(){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailScreen(
                                    name: snapshot.data![index]['country'],
                                    image: snapshot.data![index]['countryInfo']['flag'],
                                    totalCases: snapshot.data![index]['cases'],
                                    todayRecovered:snapshot.data![index]['recovered'],
                                    active:snapshot.data![index]['active'],
                                    critical: snapshot.data![index]['critical'],
                                    totalRecovered: snapshot.data![index]['totalRecovered'],
                                    test: snapshot.data![index]['test'],
                                  )));
                          },
                                child: ListTile(
                                  title: Text(snapshot.data![index]['country']),
                                  subtitle: Text(
                                      snapshot.data![index]['cases'].toString()),
                                  leading: Image(
                                    height: 50,
                                    width: 50,
                                    image: NetworkImage(snapshot.data![index]
                                    ['countryInfo']['flag']),
                                  ),
                                ),
                              )
                            ],
                          );
                        }else{
                          return Container();
                        }
                      });
                  }
                 },
               )
            ),
          ],
        ),
      ),
    );
  }
}
