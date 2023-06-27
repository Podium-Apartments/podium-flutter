// ignore_for_file: unused_element

import 'package:authentication_repo/authentication_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:podium/src/login/login.dart';
import 'package:podium/src/shared/shared_index.dart';
import 'package:podium/src/website/splash_page/views/components/splash_page_mobile_banner.dart';
import 'package:podium/src/website/website_pages_index.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with WidgetsBindingObserver {
  bool _isLargeScreen = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    // _updateScreenSize();
  }

  void _updateScreenSize() {
    if (MediaQuery.of(context).size.width >= 650 && !_isLargeScreen) {
      _isLargeScreen = true;
      _openLoginModal();
    } else if (MediaQuery.of(context).size.width < 650 && _isLargeScreen) {
      _isLargeScreen = false;
      _openLoginModal();
    }
  }

  void _openLoginModal() {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }

    if (_isLargeScreen) {
      showDialog<void>(
        context: context,
        builder: (_) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: BlocProvider(
              create: (_) =>
                  LoginCubit(context.read<AuthenticationRepository>()),
              child: Wrap(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    child: SizedBox(
                      width: 575,
                      child: Container(
                        constraints: const BoxConstraints(minHeight: 400),
                        child: const LoginForm(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    } else {
      showModalBottomSheet<void>(
        isScrollControlled: true,
        context: context,
        builder: (_) {
          return ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: BlocProvider(
              create: (_) =>
                  LoginCubit(context.read<AuthenticationRepository>()),
              child: ListView(
                shrinkWrap: true,
                children: const [
                  LoginForm(),
                ],
              ),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: !isMobile(context)
            ? Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * .1,
                ),
                child: const PodiumLogoWithTitle(
                  height: 150,
                ),
              )
            : null,
        actions: [
          if (!isMobile(context))
            // Builder(
            //   builder: (BuildContext context) {
            //     return IconButton(
            //       icon: const Icon(Icons.menu, color: Colors.black),
            //       onPressed: () {
            //         Scaffold.of(context).openDrawer();
            //       },
            //       tooltip:
            //           MaterialLocalizations.of(context).openAppDrawerTooltip,
            //     );
            //   },
            // )
            // else
            Row(
              children: [
                TextButton(
                  onPressed: () => context.go('/residents'),
                  child: const Text(
                    'Residents',
                  ),
                ),
                TextButton(
                  onPressed: () => context.go('/services'),
                  child: const Text(
                    'Services',
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * .1),
              ],
            ),
        ],
        toolbarHeight: 150,
      ),
      drawer: isMobile(context)
          ? Drawer(
              backgroundColor: Colors.white,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const DrawerHeader(
                    child: PodiumLogoWithTitle(height: 150),
                  ),
                  ListTile(
                    title: const Text('Residents'),
                    onTap: () {
                      Navigator.pop(context);
                      context.go('/residents');
                    },
                  ),
                  ListTile(
                    title: const Text('Services'),
                    onTap: () {
                      Navigator.pop(context);
                      context.go('/residents');
                    },
                  ),
                ],
              ),
            )
          : null,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Column(
                children: [
                  //Splash Photo and User Action Box
                  LayoutBuilder(
                    builder: (context, constraints) {
                      // ignore: omit_local_variable_types
                      final double bottomPadding =
                          constraints.maxWidth < 650 ? 90 : 180;
                      return Padding(
                        padding:
                            EdgeInsets.only(right: 16, bottom: bottomPadding),
                        child: SizedBox(
                          width: constraints.maxWidth,
                          child: constraints.maxWidth < 650
                              ? const SplashPageMobileBanner()
                              : const SplashPageDesktopBanner(),
                        ),
                      );
                    },
                  ),
                  const SplashPageMainSection(
                    image: 'splash_page_community.jpg',
                    title: 'A Lively Atmosphere',
                    body:
                        '''Podium buildings create an inviting environment where residents can connect, share experiences, and feel a sense of belonging. Our properties offer a unique ambiance that adds to the overall living experience, fostering a vibrant community.''',
                  ),
                  Padding(
                    padding: EdgeInsets.all(isMobile(context) ? 16 : 64),
                    child: Center(
                      child: Wrap(
                        spacing: 50,
                        runAlignment: WrapAlignment.spaceBetween,
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        verticalDirection:
                            MediaQuery.of(context).size.width < 1800
                                ? VerticalDirection.up
                                : VerticalDirection.down,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.width < 1546
                                      ? 40
                                      : 0,
                                  bottom: isMobile(context) ? 40 : 80,
                                ),
                                child: Text(
                                  'Urban Lifestyle at Your Doorstep',
                                  style: TextStyle(
                                    fontSize: isMobile(context) ? 30 : 36,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              ConstrainedBox(
                                constraints:
                                    const BoxConstraints(maxWidth: 500),
                                child: Text(
                                  '''Explore the conveniences of modern living in our Podium buildings. Our prime locations feature an array of premium retail partners, bringing the best of city living right to your front door.''',
                                  style: TextStyle(
                                    fontSize: isMobile(context) ? 18 : 22,
                                    fontWeight: FontWeight.w300,
                                    letterSpacing: 1.1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // splashSectionImage(
                          //   'podium.jpg',
                          // ),
                          const SplashPageCarousel()
                        ],
                      ),
                    ),
                  ),
                  const SplashPageMainSection(
                    image: 'splash_page_city_skyline.jpg',
                    title: 'Expanding Horizons',
                    body:
                        '''Join a growing network of distinctive properties that redefine urban living. With our expanding portfolio of Podium buildings, you'll be part of a thriving community that enjoys a consistent, quality experience across a diverse range of locations. Embrace the future of residential living and discover the true potential of a connected lifestyle.''',
                  ),
                  const SplashPageFeatureBoxSection(),
                  Padding(
                    padding: EdgeInsets.only(
                      left: isMobile(context) ? 16 : 72,
                      right: isMobile(context) ? 16 : 32,
                      bottom: isMobile(context) ? 32 : 72,
                    ),
                    child: const BlogFeed(),
                  ),
                  const SplashPageQuestionsSection(),
                ],
              ),
              if (MediaQuery.of(context).size.width > 340) const PodiumFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
