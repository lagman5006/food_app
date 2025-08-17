import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foods_app/gen/assets.gen.dart';
import 'package:foods_app/presentation/blocs/food_bloc/foodBloc.dart';
import 'package:foods_app/presentation/blocs/food_bloc/food_state.dart';
import 'package:foods_app/presentation/blocs/food_bloc/food_event.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<FoodBloc>().add(FetchFoods());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        actions: [CircleAvatar(child: Assets.images.ellipse4.image())],
        leading: const Icon(Icons.menu),
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                context.push('/map', extra: {
                  'latitude': 22.3569,
                  'longitude': 91.7832,
                  'title': 'Agrabad 435, Chittagong',
                });
              },
              icon: const Icon(Icons.location_on, color: Colors.green),
            ),
            const Text("Agrabad 435, Chittagong", style: TextStyle(fontSize: 15)),
          ],
        ),
      ),
      body: BlocBuilder<FoodBloc, FoodState>(
        builder: (context, state) {
          if (state is FoodLoading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else if (state is FoodLoaded) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 5,
                    ),
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
                  SizedBox(
                    width: double.infinity,
                    height: 140,
                    child: PageView(children: [_buildBanner(), _buildBanner()]),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Today New Arrivals",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text("Best of the day 5-7 min",
                                style: TextStyle(fontSize: 15)),
                          ],
                        ),
                        const Spacer(),
                        const Icon(Icons.arrow_forward),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 180,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      scrollDirection: Axis.horizontal,
                      itemCount: state.foods.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        final food = state.foods[index];
                        return GestureDetector(
                          onTap: () {
                            print('Navigating to /map with extra: ${{
                              'latitude': food.latitude ?? 22.3569,
                              'longitude': food.longitude ?? 91.7832,
                              'title': food.name,
                            }}');
                            context.push('/map', extra: {
                              'latitude': food.latitude ?? 22.3569,
                              'longitude': food.longitude ?? 91.7832,
                              'title': food.name,

                            });

                          },
                          child: _buildFoodCard(
                            image: Image.network(
                              food.image,
                              width: 128,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                            title: food.name,
                            location: food.location,
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    child: Row(
                      children: [
                        const Text(
                          "Popular Restaurants",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        const Text("View All", style: TextStyle(fontSize: 15)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 300,
                    child: ListView.builder(
                      itemCount: state.foods.length,
                      itemBuilder: (context, index) {
                        final food = state.foods[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Image.network(food.image, width: 100, height: 100),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    food.name,
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.location_on, color: Colors.green),
                                      Text(food.location),
                                      const SizedBox(width: 10),
                                      GestureDetector(
                                        onTap: () {
                                          context.go("/book");
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: const Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 5,
                                            ),
                                            child: Text(
                                              "Book",
                                              style: TextStyle(color: Colors.white, fontSize: 18),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else if (state is FoodError) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text("No data loaded"));
        },
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
          gradient: LinearGradient(
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
}