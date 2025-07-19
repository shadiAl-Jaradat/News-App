part of 'search_cubit.dart';

class SearchState extends Equatable {
  final String currentQuery; // What user is currently typing
  final String searchQuery; // Debounced query for actual search
  final bool isSearching; // Whether search is active

  const SearchState({this.currentQuery = '', this.searchQuery = '', this.isSearching = false});

  SearchState copyWith({String? currentQuery, String? searchQuery, bool? isSearching}) {
    return SearchState(
      currentQuery: currentQuery ?? this.currentQuery,
      searchQuery: searchQuery ?? this.searchQuery,
      isSearching: isSearching ?? this.isSearching,
    );
  }

  @override
  List<Object> get props => [currentQuery, searchQuery, isSearching];
}
