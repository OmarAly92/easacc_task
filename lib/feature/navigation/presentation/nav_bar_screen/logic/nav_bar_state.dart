part of 'nav_bar_cubit.dart';

class NavBarState extends Equatable {
  const NavBarState({required this.currentIndex});

  final int currentIndex;

  @override
  List<Object> get props => [currentIndex];
}
