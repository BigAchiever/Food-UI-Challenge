import 'package:flutter_bloc/flutter_bloc.dart';
part 'carousel_state.dart';

class CarouselCubit extends Cubit<CarouselState> {
  CarouselCubit()
      : super(
          const CarouselState(selectedCardIndex: 0),
        );

  void selectCard(int cardIndex) {
    emit(CarouselState(selectedCardIndex: cardIndex));
  }
}