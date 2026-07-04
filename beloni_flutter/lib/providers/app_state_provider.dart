import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) => throw UnimplementedError());

class AppState {
  final bool isFirstTime;
  final String? accessToken;
  final String? refreshToken;

  AppState({
    required this.isFirstTime,
    this.accessToken,
    this.refreshToken,
  });

  AppState copyWith({
    bool? isFirstTime,
    String? accessToken,
    String? refreshToken,
  }) {
    return AppState(
      isFirstTime: isFirstTime ?? this.isFirstTime,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }
}

class AppStateNotifier extends StateNotifier<AppState> {
  final SharedPreferences _prefs;

  AppStateNotifier(this._prefs)
      : super(AppState(
          isFirstTime: _prefs.getBool('isFirstTime') ?? true,
          accessToken: _prefs.getString('accessToken'),
          refreshToken: _prefs.getString('refreshToken'),
        ));

  Future<void> setIsFirstTime(bool value) async {
    await _prefs.setBool('isFirstTime', value);
    state = state.copyWith(isFirstTime: value);
  }

  Future<void> setTokens(String access, String refresh) async {
    await _prefs.setString('accessToken', access);
    await _prefs.setString('refreshToken', refresh);
    state = state.copyWith(accessToken: access, refreshToken: refresh);
  }

  Future<void> logout() async {
    await _prefs.remove('accessToken');
    await _prefs.remove('refreshToken');
    state = state.copyWith(accessToken: null, refreshToken: null);
  }
}

final appStateProvider = StateNotifierProvider<AppStateNotifier, AppState>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return AppStateNotifier(prefs);
});
