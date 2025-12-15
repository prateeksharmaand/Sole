import 'package:get/get.dart';
import 'package:sole/features/authentication/screens/onboarding/onboarding_screen.dart';
import 'package:sole/loading.dart';
import 'package:sole/routes/routes.dart';

class UAppRoutes{

  static final screens = [
     GetPage(name: URoutes.home, page: () => const LoadingScreen()),
    // GetPage(name: URoutes.store, page: () => const StoreScreen(),),
    // GetPage(name: URoutes.wishlist, page: () => const WishlistScreen(),),
    // GetPage(name: URoutes.profile, page: () => const ProfileScreen(),),
    // GetPage(name: URoutes.order, page: () => const OrderScreen(),),
    // GetPage(name: URoutes.checkout, page: () => const CheckoutScreen(),),
    // GetPage(name: URoutes.cart, page: () => const CartScreen(),),
    // GetPage(name: URoutes.editProfile, page: () => const EditProfileScreen(),),
    // GetPage(name: URoutes.userAddress, page: () => const AddressScreen(),),
    // GetPage(name: URoutes.signup, page: () => const SignupScreen(),),
    // GetPage(name: URoutes.verifyEmail, page: () => const VerifyEmailScreen(),),
    // GetPage(name: URoutes.signIn, page: () => const LoginScreen(),),
    // GetPage(name: URoutes.forgetPassword, page: () => const ForgetPasswordScreen(),),
   GetPage(name: URoutes.onBoarding, page: () =>  OnboardingScreen()),
  ];
}