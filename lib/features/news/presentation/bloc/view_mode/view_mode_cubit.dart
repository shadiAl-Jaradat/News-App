import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'view_mode_state.dart';

/// Cubit to manage the view mode (grid or list) for the news feed
class ViewModeCubit extends Cubit<ViewModeState> {
  ViewModeCubit() : super(const ViewModeState());

  void toggleView() {
    emit(state.copyWith(isGridView: !state.isGridView));
  }

  void setGridView() {
    if (!state.isGridView) {
      emit(state.copyWith(isGridView: true));
    }
  }

  void setListView() {
    if (state.isGridView) {
      emit(state.copyWith(isGridView: false));
    }
  }

  // Force list view on very small screens
  void checkScreenSize(bool canSwitchViews) {
    if (!canSwitchViews && state.isGridView) {
      emit(state.copyWith(isGridView: false));
    }
  }
}
