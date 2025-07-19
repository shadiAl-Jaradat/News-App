import 'package:equatable/equatable.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object?> get props => [];
}

class GetNewsEvent extends NewsEvent {
  final String? query;
  final bool isRefresh;

  const GetNewsEvent({this.query, this.isRefresh = false});

  @override
  List<Object?> get props => [query, isRefresh];
}

class RefreshNewsEvent extends NewsEvent {
  final String? query;

  const RefreshNewsEvent({this.query});

  @override
  List<Object?> get props => [query];
}
