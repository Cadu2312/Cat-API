import 'package:cat_app/app/data/repositories/cat_reportory.dart';
import 'package:flutter/material.dart';

import '../data/model/produto_model.dart';

class CatDescriptionStore {
  final ICatRepository repository;

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  final ValueNotifier<CatModel> state = ValueNotifier<CatModel>(CatModel());

  final ValueNotifier<String> erro = ValueNotifier<String>('');

  CatDescriptionStore({required this.repository});

  Future getOneCat(CatModel cat) async {
    isLoading.value = true;

    final result = await repository.getCatImage(cat);
    state.value = result;

    isLoading.value = false;
  }
}
