import 'package:chewie/chewie.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:animalCare/util/export_file.dart';
import './Media.dart';
import 'dart:io';

class WorldMessageCard extends StatefulWidget {

  final Media media;

  const WorldMessageCard({super.key, required this.media});

  @override
  State<WorldMessageCard> createState() => _WorldMessageCardState();
}

class _WorldMessageCardState extends State<WorldMessageCard> {


  ChewieController? _chewieController;


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            //FollowButton(),
            Container(
              margin: const EdgeInsets.only(left: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textAppTitle(this.widget.media.Title),

                ],
              ),
            )
          ],
        ),

        ExpandableText(
          this.widget.media.Description,
          expandText: 'more',
          collapseText: 'close',
          maxLines: 1, // 只显示一行
          linkColor: Colors.blue, // "展开全文" 链接颜色
          style: TextStyle(fontSize: 16),
        ),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: _mediaContainer(widget.media),
        ),

        Container(
          margin: const EdgeInsets.only(top: 12),
          child: const Divider(
            thickness: 0.5,
            color: borderColor,
          ),
        )
      ],
    );
  }

  Widget _mediaContainer(Media media) {
    return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 6,
          mainAxisSpacing: 6,
        ),
        itemCount: 1,
        itemBuilder: (context, index) {
          return _picItem(media);
        });
  }

  Widget _picItem(Media media) {
    return InkWell(
      onTap: () {
        // Navigator.push(context, MaterialPageRoute(
        //     builder: (context) => CollectionPreviewPage(initialPage: index, initialItem: item,)));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        clipBehavior: Clip.antiAlias,
        child: media.CoverPath.startsWith('assets')
            ? Image.asset(media.CoverPath)
            : Image.file(File(media.CoverPath)),
      ),
    );
  }
}