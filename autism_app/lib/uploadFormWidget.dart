import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
//import 'package:video_thumbnail/video_thumbnail.dart';
//import 'package:multi_media_picker/multi_media_picker.dart';

Size screenSize(BuildContext context) {return MediaQuery.of(context).size;}
double screenHeight(BuildContext context, {double coeff = 1}) {return screenSize(context).height * coeff;}
double screenWidth(BuildContext context, {double coeff = 1}) {return screenSize(context).width * coeff;}

class UploadFormWidget extends StatefulWidget {
  UploadFormWidget({Key key}) : super(key: key);

  @override
  _UploadFormWidgetState createState() => _UploadFormWidgetState();
}

class _UploadFormWidgetState extends State<UploadFormWidget> {

  var errorMessageColor = Colors.black;
  bool loading = false;
  List<File> files = [null, null];
  List<String> textButton = ["Add a video", "Add a video"];
  final picker = ImagePicker();

  void getFile(index) async {
    final pickedFile = await ImagePicker.pickVideo(source: ImageSource.gallery);
    if (pickedFile == null) return;
    setState(() {
      files[index] = pickedFile;
    });
    if(files[index] != null)
      textButton[index] = "Change video";
    else
      textButton[index] = "Add a video";
  }

  Future uploadImage() async {
    Response response;
    String uploadURL = 'http://192.168.1.45:8080/api/upload';
    Dio dio = new Dio();
    FormData formData = FormData.fromMap({
      "email": "test",
      "files": [
        await MultipartFile.fromFile(files[0].path, filename: files[0].path.split('/').last),
        await MultipartFile.fromFile(files[1].path, filename: files[1].path.split('/').last),
      ]
    });
    setState(() {
      loading = !loading;
    });
    Scaffold.of(context).showSnackBar(new SnackBar(
        content: new Text("Submission..."), duration: const Duration(seconds: 1),));
    try {
      response = await dio.post(uploadURL, data: formData).timeout(const Duration(seconds: 10));
    }
    catch(e) {
      Scaffold.of(context).showSnackBar(new SnackBar(
          content: new Text("Upload error")));
    }
    if (response != null && response.statusCode == 201) {
      Scaffold.of(context).showSnackBar(new SnackBar(
          content: new Text("Upload done")));
    }
    setState(() {
      loading = !loading;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Spacer(),
        Text("Select videos of your child for more analysis:"),
        Spacer(),
        Container(
          width: screenWidth(context, coeff:0.9),
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            //border: Border.all(),
            borderRadius: BorderRadius.all(Radius.circular(3.0)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Spacer(),
              files[0] == null
                  ? Text('No file selected.', style: new TextStyle(color: errorMessageColor),)
                  : Row(
                    children: <Widget>[
                      Icon(Icons.check, color: Colors.green,),
                      Text('  Selected.', style: new TextStyle(color: Colors.green),)
                    ],
                  ),
              Spacer(),
              RaisedButton(
                child: Text(textButton[0]),
                onPressed: () {
                  getFile(0);
                },
                color: Colors.blue,
                textColor: Colors.white,
              ),
              Spacer(),
            ],
          ),
        ),
        Container(
          width: screenWidth(context, coeff:1),
        ),
        Container(
          width: screenWidth(context, coeff:0.9),
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            //border: Border.all(),
            borderRadius: BorderRadius.all(Radius.circular(3.0)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Spacer(),
                files[1] == null
                    ? Text('No file selected.', style: new TextStyle(color: errorMessageColor),)
                    : Row(
                  children: <Widget>[
                    Icon(Icons.check, color: Colors.green,),
                    Text('  Selected.', style: new TextStyle(color: Colors.green),)
                  ],
                ),
                Spacer(),
                RaisedButton(
                  child: Text(textButton[1]),
                  onPressed: () {
                    getFile(1);
                  },
                  color: Colors.blue,
                  textColor: Colors.white,
                ),
                Spacer(),
              ],
            ),
          ),
        ),
        Spacer(),
        loading
            ? CircularProgressIndicator()
            : RaisedButton(
              child: Text('Submit'),
              onPressed: () {
                if ((files[0] != null) & (files[1] != null) ) {
                  uploadImage();
                }
                else {
                  setState(() {
                    errorMessageColor = Colors.red;
                    Scaffold.of(context).showSnackBar(new SnackBar(
                        content: new Text("Complete all fields")));
                  });
                }
              },
              color: Colors.blue,
              textColor: Colors.white,
            ),
        Spacer(),
      ],
    );
  }
}


/*Future getThumbnail(video)  {
    return VideoThumbnail.thumbnailData(
      video: video.path,
      imageFormat: ImageFormat.JPEG,
      maxWidth: 128,
      quality: 25,
    );
  }*/

/*FutureBuilder<Uint8List>(
  future: VideoThumbnail.thumbnailData(
    video: files[1].path,
    imageFormat: ImageFormat.JPEG,
    maxWidth: 128,
    quality: 25,
  ),
  builder: (BuildContext context, AsyncSnapshot<Uint8List> snapshot) {
     if (snapshot.hasData)
       return Image.file(File.fromRawPath(snapshot.data));
     else if (snapshot.hasError) return Text(snapshot.error);
     else return SizedBox(
       child: CircularProgressIndicator(),
       width: 60,
       height: 60,
     );
  },
),*/