part of 'upload_image.widget.dart';

class GridViewImageWidget extends StatefulWidget {
  final List<XFile> images;
  final ValueChanged<List<XFile>> isEmptyGridViewImageWidget;

  const GridViewImageWidget({
    super.key,
    required this.images,
    required this.isEmptyGridViewImageWidget,
  });

  @override
  State<GridViewImageWidget> createState() => _GridViewImageWidgetState();
}

class _GridViewImageWidgetState extends State<GridViewImageWidget> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      itemCount: widget.images.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return _AddImagesButtonWidget(
            imagesSeleted: (value) {
              setState(() {
                widget.images.addAll(value);
                widget.isEmptyGridViewImageWidget(widget.images);
              });
            },
          );
        } else {
          final image = widget.images[index - 1].path;
          return GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Image.file(
                      File(image),
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const ErrorImage();
                      },
                    );
                  });
            },
            child: Stack(
              fit: StackFit.expand,
              children: [
                SizedBox(
                  height: 130.0,
                  width: 130.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24.0),
                    child: Image.file(
                      File(image),
                      height: 150.0,
                      width: 150.0,
                      fit: BoxFit.scaleDown,
                      errorBuilder: (context, error, stackTrace) {
                        return const ErrorImage();
                      },
                    ),
                  ),
                ),
                Positioned(
                  left: -2.0,
                  top: -4.0,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        widget.images.removeAt(index - 1);
                        widget.isEmptyGridViewImageWidget(widget.images);
                      });
                    },
                    icon: const Icon(
                      Icons.remove_circle_outline_outlined,
                      color: Colors.red,
                    ),
                  ),
                )
              ],
            ),
          );
        }
      },
    );
  }
}

class _AddImagesButtonWidget extends StatelessWidget {
  final _images = <XFile>[];
  final _picker = ImagePicker();
  final ValueChanged<List<XFile>> imagesSeleted;

  _AddImagesButtonWidget({required this.imagesSeleted});

  Future<void> imageSelect() async {
    final List<XFile> selectedImage = await _picker.pickMultiImage();

    _images.addAll(selectedImage);
    imagesSeleted(selectedImage);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: imageSelect,
      borderRadius: BorderRadius.circular(24.0),
      child: Container(
        height: 150.0,
        width: 150.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.0),
        ),
        child: const Icon(
          Icons.add,
          size: 40.0,
        ),
      ),
    );
  }
}
