import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/core/utils/debouncer.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final Debouncer _debouncer;
  String _lastTriggeredQuery = '';

  SearchCubit() : _debouncer = Debouncer(delay: const Duration(milliseconds: 700)), super(const SearchState());

  void searchChanged(String query) {
    emit(state.copyWith(currentQuery: query));

    _debouncer.cancel();

    _debouncer.call(() => _triggerSearchIfNeeded(query));
  }

  void _triggerSearchIfNeeded(String query) {
    final trimmedQuery = query.trim();

    if (_lastTriggeredQuery == trimmedQuery) return;

    if (trimmedQuery.isNotEmpty && trimmedQuery.length < 2) return;

    _lastTriggeredQuery = trimmedQuery;

    if (trimmedQuery.isEmpty) {
      emit(state.copyWith(searchQuery: '', isSearching: false));
    } else {
      emit(state.copyWith(searchQuery: trimmedQuery, isSearching: true));
    }
  }
}
