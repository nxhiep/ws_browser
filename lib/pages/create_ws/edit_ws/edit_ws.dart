import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditWS extends StatefulWidget {
  const EditWS({ Key? key }) : super(key: key);

  @override
  State<EditWS> createState() => _EditWSState();
}

class _EditWSState extends State<EditWS> {

  final ImagePicker _picker = ImagePicker();
  List<XFile>? _imageFileList;
  dynamic _pickImageError;
  String? _retrieveDataError;
  
  void _setImageFileListFromFile(XFile? value) {
    _imageFileList = value == null ? null : <XFile>[value];
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        !kIsWeb && defaultTargetPlatform == TargetPlatform.android
          ? FutureBuilder<void>(
              future: retrieveLostData(),
              builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return const Text(
                      'You have not yet picked an image.',
                      textAlign: TextAlign.center,
                    );
                  case ConnectionState.done:
                    return _handlePreview();
                  default:
                    if (snapshot.hasError) {
                      return Text(
                        'Pick image/video error: ${snapshot.error}}',
                        textAlign: TextAlign.center,
                      );
                    } else {
                      return const Text(
                        'You have not yet picked an image.',
                        textAlign: TextAlign.center,
                      );
                    }
                }
              },
            )
          : _handlePreview(),
        Positioned(
          right: 50,
          bottom: 50,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Semantics(
                label: 'image_picker_example_from_gallery',
                child: FloatingActionButton(
                  onPressed: () {
                    _onImageButtonPressed(ImageSource.gallery);
                  },
                  heroTag: 'image0',
                  tooltip: 'Pick Image from gallery',
                  child: const Icon(Icons.photo),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: FloatingActionButton(
                  onPressed: () {
                    _onImageButtonPressed(ImageSource.gallery, isMultiImage: true);
                  },
                  heroTag: 'image1',
                  tooltip: 'Pick Multiple Image from gallery',
                  child: const Icon(Icons.photo_library),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: FloatingActionButton(
                  onPressed: () {
                    _onImageButtonPressed(ImageSource.camera);
                  },
                  heroTag: 'image2',
                  tooltip: 'Take a Photo',
                  child: const Icon(Icons.camera_alt),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _handlePreview() {
    return _previewImages();
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        if (response.files == null) {
          _setImageFileListFromFile(response.file);
        } else {
          _imageFileList = response.files;
        }
      });
    } else {
      _retrieveDataError = response.exception!.code;
    }
  }

  Future<void> _onImageButtonPressed(ImageSource source, { bool isMultiImage = false }) async {
    if (isMultiImage) {
      try {
        final List<XFile>? pickedFileList = await _picker.pickMultiImage();
        setState(() {
          _imageFileList = pickedFileList;
        });
      } catch (e) {
        setState(() {
          _pickImageError = e;
        });
      }
    } else {
      try {
        final XFile? pickedFile = await _picker.pickImage(source: source);
        print("pickedFile ${pickedFile?.name}");
        setState(() {
          _setImageFileListFromFile(pickedFile);
        });
      } catch (e) {
        setState(() {
          _pickImageError = e;
        });
      }
    }
  }

  Widget _previewImages() {
    final Text? retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_imageFileList != null) {
      return Semantics(
        label: 'image_picker_example_picked_images',
        child: ListView.builder(
          key: UniqueKey(),
          itemBuilder: (BuildContext context, int index) {
            // Why network for web?
            // See https://pub.dev/packages/image_picker#getting-ready-for-the-web-platform
            return Semantics(
              label: 'image_picker_example_picked_image',
              child: kIsWeb
                  ? Image.network(_imageFileList![index].path)
                  : Image.file(File(_imageFileList![index].path)),
            );
          },
          itemCount: _imageFileList!.length,
        ),
      );
    } else if (_pickImageError != null) {
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return const Text(
        'You have not yet picked an image.',
        textAlign: TextAlign.center,
      );
    }
  }

  Text? _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError!);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }
}

typedef OnPickImageCallback = void Function(double? maxWidth, double? maxHeight, int? quality);