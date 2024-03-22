import 'package:flutter/material.dart';

import '../utils/image.util.dart';
import 'page_indicator.widget.dart';
import 'widgets.dart';

class PopUpImageWidget extends StatefulWidget {
  const PopUpImageWidget({super.key, required this.images});
  final List<String>? images;

  @override
  State<PopUpImageWidget> createState() => _PopUpImageWidgetState();
}

class _PopUpImageWidgetState extends State<PopUpImageWidget> {
  final controller = PageController();
  late double indexPage;

  @override
  void initState() {
    indexPage = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    if (indexPage > 0) {
                      indexPage = indexPage - 1;
                      controller.jumpTo(indexPage);
                    }
                  });
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.deepPurple,
                  size: 36.0,
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: controller,
                  itemCount: widget.images?.length,
                  itemBuilder: (context, index) {
                    return Image.memory(
                      imageFile(base64Image: widget.images![indexPage.toInt()]),
                      fit: BoxFit.contain,
                      height: 150.0,
                      width: 150.0,
                      errorBuilder: (context, error, stackTrace) {
                        return const ErrorImage();
                      },
                    );
                  },
                ),
              ),
              IconButton(
                onPressed: () {
                  if (widget.images != null &&
                      indexPage < widget.images!.length - 1) {
                    setState(() {
                      indexPage = indexPage + 1;
                      controller.nextPage(
                        duration: const Duration(milliseconds: 100),
                        curve: Curves.linear,
                      );
                    });
                  }
                },
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.deepPurple,
                  size: 36.0,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24.0),
        PaginationWidget(
          length: widget.images?.length ?? 0,
          indexSelected: indexPage.toInt(),
        )
      ],
    );
  }
}
