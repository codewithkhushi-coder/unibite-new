import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../models/canteen_model.dart';

class SearchResult {
  final Canteen canteen;
  final MenuItem item;
  final double distance;

  SearchResult({
    required this.canteen,
    required this.item,
    required this.distance,
  });
}

class SearchProvider extends ChangeNotifier {
  List<SearchResult> _results = [];
  bool _isSearching = false;
  String _query = '';
  Timer? _debounce;

  List<SearchResult> get results => _results;
  bool get isSearching => _isSearching;
  String get query => _query;

  void onSearchChanged(String query) {
    _query = query;
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    
    if (query.isEmpty) {
      _results = [];
      _isSearching = false;
      notifyListeners();
      return;
    }

    _isSearching = true;
    notifyListeners();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      _performSearch(query);
    });
  }

  Future<void> _performSearch(String query) async {
    final lowercaseQuery = query.toLowerCase();
    final List<SearchResult> tempResults = [];

    // Get user position
    Position? userPos;
    try {
      userPos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (e) {
      print('Error getting location: $e');
    }

    for (var canteen in mockCanteens) {
      // Search in menu
      for (var item in canteen.menu) {
        if (item.name.toLowerCase().contains(lowercaseQuery)) {
          double distance = 0;
          if (userPos != null) {
            distance = Geolocator.distanceBetween(
              userPos.latitude,
              userPos.longitude,
              canteen.latitude,
              canteen.longitude,
            );
          } else {
            // Mock distance if no GPS
            distance = 150.0 + (canteen.id == '1' ? 0 : canteen.id == '2' ? 100 : 250);
          }

          tempResults.add(SearchResult(
            canteen: canteen,
            item: item,
            distance: distance,
          ));
        }
      }
    }

    // Sort by distance
    tempResults.sort((a, b) => a.distance.compareTo(b.distance));

    _results = tempResults;
    _isSearching = false;
    notifyListeners();
  }

  void clearSearch() {
    _query = '';
    _results = [];
    _isSearching = false;
    notifyListeners();
  }
}
