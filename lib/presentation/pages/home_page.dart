import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foods_app/gen/assets.gen.dart';
import 'package:foods_app/presentation/blocs/food_bloc/foodBloc.dart';
import 'package:foods_app/presentation/blocs/food_bloc/food_state.dart';

import '../blocs/food_bloc/food_event.dart'; // ⬅️ entity chaqirdik

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold( // ⬅️ Scaffoldni tashqariga oldim
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        actions: [CircleAvatar(child: Assets.images.ellipse4.image())],
        leading: Icon(Icons.menu),
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.location_on, color: Colors.green),
            Text("Agrabad 435,chittagong", style: TextStyle(fontSize: 15)),
          ],
        ),
      ),
      body: BlocBuilder<FoodBloc, FoodState>( // ⬅️ endi state bilan ishlaymiz
        builder: (context, state) {
          if (state is FoodLoading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else if (state is FoodLoaded) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  /// 🔍 Search
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Enter your text",
                        prefixIcon: const Icon(Icons.search),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),

                  /// 📢 Bannerlar
                  SizedBox(
                    width: double.infinity,
                    height: 140,
                    child: PageView(
                      children: [
                        _buildBanner(),
                        _buildBanner(),
                      ],
                    ),
                  ),

                  /// 🍽️ Today New Arivable
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Today New Arivable",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text("Best of the food list update"),
                          ],
                        ),
                        const Spacer(),
                        Row(
                          children: const [
                            Text("See All"),
                            Icon(Icons.keyboard_arrow_right_outlined),
                          ],
                        ),
                      ],
                    ),
                  ),

                  /// 🍛 Food list (Firebase dan keladi)
                  SizedBox(
                    height: 180,
                    child: ListView.separated( // ⬅️ spacing uchun separated ishlatdik
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      scrollDirection: Axis.horizontal,
                      itemCount: state.foods.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        final food = state.foods[index]; // ⬅️ Firebasedan kelgan data
                        return _buildFoodCard(
                          image: Image.network(
                            food.image,
                            width: 128,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                          title: food.name,
                          location: food.location,
                        );
                      },
                    ),
                  ),

                  /// 🍴 Restaurant booking qismi (sizniki o‘sha-o‘sha qoldi)
                  _buildRestaurantSection(),
                  const SizedBox(height: 10),
                  _buildRestaurantSection(),
                ],
              ),
            );
          } else if (state is FoodError) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text("Press refresh to load data"));
        },
      ),
      floatingActionButton: FloatingActionButton( // ⬅️ test uchun qo‘shdim
        onPressed: () {
          context.read<FoodBloc>().add(LoadFoods());
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }

  Widget _buildBanner() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.images.gamburgers.path),
            alignment: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(40),
          gradient: const LinearGradient(
            colors: [Color(0xFFFF9F06), Color(0xFFFFE1B4)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Assets.images.flashOffer.image()],
          ),
        ),
      ),
    );
  }

  Widget _buildRestaurantSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            spacing: 5,
            children: [
              Assets.images.restaurant1.image(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Amborisa Hotel & Restaurant",
                    style: TextStyle(fontSize: 18),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.green),
                      const Text("Kazi Deiry, Taiger Pass \nChittagong"),
                      const SizedBox(width: 10),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Text(
                            "Book",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

/// 🍔 Food card UI (sizniki o‘sha-o‘sha qoldi)
Widget _buildFoodCard({
  required Widget image,
  required String title,
  required String location,
}) {
  return SizedBox(
    width: 150,
    child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: image,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                const Icon(Icons.location_on, color: Colors.green, size: 16),
                Expanded(
                  child: Text(
                    location,
                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
