// // ignore_for_file: depend_on_referenced_packages

// // 📦 Package imports:
// import 'package:logging/logging.dart';
// import 'package:signalr_netcore/signalr_client.dart';

// // 🌎 Project imports:
// import '../../../../app/auth/infrastructure/data_source/local/auth_local.dart';
// import '../../../../app/auth/infrastructure/data_source/remote/auth_remote.dart';
// import '../../../constant/src/url.dart';
// import '../../../imports/imports.dart';
// import '../../../injection/injection.dart';
// import '../../../states/signalr_provider.dart';
// import '../../refresh_token_helper.dart';
// import 'signal_r_base.dart';

// class NotificationsAndCartsUpdater extends SignalRBase {
//   late String? userToken;
//   HubConnection? hubMapConnection;
//   bool isHubInitiated = false;
//   bool isMapHubConnected = false;
//   bool isMapHubClosed = false;
//   int? numberOfUnReadNotifications;
//   int? numberOfShoppingCarts;
//   String? currency;
//   final NotificationProvider notificationProvider;
//   final CurrencyProvider currencyProvider;
//   NotificationsAndCartsUpdater(
//       {required this.notificationProvider, required this.currencyProvider});
//   @override
//   Future<void> initSignalR() async {
//     try {
//       userToken = await getUserToken();
//       final hubPortLogger = Logger("SignalR - hub");
//       final transportPortLogger = Logger("SignalR - transport");

//       final httpOptions = HttpConnectionOptions(
//         logger: transportPortLogger,
//         requestTimeout: 15000,
//         skipNegotiation: false,
//         accessTokenFactory: () async => userToken ?? "",
//         transport: HttpTransportType.WebSockets,
//       );

//       hubMapConnection = HubConnectionBuilder()
//           .withUrl(
//             "${AppUrl.baseUrlDevelopment}Hub/MainPage",
//             options: httpOptions,
//           )
//           .configureLogging(hubPortLogger)
//           .build();

//       hubMapConnection!.on("ReceiveMessage", (arguments) {
//         if (arguments != null && arguments.isNotEmpty) {
//           final data = arguments[0] as Map<String, dynamic>;
//           numberOfUnReadNotifications =
//               data["numberOfUnReadNotifications"] ?? 0;
//           numberOfShoppingCarts = data["numberOfShoppingCarts"] ?? 0;
//           currency = data["currency"] ?? "";
//           notificationProvider
//               .updateUnreadNotifications(numberOfUnReadNotifications!);
//           notificationProvider.updateShoppingCarts(numberOfShoppingCarts!);
//           currencyProvider.updateCurrency(currency ?? "");
//           printG(
//               "Updated Notifications: $numberOfUnReadNotifications, Shopping Carts: $numberOfShoppingCarts and Currency: $currency");
//         }
//       });

//       hubMapConnection!.onclose(({error}) {
//         printR("Updating Warning hubMapConnection Closed");
//         isHubInitiated = false;
//         isMapHubConnected = false;
//         isMapHubClosed = true;
//       });

//       hubMapConnection!.onreconnected(({connectionId}) {
//         isMapHubConnected = true;
//         isMapHubClosed = false;
//       });

//       hubMapConnection!.onreconnecting(({error}) {
//         isMapHubConnected = false;
//       });

//       isHubInitiated = userToken != "" && (hubMapConnection != null);
//       isMapHubConnected = true;
//     } catch (e, s) {
//       debugPrint(e.toString());
//       debugPrint(s.toString());
//     }
//   }

//   @override
//   Future<void> openConnection() async {
//     try {
//       if (isHubInitiated) {
//         await hubMapConnection?.start();
//       } else {
//         await initSignalR();
//         await hubMapConnection!.start();
//         printW("Updating Warning signal r connected");
//       }
//     } catch (e) {
//       printW("Updating Warning signal r Error $e");
//       debugPrint(e.toString());
//     }
//   }

//   @override
//   Future<void> closeConnection() async {
//     try {
//       if (isHubInitiated) {
//         await hubMapConnection!.stop();
//       }
//     } catch (e) {
//       printB(e.toString());
//     }
//   }

//   @override
//   Future<String> getUserToken() async {
//     final user = getIt<AuthLocal>().getUser();
//     String accessToken = user?.accessToken ?? '';
//     if (isTokenAboutToExpire(accessToken) && user != null) {
//       accessToken = await getIt<AuthRemote>().refreshToken(user: user);
//     }
//     return accessToken;
//   }

//   Future<int> getNumberOfUnReadNotifications() async {
//     numberOfUnReadNotifications = null;
//     if (!isHubInitiated) {
//       await openConnection();
//     }
//     while (numberOfUnReadNotifications == null) {
//       await Future.delayed(const Duration(milliseconds: 300));
//     }
//     return numberOfUnReadNotifications!;
//   }

//   Future<int> getNumberOfShoppingCarts() async {
//     numberOfShoppingCarts = null;
//     if (!isHubInitiated) {
//       await openConnection();
//     }
//     while (numberOfShoppingCarts == null) {
//       await Future.delayed(const Duration(milliseconds: 300));
//     }
//     return numberOfShoppingCarts!;
//   }
// }
