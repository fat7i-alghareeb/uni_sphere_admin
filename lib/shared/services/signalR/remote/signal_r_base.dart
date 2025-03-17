abstract class SignalRBase {
  Future<void> initSignalR();

  Future<void> openConnection();

  Future<void> closeConnection();

  Future<String?> getUserToken();
}
