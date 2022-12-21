import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/Cubit/states.dart';
import 'package:news/network/diohelpear.dart';

class cubitScreen extends Cubit<StatesScreen>{
  cubitScreen():super(intialState());
  static bool search=false;
  bool loding =true;
   List<dynamic> data=[];
   List<dynamic> searchlist=[];

  int numbers_Articles=0;
  static cubitScreen getcubit(context)=>BlocProvider.of(context);

  void getDateFromApi(){
    emit(lodingstate());
    print('loding');
    loding=true;
    Diohealper.getdate(
        url:'/v2/top-headlines',
       data:  {
          'country':'eg',
         'apiKey': '005655fa0f4d42828d0dd5dabd14975c',
        }
      ).then((value){
      this.data=value.data['articles'];
        print(data[0]);
      emit(searchdateScuss());
       print('scuss');
      search=true;
    loding =false;
    }).catchError((error){
      emit(searxhdateErro());
      print(error.toString());
    });

  }
  void searchDateFromApi(String value) {
    emit(lodingstate());
    print('loding');
     loding =true;
    Diohealper.getdate(
        url: '/v2/everything',
        data: {
          'q': '$value',
          'apiKey': '005655fa0f4d42828d0dd5dabd14975c',
        }
    ).then((value) {
      search = false;
      searchlist = value.data['articles'];
      print(data[0]);
      emit(getdateScuss());
      print('scuss');
       loding =false;
    }).catchError((error) {
      emit(getdateErro());
      print(error.toString());
    });
  }


}