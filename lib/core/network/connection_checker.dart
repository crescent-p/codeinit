import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract interface class Network{
  Future<bool> get isConnected;
}

class NetworkImpl implements Network {
  final InternetConnection connectionChecker;

  NetworkImpl({required this.connectionChecker});

  @override
  Future<bool> get isConnected => connectionChecker.hasInternetAccess;
}