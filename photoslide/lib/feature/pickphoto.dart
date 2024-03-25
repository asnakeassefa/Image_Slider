import 'dart:ffi';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

import 'slider.dart';

class MultipleImageSelector extends StatefulWidget {
  const MultipleImageSelector({super.key});

  @override
  State<MultipleImageSelector> createState() => _MultipleImageSelectorState();
}

class _MultipleImageSelectorState extends State<MultipleImageSelector> {
  List<File> selectedImages = [];
  final picker = ImagePicker();
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // display image selected from gallery
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Gesture ',
                style: TextStyle(
                    fontFamily: 'poppins', fontWeight: FontWeight.w100),
              ),
              Text(
                'Drawing',
              )
            ],
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getImages();
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      body: Center(
        child: ListView(
          children: [
            SizedBox(height: 10),
            Container(
              height: 500,
              child: SizedBox(
                child: selectedImages.isEmpty
                    ? const Center(child: Text('Sorry nothing selected!!'))
                    : GridView.builder(
                        itemCount: selectedImages.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                child: kIsWeb
                                    ? Image.network(selectedImages[index].path)
                                    : Image.file(selectedImages[index],
                                        fit: BoxFit.cover),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SliderPage(images: selectedImages, sec: 30)),
                      );
                    },
                    child: const Text(
                      '30 sec',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SliderPage(images: selectedImages, sec: 45)),
                      );
                    },
                    child: const Text(
                      '45 sec',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SliderPage(
                                images: selectedImages, sec: 1 * 60)),
                      );
                    },
                    child: const Text(
                      '1 min',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SliderPage(
                                images: selectedImages, sec: 2 * 60)),
                      );
                    },
                    child: const Text(
                      '2 min',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SliderPage(
                                images: selectedImages, sec: 5 * 60)),
                      );
                    },
                    child: const Text(
                      '5 min',
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'Set Time',
                style: TextStyle(color: Color(0xff023047)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // textField wraped with container
                  Container(
                    height: 30,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    width: MediaQuery.sizeOf(context).width * 0.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 1, color: Color(0xff023047)),
                    ),
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      try {
                        int min = int.parse(controller.text);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SliderPage(images: selectedImages, sec: min)),
                        );
                      } catch (e) {
                        print("can't parse");
                      }
                    },
                    child: Text('Set'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future getImages() async {
    final pickedFile = await picker.pickMultiImage(
        imageQuality: 100, maxHeight: 1000, maxWidth: 1000);
    List<XFile> xfilePick = pickedFile;

    setState(
      () {
        if (xfilePick.isNotEmpty) {
          for (var i = 0; i < xfilePick.length; i++) {
            selectedImages.add(File(xfilePick[i].path));
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Nothing is selected')));
        }
      },
    );
  }
}
