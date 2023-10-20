import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../manager/database_manager.dart';
import '../repository/user_repository.dart';
import '../viewmodel/login_viewmodel.dart';

List<SingleChildWidget> globalProviders = [...independentModels, ...dependentModels, ...viewModels];

List<SingleChildWidget> independentModels = [Provider<DatabaseManager>(create: (_) => DatabaseManager())];

List<SingleChildWidget> dependentModels = [
  ProxyProvider<DatabaseManager, UserRepository>(update: (_, dbManager, repo) => UserRepository(dbManager: dbManager)),
];

List<SingleChildWidget> viewModels = [
  ChangeNotifierProvider<LoginViewModel>(
    create: (context) => LoginViewModel(userRepository: Provider.of<UserRepository>(context, listen: false)),
  ),
];
