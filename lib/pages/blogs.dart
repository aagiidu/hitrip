import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../blocs/blog_bloc.dart';
import '../models/blog.dart';
import '../utils/empty.dart';
import '../utils/next_screen.dart';
import '../widgets/custom_cache_image.dart';
import 'blog_details.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({Key? key}) : super(key: key);

  @override
  _BlogPageState createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage>
    with AutomaticKeepAliveClientMixin {
  ScrollController? controller;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 0)).then((value) {
      controller = ScrollController()..addListener(_scrollListener);
      context.read<BlogBloc>().getData(mounted);
    });
  }

  @override
  void dispose() {
    controller!.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    final db = context.read<BlogBloc>();

    if (!db.isLoading) {
      if (controller!.position.pixels == controller!.position.maxScrollExtent) {
        context.read<BlogBloc>().setLoading(true);
        context.read<BlogBloc>().getData(mounted);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final bb = context.watch<BlogBloc>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: const Text('Мэдээ мэдээлэл'),
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.refresh,
              size: 22,
            ),
            onPressed: () {
              context.read<BlogBloc>().onRefresh(mounted);
            },
          )
        ],
      ),
      body: RefreshIndicator(
        child: bb.hasData == false
            ? ListView(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.35,
                  ),
                  const EmptyPage(
                      icon: Icons.copy,
                      message: 'Оруулсан мэдээлэл байхгүй байна',
                      message1: ''),
                ],
              )
            : ListView.separated(
                padding: const EdgeInsets.all(15),
                controller: controller,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: bb.data.isNotEmpty ? bb.data.length + 1 : 5,
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(
                  height: 15,
                ),
                itemBuilder: (_, int index) {
                  if (index < bb.data.length) {
                    return _ItemList(d: bb.data[index]);
                  }
                  return Opacity(
                    opacity: bb.isLoading ? 1.0 : 0.0,
                    child: const Center(
                      child: SizedBox(
                          width: 32.0,
                          height: 32.0,
                          child: CupertinoActivityIndicator()),
                    ),
                  );
                },
              ),
        onRefresh: () async {
          context.read<BlogBloc>().onRefresh(mounted);
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _ItemList extends StatelessWidget {
  final Blog d;
  const _ItemList({Key? key, required this.d}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey[200]!,
                    blurRadius: 10,
                    offset: const Offset(0, 3))
              ]),
          child: Wrap(
            children: [
              Hero(
                tag: 'blog${d.id}',
                child: SizedBox(
                  height: 160,
                  width: MediaQuery.of(context).size.width,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: CustomCacheImage(imageUrl: d.image)),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      d.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(d.description,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[700])),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          CupertinoIcons.time,
                          size: 16,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        Text(
                          d.date,
                          style:
                              const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        onTap: () =>
            nextScreen(context, BlogDetails(blogData: d, tag: 'blog${d.id}')));
  }
}
