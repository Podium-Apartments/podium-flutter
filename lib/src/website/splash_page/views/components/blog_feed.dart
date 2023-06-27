import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:podium/src/shared/variables/shared_variables.dart';
import 'package:podium/src/website/splash_page/views/components/blog_link.dart';

class BlogFeed extends StatefulWidget {
  const BlogFeed({super.key});

  @override
  State<BlogFeed> createState() => _BlogFeedState();
}

class _BlogFeedState extends State<BlogFeed> {
  final blogCarouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    final mobileBlogFeed = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
          carouselController: blogCarouselController,
          options: CarouselOptions(enableInfiniteScroll: false, height: 400),
          items: const [
            BlogLink(
              blogId: 'blog1',
              imageUrl: 'lib/src/assets/images/blog_story1_image3.jpg',
              headline:
                  '''The Future of Urban Living: How Podium Buildings are Reviving the Spirit of 'Main Street' ''',
              subtext:
                  '''Discover how architectural innovations are bringing about a renaissance of the 'Main Street' ethos. Dive into the rise of Podium Buildings and their role in creating vibrant, sustainable urban communities.''',
            ),
          ],
        ),
      ],
    );
    const desktopBlogFeed = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BlogLink(
          blogId: 'blog1',
          imageUrl: 'lib/src/assets/images/blog_story1_image3.jpg',
          headline:
              '''The Future of Urban Living: How Podium Buildings are Reviving the Spirit of 'Main Street' ''',
          subtext:
              '''Discover how architectural innovations are bringing about a renaissance of the 'Main Street' ethos. Dive into the rise of Podium Buildings and their role in creating vibrant, sustainable urban communities.''',
        ),
      ],
    );
    return Wrap(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Text(
                'Blogs',
                style: TextStyle(
                  fontSize: isMobile(context) ? 32 : 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (isMobile(context)) mobileBlogFeed else desktopBlogFeed
          ],
        ),
        // if (MediaQuery.of(context).size.width < 700)
        //   Padding(
        //     padding: const EdgeInsets.only(top: 8),
        //     child: Wrap(
        //       children: <Widget>[
        //         PlatformElevatedButton(
        //           onPressed: blogCarouselController.previousPage,
        //           style: ButtonStyle(
        //             shape: const MaterialStatePropertyAll(
        //               RoundedRectangleBorder(
        //                 borderRadius: BorderRadius.all(Radius.circular(100)),
        //               ),
        //             ),
        //             foregroundColor:
        //                 const MaterialStatePropertyAll(Colors.black87),
        //             shadowColor:
        //                 const MaterialStatePropertyAll(Colors.transparent),
        //             side: MaterialStatePropertyAll(
        //               BorderSide(color: Colors.grey.shade300),
        //             ),
        //             backgroundColor:
        //                 const MaterialStatePropertyAll(Colors.transparent),
        //           ),
        //           child: const Text('<'),
        //         ),
        //         PlatformElevatedButton(
        //           onPressed: blogCarouselController.nextPage,
        //           style: const ButtonStyle(
        //             shape: MaterialStatePropertyAll(
        //               RoundedRectangleBorder(
        //                 borderRadius: BorderRadius.all(Radius.circular(100)),
        //               ),
        //             ),
        //             foregroundColor: MaterialStatePropertyAll(Colors.black),
        //             shadowColor: MaterialStatePropertyAll(Colors.transparent)
        //             side: MaterialStatePropertyAll(
        //               BorderSide(color: Colors.grey),
        //             ),
        //             backgroundColor:
        //                 MaterialStatePropertyAll(Colors.transparent),
        //           ),
        //           child: const Text('>'),
        //         ),
        //       ],
        //     ),
        //   )
      ],
    );
  }
}
