import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class AppConfigurations {
  static String url = dotenv.env["BASE_URL"] ?? '';
}
