import 'package:flutter_bloc/flutter_bloc.dart';

class PageViewCubit extends Cubit<int>
{
  PageViewCubit() : super(0);

  void changeIndex(int index)
  {

    emit(state - state + index);
  }
}