import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foods_app/gen/assets.gen.dart';
import 'package:foods_app/presentation/blocs/onboarding_bloc/onboarding_bloc.dart';
import 'package:go_router/go_router.dart';

import '../blocs/onboarding_bloc/onboarding_event.dart';
import '../blocs/onboarding_bloc/onboarding_state.dart';

class OnboardingPage extends StatelessWidget {
  final PageController _controller = PageController();

  final List<String> _texts = [
    "Nearby restaurants",
    "Select the Favorites Menu",
    "good food at cheap price",
  ];

  final List<String> _texts2 = [
    "You don't have g o far to find a good restaurant, we have provided all the restaurant that is near you",
    "Now eat well don't leave the house, You can choose your favorite food only with one click",
    "You can eat at expensive restaurants with affordable price",
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnboardingBloc(),
      child: Scaffold(
        body: BlocBuilder<OnboardingBloc, OnboardingState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 700,
                    child: PageView(
                      controller: _controller,
                      onPageChanged: (index) =>
                          context.read<OnboardingBloc>().add(ChangePage(index)),
                      children: [
                        _buildPage(
                          Assets.svgs.trackingMaps.path,
                          _texts[0],
                          _texts2[0],
                        ),
                        _buildPage(
                          Assets.svgs.orderIllustration.path,
                          _texts[1],
                          _texts2[1],
                        ),
                        _buildPage(Assets.svgs.safeFood.path, _texts[2], _texts2[2]),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(_texts.length, (index) {
                      return AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        width: state.pageIndex == index ? 20 : 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: state.pageIndex == index
                              ? Colors.green
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: 20),

                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        elevation: 5,
                        fixedSize: Size(300, 50),
                      ),
                      onPressed: () => context.go("/auth"),
                      child: Text("Next"),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

Widget _buildPage(String svgPath, String text, String text2) {
  return Padding(
    padding: EdgeInsets.all(24.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(svgPath, width: 400),
        const SizedBox(height: 20),
        Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        Text(
          text2,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15),
        ),
      ],
    ),
  );
}
