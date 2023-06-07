import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import 'package:google_fonts/google_fonts.dart';

class ExploreObject extends StatefulWidget {
  const ExploreObject({Key? key}) : super(key: key);

  @override
  State<ExploreObject> createState() => _TfliteModelState();
}

class _TfliteModelState extends State<ExploreObject> {
  late File _image;
  late List _results;
  bool imageSelect=false;
  @override
  void initState(){
    super.initState();
    loadModel();
  }
  Future loadModel() async {
    Tflite.close();
    String res;
    res= (await Tflite.loadModel(model:"assets/model.tflite" ,labels:"assets/labels.txt" ))!;
    print("models loading status: $res");
  }
  Future imageClassification(File image) async {
    var recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 1,
      threshold: 0.05,
      imageMean: 0,
      imageStd: 255,
      asynch: true,

    );
    setState(() {
      _results=recognitions!;
      _image=image;
      imageSelect=true;
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   title: const Text("Image classification"),
        // ),
        backgroundColor: const Color(0xff92DAC9),
        body: Padding(
          padding: const EdgeInsets.only(top: 7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    height:  MediaQuery
                        .of(context)
                        .size
                        .height - 200,
                    // width:,
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 3,
                          offset: Offset(2.0, 2.0),
                        ),
                      ],
                      color: const Color(0xffFFFBE5),
                      borderRadius: BorderRadius.circular(10),
                      border: const Border.fromBorderSide(BorderSide(
                          strokeAlign: BorderSide.strokeAlignInside
                      )),


                    ),
                    child: Column(
                      children: [
                        
                        Expanded(
                          child: ListView(
                            children: [
                              (imageSelect)?Container(
                                margin: const EdgeInsets.all(10),

                                child: Image.file(_image),
                              ):Padding(
                                padding: const EdgeInsets.only(top: 100),
                                child: Container(
                                  margin:const EdgeInsets.all(10) ,
                                  child:  Opacity(
                                    opacity: 0.8,
                                    child: Center(
                                      child: Text("No image selected",style:GoogleFonts.alegreya(fontWeight: FontWeight.w500, fontSize: 24),),
                                    ),
                                  ),
                                ),
                              ),
                              SingleChildScrollView(
                                child: Column(
                                  children: (imageSelect)?_results.map((results) {
                                    return Card(
                                      shape: const Border.fromBorderSide(
                                        BorderSide(
                                          strokeAlign: BorderSide.strokeAlignOutside,
                                        ),

                                      ),
                                      color: const Color(0xff92DAC9),
                                      child: Container(
                                        margin: const EdgeInsets.all(10),
                                        color: const Color(0xff92DAC9),
                                        child: Text(
                                          "${results['label']} ",
                                          style: GoogleFonts.akayaKanadaka(fontSize: 25,color: Colors.black),

                                        ),
                                      ),
                                    );

                                  }).toList():[],


                                ),

                              ),

                            ],


                          ),
                        ),
                        InkWell(
                          onTap: pickImage,
                          child: Container(
                            height: 50,
                            width: 180,
                            margin: const EdgeInsets.only(bottom: 20),

                            decoration: BoxDecoration(

                              borderRadius: BorderRadius.circular(10),
                              border: const Border.fromBorderSide(BorderSide(
                                  strokeAlign: BorderSide.strokeAlignInside
                              )),
                              color: const Color(0xff92DAC9
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 2,
                                  offset: Offset(2.0, 2.0),
                                ),
                              ],
                            ),
                            child: Center(child: Row(
                              children: [
                                const SizedBox(width: 7,),
                                const Icon(Icons.file_upload_sharp,color: Colors.black,),
                                const SizedBox(width: 7,),
                                Text('Upload image',style: GoogleFonts.cairo(fontWeight:FontWeight.bold,fontSize: 18, ),),
                              ],
                            )),

                          ),
                        ),
                      ],

                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        // floatingActionButton: FloatingActionButton(
        //   backgroundColor: const Color(0xff92DAC9),
        //   onPressed: pickImage,
        //   tooltip: "Pick Image",
        //   child: const Icon(Icons.image,),
        // ),

      ),
    );
  }
  Future pickImage()
  async{
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 224,
      maxHeight:224,

    );
    File image=File(pickedFile!.path);
    imageClassification(image);
  }



}


