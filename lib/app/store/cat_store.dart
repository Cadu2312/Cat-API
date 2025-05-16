import 'package:cat_app/app/data/model/produto_model.dart';
import 'package:cat_app/app/data/repositories/cat_reportory.dart';
import 'package:flutter/material.dart';

class CatStore{
  final ICatRepository repository;

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  final ValueNotifier<List<CatModel>> state= ValueNotifier<List<CatModel>>([]);

  final ValueNotifier<String> erro = ValueNotifier<String>('');

  CatStore ({required this.repository});

  Future getCats() async {
    isLoading.value = true;

    
    final result = await repository.getCat();
    state.value = result;

    
    isLoading.value = false;
  }  

}