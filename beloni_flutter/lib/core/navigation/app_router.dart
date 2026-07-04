import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/app_state_provider.dart';
import '../../features/onboarding_screen.dart';
import '../../features/signin_screen.dart';
import '../../features/signup_screen.dart';
import '../../features/forgot_password_screen.dart';
import '../../features/forgot_password_sent_email_screen.dart';
import '../../features/new_password_screen.dart';
import '../../features/product_detail_screen.dart';
import '../../features/main_tab_screen.dart';
import '../../features/shop_screen.dart';
import '../../features/verify_phone_screen.dart';
import '../../features/confirmation_code_screen.dart';
import '../../features/signup_success_screen.dart';
import '../../features/edit_profile_screen.dart';
import '../../features/order_history_screen.dart';
import '../../features/my_address_screen.dart';
import '../../features/my_promocodes_screen.dart';
import '../../features/faq_screen.dart';
import '../../features/payment_method_screen.dart';
import '../../features/wishlist_screen.dart';
import '../../features/add_card_screen.dart';
import '../../features/order_successful_screen.dart';
import '../../features/order_failed_screen.dart';
import '../../features/add_address_screen.dart';
import '../../features/leave_review_screen.dart';
import '../../features/reviews_screen.dart';
import '../../features/add_promocode_screen.dart';
import '../../models/product_model.dart';
import '../../models/review_model.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final appState = ref.watch(appStateProvider);

  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      final isFirstTime = appState.isFirstTime;
      final isLoggedIn = appState.accessToken != null;

      if (isFirstTime) {
        if (state.matchedLocation != '/onboarding') return '/onboarding';
      } else if (!isLoggedIn) {
        final authRoutes = [
          '/signin',
          '/signup',
          '/forgot-password',
          '/forgot-password-sent',
          '/new-password',
          '/verify-phone',
          '/confirmation-code',
          '/signup-success'
        ];
        if (!authRoutes.contains(state.matchedLocation)) return '/signin';
      } else {
        if (state.matchedLocation == '/onboarding' || state.matchedLocation == '/signin') return '/';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/signin',
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: '/forgot-password',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: '/forgot-password-sent',
        builder: (context, state) => const ForgotPasswordSentEmailScreen(),
      ),
      GoRoute(
        path: '/new-password',
        builder: (context, state) => const NewPasswordScreen(),
      ),
      GoRoute(
        path: '/verify-phone',
        builder: (context, state) => const VerifyPhoneScreen(),
      ),
      GoRoute(
        path: '/confirmation-code',
        builder: (context, state) => const ConfirmationCodeScreen(),
      ),
      GoRoute(
        path: '/signup-success',
        builder: (context, state) => const SignUpSuccessScreen(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const MainTabScreen(),
      ),
      GoRoute(
        path: '/product',
        builder: (context, state) {
          final product = state.extra as ProductModel;
          return ProductDetailScreen(product: product);
        },
      ),
      GoRoute(
        path: '/shop',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return ShopScreen(
            products: extra?['products'] as List<ProductModel>?,
            title: extra?['title'] as String? ?? 'Shop',
          );
        },
      ),
      GoRoute(
        path: '/edit-profile',
        builder: (context, state) => const EditProfileScreen(),
      ),
      GoRoute(
        path: '/order-history',
        builder: (context, state) => const OrderHistoryScreen(),
      ),
      GoRoute(
        path: '/my-address',
        builder: (context, state) => const MyAddressScreen(),
      ),
      GoRoute(
        path: '/my-promocodes',
        builder: (context, state) => const MyPromocodesScreen(),
      ),
      GoRoute(
        path: '/add-promocode',
        builder: (context, state) => const AddPromocodeScreen(),
      ),
      GoRoute(
        path: '/faq',
        builder: (context, state) => const FAQScreen(),
      ),
      GoRoute(
        path: '/payment-method',
        builder: (context, state) => const PaymentMethodScreen(),
      ),
      GoRoute(
        path: '/wishlist',
        builder: (context, state) => const WishlistScreen(),
      ),
      GoRoute(
        path: '/add-card',
        builder: (context, state) => const AddCardScreen(),
      ),
      GoRoute(
        path: '/order-successful',
        builder: (context, state) => const OrderSuccessfulScreen(),
      ),
      GoRoute(
        path: '/order-failed',
        builder: (context, state) => const OrderFailedScreen(),
      ),
      GoRoute(
        path: '/add-address',
        builder: (context, state) => const AddAddressScreen(),
      ),
      GoRoute(
        path: '/leave-review',
        builder: (context, state) => const LeaveReviewScreen(),
      ),
      GoRoute(
        path: '/reviews',
        builder: (context, state) {
          final reviews = state.extra as List<ReviewModel>;
          return ReviewsScreen(reviews: reviews);
        },
      ),
    ],
  );
});
