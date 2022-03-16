import 'dart:convert';

import 'package:covid19_apps/Model/WorldStaticModal.dart';
import 'package:covid19_apps/Services/app_url.dart';
import 'package:http/http.dart' as http;

class StaticServices{

  Future<WorldStaticModal> fecthWorldStatesRecords()async{
    final response= await http.get(Uri.parse(AppUrl.worldStaticApi));

    if(response.statusCode==200){
      var data =jsonDecode(response.body);
      return WorldStaticModal.fromJson(data);

    }else{
      throw Exception('Error');
    }
  }

  Future<List<dynamic>> countriesListApi()async{
    var data;
    final response= await http.get(Uri.parse(AppUrl.countriesList));

    if(response.statusCode==200){
       data =jsonDecode(response.body);
      return data;

    }else{
      throw Exception('Error');
    }
  }
}