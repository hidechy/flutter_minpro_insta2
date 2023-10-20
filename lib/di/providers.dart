import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../manager/database_manager.dart';
import '../repository/user_repository.dart';
import '../viewmodel/login_viewmodel.dart';

List<SingleChildWidget> globalProviders = [...independentModels, ...dependentModels, ...viewModels];

List<SingleChildWidget> independentModels = [Provider<DatabaseManager>(create: (_) => DatabaseManager())];

List<SingleChildWidget> dependentModels = [
  ProxyProvider<DatabaseManager, UserRepository>(
    update: (_, databaseManager, userRepository) => UserRepository(databaseManager: databaseManager),
  ),

  // ProxyProvider<DatabaseManager, PostRepository>(
  //   update: (_, databaseManager, postRepository) {
  //     return PostRepository();
  //   },
  // )
];

List<SingleChildWidget> viewModels = [
  ChangeNotifierProvider<LoginViewModel>(
    create: (context) => LoginViewModel(userRepository: context.read<UserRepository>()),
  ),

  // ChangeNotifierProvider<PostViewModel>(
  //   create: (context) {
  //     return PostViewModel(
  //       postRepository: context.read<PostRepository>(),
  //       userRepository: context.read<UserRepository>(),
  //     );
  //   },
  // ),
];
