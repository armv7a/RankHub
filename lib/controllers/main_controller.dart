import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainController extends GetxController {
  static const _firstLaunchKey = 'first_launch_jump_mine';

  // 当前选中的底部导航索引
  var currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _jumpToMineOnFirstLaunch();
  }

  // 切换底部导航
  void changeTabIndex(int index) {
    currentIndex.value = index;
  }

  Future<void> _jumpToMineOnFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstLaunch = prefs.getBool(_firstLaunchKey) ?? true;
    if (!isFirstLaunch) return;

    currentIndex.value = 4; // 我的
    await prefs.setBool(_firstLaunchKey, false);
  }
}
