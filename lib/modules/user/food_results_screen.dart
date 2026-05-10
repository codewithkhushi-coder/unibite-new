import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../../core/theme/app_colors.dart';
import '../../core/models/canteen_model.dart';
import '../../widgets/search_result_card.dart';
import '../../core/providers/search_provider.dart';

class FoodResultsScreen extends StatefulWidget {
  final String category;
  const FoodResultsScreen({super.key, required this.category});

  @override
  State<FoodResultsScreen> createState() => _FoodResultsScreenState();
}

class _FoodResultsScreenState extends State<FoodResultsScreen> {
  List<SearchResult> _results = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchResults();
  }

  Future<void> _fetchResults() async {
    setState(() => _isLoading = true);
    
    // Get location
    Position? userPos;
    try {
      userPos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (_) {}

    final List<SearchResult> tempResults = [];
    final categoryLower = widget.category.toLowerCase();

    for (var canteen in mockCanteens) {
      for (var item in canteen.menu) {
        if (item.category.toLowerCase() == categoryLower || 
            item.name.toLowerCase().contains(categoryLower)) {
          
          double distance = 0;
          if (userPos != null) {
            distance = Geolocator.distanceBetween(
              userPos.latitude,
              userPos.longitude,
              canteen.latitude,
              canteen.longitude,
            );
          } else {
            distance = 150.0 + (canteen.id == '1' ? 0 : canteen.id == '2' ? 100 : 200);
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

    setState(() {
      _results = tempResults;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          '${widget.category} Near You',
          style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.textPrimary),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.primaryPink),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: AppColors.primaryPink))
          : _results.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.no_food_rounded, size: 80, color: Colors.grey.shade300),
                      const SizedBox(height: 16),
                      Text(
                        'No ${widget.category} available right now',
                        style: TextStyle(color: Colors.grey.shade500, fontSize: 16),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
                  itemCount: _results.length,
                  itemBuilder: (context, index) {
                    final result = _results[index];
                    return SearchResultCard(
                      result: result,
                      onAdd: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Added ${result.item.name} to cart!')),
                        );
                      },
                    );
                  },
                ),
    );
  }
}
