
abstract class ImageClassificationState {}

class ImageClassificationInitial extends ImageClassificationState {}

class ImageClassificationLoading extends ImageClassificationState {}

class ImageClassificationSuccess extends ImageClassificationState {
  final String label;

  ImageClassificationSuccess({required this.label});
}

class ImageClassificationError extends ImageClassificationState {
  final String message;

  ImageClassificationError({required this.message});
}
//////////////
class TrueCounterIncrease extends ImageClassificationState {}

class FalseCounterIncrease extends ImageClassificationState {}

////////////