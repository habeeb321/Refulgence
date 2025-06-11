import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

enum NavigationTab { home, favourite }

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationSelected(NavigationTab.home)) {
    on<TabSelectedEvent>((event, emit) {
      emit(NavigationSelected(event.tab));
    });
  }
}
