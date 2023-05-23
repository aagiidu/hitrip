import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/blog.dart';
import '../services/app_services.dart';

class BlogBloc extends ChangeNotifier {
  bool _isLoading = true;
  bool get isLoading => _isLoading;

  List<Blog> _data = [];
  List<Blog> get data => _data;

  String _popSelection = 'popular';
  String get popupSelection => _popSelection;

  bool? _hasData;
  bool? get hasData => _hasData;

  Future<void> getData(mounted) async {
    final response = await AppService().getReq('blog/list');
    if (response.data['status'] == 'success') {
      List<dynamic> res = response.data['data'];
      _data = res.map((b) => Blog.fromJson(b)).toList();
      _isLoading = false;
      notifyListeners();
    }
  }

  afterPopSelection(value, mounted) {
    _popSelection = value;
    onRefresh(mounted);
    notifyListeners();
  }

  setLoading(bool isloading) {
    _isLoading = isloading;
    notifyListeners();
  }

  onRefresh(mounted) {
    _isLoading = true;
    _data.clear();
    getData(mounted);
    notifyListeners();
  }
}
