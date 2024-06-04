import 'package:cubit_example/data/post_services.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupInjects() {
  getIt.registerSingleton<PostServices>(PostServices());

}