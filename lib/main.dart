import 'main/wanandroid_main.dart' as wanandroid;

void main() {
  final flavor = Architecture.wanandroid;
  switch (flavor) {
    case Architecture.wanandroid:
      wanandroid.main();
      return;
  }
}

enum Architecture { wanandroid }
