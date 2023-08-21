import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/app/constants/enum.dart';
import 'package:the_wire/app/helpers/injection.config.dart';

// ignore_for_file: prefer-static-class
final GetIt getIt = GetIt.instance;

@InjectableInit(preferRelativeImports: false)
void configureDependencies(Env env) => getIt.init(environment: env.value);
