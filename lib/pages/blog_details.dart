import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/blog.dart';
import '../widgets/custom_cache_image.dart';

class BlogDetails extends StatefulWidget {
  final Blog? blogData;
  final String tag;

  const BlogDetails({Key? key, required this.blogData, required this.tag})
      : super(key: key);

  @override
  _BlogDetailsState createState() => _BlogDetailsState();
}

class _BlogDetailsState extends State<BlogDetails> {
  final String collectionName = 'blogs';

  /* handleLoveClick() {
    bool _guestUser = context.read<SignInBloc>().guestUser;

    if (_guestUser == true) {
      openSignInDialog(context);
    } else {
      context
          .read<BookmarkBloc>()
          .onLoveIconClick(collectionName, widget.blogData!.timestamp);
    }
  } */

  /* handleBookmarkClick() {
    bool _guestUser = context.read<SignInBloc>().guestUser;

    if (_guestUser == true) {
      openSignInDialog(context);
    } else {
      context
          .read<BookmarkBloc>()
          .onBookmarkIconClick(collectionName, widget.blogData!.timestamp);
    }
  } */

  /* handleShare() {
    final sb = context.read<SignInBloc>();
    final String _shareTextAndroid =
        '${widget.blogData!.title}, Check out this app to explore more. App link: https://play.google.com/store/apps/details?id=${sb.packageName}';
    final String _shareTextiOS =
        '${widget.blogData!.title}, Check out this app to explore more. App link: https://play.google.com/store/apps/details?id=${sb.packageName}';

    if (Platform.isAndroid) {
      Share.share(_shareTextAndroid);
    } else {
      Share.share(_shareTextiOS);
    }
  } */

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 0)).then((value) async {
      // context.read<AdsBloc>().initiateAds();
    });
  }

  @override
  Widget build(BuildContext context) {
    // final SignInBloc sb = context.watch<SignInBloc>();
    final Blog d = widget.blogData!;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(5)),
                              child: IconButton(
                                padding: const EdgeInsets.all(0),
                                icon: const Icon(Icons.arrow_back),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                            const Spacer(),
                            const Icon(
                              CupertinoIcons.time,
                              size: 18,
                              color: Colors.grey,
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            Text(
                              d.date,
                              style: TextStyle(
                                  fontSize: 13, color: Colors.grey[700]),
                            ),
                            /* Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(5)),
                            child: IconButton(
                              padding: const EdgeInsets.all(0),
                              icon: const Icon(
                                Icons.share,
                                size: 22,
                              ),
                              onPressed: () {
                                handleShare();
                              },
                            )), */
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            /* Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                const Icon(
                                  CupertinoIcons.time,
                                  size: 18,
                                  color: Colors.grey,
                                ),
                                const SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  d.date,
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.grey[700]),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ), */
                            Text(
                              d.title,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.grey[800],
                                  letterSpacing: -0.7,
                                  wordSpacing: 1),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 5),
                              height: 3,
                              width: 150,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(40)),
                            ),
                            /* const SizedBox(
                          height: 10,
                        ), */
                            /* Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            TextButton.icon(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith(
                                        (states) => Colors.grey[200]),
                                padding: MaterialStateProperty.resolveWith(
                                    (states) => const EdgeInsets.all(10)),
                              ),
                              onPressed: () => AppService()
                                  .openLinkWithCustomTab(context, d.sourceUrl!),
                              icon: Icon(Feather.external_link,
                                  size: 20,
                                  color: Theme.of(context).primaryColor),
                              label: _getSourceName(d),
                            ),
                            const Spacer(),
                            IconButton(
                                icon: BuildLoveIcon(
                                    collectionName: collectionName,
                                    uid: sb.uid,
                                    timestamp: d.timestamp),
                                onPressed: () {
                                  handleLoveClick();
                                }),
                            IconButton(
                                icon: BuildBookmarkIcon(
                                    collectionName: collectionName,
                                    uid: sb.uid,
                                    timestamp: d.timestamp),
                                onPressed: () {
                                  handleBookmarkClick();
                                }),
                          ],
                        ), */
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Hero(
                  tag: widget.tag,
                  child: SizedBox(
                      height: 250,
                      width: double.infinity,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(0),
                          child: CustomCacheImage(imageUrl: d.image))),
                ),
                /* Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  LoveCount(
                      collectionName: collectionName, timestamp: d.timestamp),
                  const SizedBox(
                    width: 15,
                  ),
                  TextButton.icon(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith(
                              (states) => Theme.of(context).primaryColor)),
                      onPressed: () {
                        nextScreen(
                            context,
                            CommentsPage(
                                collectionName: collectionName,
                                timestamp: d.timestamp));
                      },
                      icon: Icon(
                        Feather.message_circle,
                        color: Colors.white,
                      ),
                      label: const Text(
                        'comments',
                        style: TextStyle(color: Colors.white),
                      ).tr())
                ],
              ),
            ), */
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(d.description),
                ),
                /* HtmlBodyWidget(
                  content: d.description,
                  isIframeVideoEnabled: true,
                  isVideoEnabled: true,
                  isimageEnabled: true,
                  fontSize: 17,
                ), */
              ]),
        ),
      ),
    );
  }
}
