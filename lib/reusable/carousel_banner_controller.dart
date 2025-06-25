import 'package:carousel_slider/carousel_controller.dart';
import 'package:get/get.dart';

class CarouselBannerController extends GetxController implements GetxService {
  int activeIndex = 0;
  CarouselSliderController carouselController = CarouselSliderController();
  void onPagedChanged(int index) {
    activeIndex = index;
    update();
  }
}
