part of 'view_mode_cubit.dart';

class ViewModeState extends Equatable {
  final bool isGridView;

  const ViewModeState({
    this.isGridView = false, // Default to list view
  });

  ViewModeState copyWith({bool? isGridView}) {
    return ViewModeState(isGridView: isGridView ?? this.isGridView);
  }

  @override
  List<Object> get props => [isGridView];
}
