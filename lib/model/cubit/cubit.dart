import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kindergarten1/model/cubit/states.dart';
import 'package:tflite/tflite.dart';



class ImageClassificationCubit extends Cubit<ImageClassificationState> {
  List<String> labels = [];
  List<bool> result =[] ;

  int trueCounter=0;
  int falseCounter=0;

  ///////////////////////////
   compareLists(List<String> list1, List<String> list2) {
    for (int i = 0; i < list1.length; i++) {
      if (list1[i] == list2[i]) {
        result.add(true);
      } else {
        result.add(false);
      }
      for (int i = 0; i < result.length; i++) {
        if (result[i]) {
          trueCounter++;
        } else {
          falseCounter++;
        }
      }
    return result;
    }
}
  ///////////////////////////

  void compareListss(List<dynamic> list1, List<dynamic> list2){
    for(int i =0; i< list1.length && i <list2.length; i++  ){
      result.add(list1[i]==list2[i]);
    }
  }
  void countBooleans(List<bool> lst) {
    for (bool element in lst) {
      if (element == true) {
          trueCounter++;
          emit(TrueCounterIncrease());
      } else {
          falseCounter++;
        emit(FalseCounterIncrease());
      }
    }
  }

  ImageClassificationCubit() : super(ImageClassificationInitial());

  static ImageClassificationCubit get(context) =>
      BlocProvider.of(context);

  Future<void> classifyImage(File imageFile) async {
    try {
      // Load the TFLite model.
      await Tflite.loadModel(
        model: 'assets/model.tflite',
        labels: 'assets/labels.txt',
      );

      // Run the image through the TFLite model.
      List? results = await Tflite.runModelOnImage(
        path: imageFile.path,
        numResults: 1,
        threshold: 0.05,
        imageMean: 127.5,
        imageStd: 127.5,
        asynch: true,
      );

      // Get the label from the results.
      String label = results?[0]['label'];

      // Add the label to the list of labels.
      labels.add(label);
      print(results);

      // Update the state with the label.
      emit(ImageClassificationSuccess(label: label));
    } catch (e) {
      // Handle any errors that occur.
      emit(ImageClassificationError(message: e.toString()));
    } finally {
      // Clean up the TFLite model.
      await Tflite.close();
    }
  }
}