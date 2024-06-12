abstract interface class SplashRepository {
  Future<void> getUserFromCache();
}

class SplashRepositoryImpl implements SplashRepository {
  @override
  Future<void> getUserFromCache() async {
    await Future.delayed(const Duration(seconds: 1));
  }
}
