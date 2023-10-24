import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../manager/database_manager.dart';
import '../manager/location_manager.dart';
import '../repository/post_repository.dart';
import '../repository/user_repository.dart';
import '../viewmodel/comment_viewmodel.dart';
import '../viewmodel/feed_viewmodel.dart';
import '../viewmodel/login_viewmodel.dart';
import '../viewmodel/post_viewmodel.dart';
import '../viewmodel/profile_viewmodel.dart';
import '../viewmodel/search_viewmodel.dart';

List<SingleChildWidget> globalProviders = [...independentModels, ...dependentModels, ...viewModels];

List<SingleChildWidget> independentModels = [
  Provider<DatabaseManager>(create: (_) => DatabaseManager()),
  Provider<LocationManager>(create: (_) => LocationManager()),
];

List<SingleChildWidget> dependentModels = [
  ProxyProvider<DatabaseManager, UserRepository>(
    update: (_, databaseManager, userRepository) => UserRepository(databaseManager: databaseManager),
  ),
  ProxyProvider2<DatabaseManager, LocationManager, PostRepository>(
    update: (_, dbManager, locationManager, repo) =>
        PostRepository(dbManager: dbManager, locationManager: locationManager),
  ),
];

List<SingleChildWidget> viewModels = [
  ChangeNotifierProvider<LoginViewModel>(
    create: (context) => LoginViewModel(userRepository: context.read<UserRepository>()),
  ),
  ChangeNotifierProvider<PostViewModel>(
    create: (context) {
      return PostViewModel(
        postRepository: context.read<PostRepository>(),
        userRepository: context.read<UserRepository>(),
      );
    },
  ),
  ChangeNotifierProvider<FeedViewModel>(
    create: (context) => FeedViewModel(
      postRepository: context.read<PostRepository>(),
      userRepository: context.read<UserRepository>(),
    ),
  ),
  ChangeNotifierProvider<CommentViewModel>(
    create: (context) => CommentViewModel(
      postRepository: context.read<PostRepository>(),
      userRepository: context.read<UserRepository>(),
    ),
  ),
  ChangeNotifierProvider<ProfileViewModel>(
    create: (context) => ProfileViewModel(
      postRepository: context.read<PostRepository>(),
      userRepository: context.read<UserRepository>(),
    ),
  ),
  ChangeNotifierProvider<SearchViewModel>(
    create: (context) => SearchViewModel(
      userRepository: context.read<UserRepository>(),
    ),
  ),
];
