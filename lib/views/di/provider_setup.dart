import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../controllers/exports.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (context) => OnBoardNotifier()),
  ChangeNotifierProvider(create: (context) => LoginNotifier()),
  ChangeNotifierProvider(create: (context) => ZoomNotifier()),
  ChangeNotifierProvider(create: (context) => SignUpNotifier()),
  ChangeNotifierProvider(create: (context) => JobsNotifier()),
  ChangeNotifierProvider(create: (context) => BookMarkNotifier()),
  ChangeNotifierProvider(create: (context) => ImageUploader()),
  ChangeNotifierProvider(create: (context) => ProfileNotifier()),
];