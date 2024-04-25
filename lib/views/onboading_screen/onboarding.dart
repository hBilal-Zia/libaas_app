import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libaas_app/common_widget/app_color.dart';
import 'package:libaas_app/common_widget/container_global.dart';
import 'package:libaas_app/common_widget/spaces.dart';
import 'package:libaas_app/common_widget/text_global.dart';
import 'package:libaas_app/component/button_component.dart';
import 'package:libaas_app/views/auth/signin_screen/signin_button_screen.dart';

PageController _pageController = PageController();
List<String> images = [
  "asset/images/item1.png",
  "asset/images/item2.png",
  "asset/images/item3.png"
];

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: containerGlobalWidget(PageView(
        controller: _pageController,
        children: const [
          PageOneScreen(),
          PageTwoScreen(),
          PageThreeScreen(),
        ],
      )),
    );
  }
}

class PageOneScreen extends StatelessWidget {
  const PageOneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: containerGlobalWidget(Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            children: [
              Spaces.mid,
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 350,
                child: PageView.builder(
                    itemCount: images.length,
                    pageSnapping: true,
                    itemBuilder: (context, pagePosition) {
                      return Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0)),
                        margin: const EdgeInsets.all(10),
                        child: Image.asset(images[0], fit: BoxFit.cover),
                      );
                    }),
              ),
              Spaces.mid,
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: indicators(images.length, 0)),
              Spaces.mid,
              Center(
                child: textGlobalWidget(
                    text: 'Virtual Try On',
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold),
              ),
              Spaces.smallh,
              Center(
                child: textGlobalWidget(
                    text:
                        'Virtual try-on technology enables users to visualize how clothing looks on them without trying it on physically,',
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    if (_pageController.hasClients) {
                      _pageController.nextPage(
                        duration: const Duration(seconds: 1),
                        curve: Curves.easeIn,
                      );
                    }
                  },
                  child: const CircleAvatar(
                    radius: 30,
                    backgroundColor: ColorConstraint.primaryColor,
                    child: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Spaces.large
            ],
          ),
        )),
      ),
    );
  }
}

class PageTwoScreen extends StatelessWidget {
  const PageTwoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: containerGlobalWidget(Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            children: [
              Spaces.mid,
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 350,
                child: PageView.builder(
                    itemCount: images.length,
                    pageSnapping: true,
                    itemBuilder: (context, pagePosition) {
                      return Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0)),
                        margin: const EdgeInsets.all(10),
                        child: Image.asset(images[1], fit: BoxFit.cover),
                      );
                    }),
              ),
              Spaces.mid,
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: indicators(images.length, 1)),
              Spaces.mid,
              Center(
                child: textGlobalWidget(
                    text: 'Recommendation outfit',
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold),
              ),
              Spaces.smallh,
              Center(
                child: textGlobalWidget(
                    text:
                        'Feel free to let me know if you have a specific theme or tone in mind, and I can tailor the recommendation accordingly!',
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (_pageController.hasClients) {
                        _pageController.previousPage(
                          duration: const Duration(seconds: 1),
                          curve: Curves.easeIn,
                        );
                      }
                    },
                    child: const CircleAvatar(
                      radius: 30,
                      backgroundColor: ColorConstraint.primaryColor,
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (_pageController.hasClients) {
                        _pageController.nextPage(
                          duration: const Duration(seconds: 1),
                          curve: Curves.easeIn,
                        );
                      }
                    },
                    child: const CircleAvatar(
                      radius: 30,
                      backgroundColor: ColorConstraint.primaryColor,
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              Spaces.large
            ],
          ),
        )),
      ),
    );
  }
}

class PageThreeScreen extends StatelessWidget {
  const PageThreeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: containerGlobalWidget(Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            children: [
              Spaces.mid,
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 350,
                child: PageView.builder(
                    itemCount: images.length,
                    pageSnapping: true,
                    itemBuilder: (context, pagePosition) {
                      return Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0)),
                        margin: const EdgeInsets.all(10),
                        child: Image.asset(images[2], fit: BoxFit.cover),
                      );
                    }),
              ),
              Spaces.mid,
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: indicators(images.length, 1)),
              Spaces.mid,
              Center(
                child: textGlobalWidget(
                    text: 'Weekly Planner',
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold),
              ),
              Spaces.smallh,
              Center(
                child: textGlobalWidget(
                    text:
                        "\"Step into the week with style.Plan your outfits effortlessly with our curated weekly wardrobe picks.\"",
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              ButtonComponent(
                text: 'Get Start',
                onTap: () {
                  Get.to(SignInButtonScreen());
                },
              ),
              Spaces.large
            ],
          ),
        )),
      ),
    );
  }
}

List<Widget> indicators(imagesLength, currentIndex) {
  return List<Widget>.generate(imagesLength, (index) {
    return Container(
      margin: const EdgeInsets.all(3),
      width: currentIndex == index ? 15 : 10,
      height: currentIndex == index ? 15 : 10,
      decoration: BoxDecoration(
          color: currentIndex == index
              ? const Color(0xff7FBC99)
              : const Color(0xff7FBC99),
          shape: BoxShape.circle),
    );
  });
}
