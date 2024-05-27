import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../features/pomodoro/_state/pomodoro_provider.dart';
import '../features/tts/_state/tts_provider.dart';
import 'common/ble.dart';
import 'common/data.dart';
import 'common/data_stage.dart';
import 'common/datetime.dart';
import 'common/global_provider.dart';
import 'common/hub.dart';
import 'common/input.dart';
import 'common/misc.dart';
import 'common/quill.dart';
import 'common/selection.dart';
import 'common/theme.dart';
import 'common/views.dart';

//
// all app providers
//

List<SingleChildWidget> allProviders = [
  ChangeNotifierProvider(create: (context) => DataProvider()),
  ChangeNotifierProvider(create: (context) => InputProvider()),
  ChangeNotifierProvider(create: (context) => StageProvider()),
  //
  ChangeNotifierProvider(create: (context) => QuillProvider()),
  ChangeNotifierProvider(create: (context) => TTSProvider()),
  ChangeNotifierProvider(create: (context) => PomodoroProvider()),
  ChangeNotifierProvider(create: (context) => BleProvider()),
  ChangeNotifierProvider(create: (context) => HubProvider()),
  //
  ChangeNotifierProvider(create: (context) => GlobalProvider()),
  ChangeNotifierProvider(create: (context) => ThemeProvider()),
  ChangeNotifierProvider(create: (context) => ViewsProvider()),
  ChangeNotifierProvider(create: (context) => DateTimeProvider()),
  ChangeNotifierProvider(create: (context) => SelectionProvider()),
  // misc
  ChangeNotifierProvider(create: (context) => ScrollProvider()),
  ChangeNotifierProvider(create: (context) => HoverProvider()),
  ChangeNotifierProvider(create: (context) => ShareProvider()),
];

//
// custom state shortcuts... i love shortcuts ;)
//

class AppState {
  late ThemeProvider theme;
  late GlobalProvider global;
  late DataProvider data;
  late InputProvider input;
  late StageProvider stage;
  late QuillProvider quill;
  late DateTimeProvider dateTime;
  late ViewsProvider views;
  late ViewsProvider labels;
  late SelectionProvider selection;
  late TTSProvider tts;
  late PomodoroProvider pomodoro;
  late BleProvider ble;
  late HubProvider hub;
  late ScrollProvider scroll;
  late HoverProvider hover;
  late ShareProvider share;

  void setContext(BuildContext appContext) {
    theme = appContext.read<ThemeProvider>();
    global = appContext.read<GlobalProvider>();
    data = appContext.read<DataProvider>();
    input = appContext.read<InputProvider>();
    stage = appContext.read<StageProvider>();
    quill = appContext.read<QuillProvider>();
    dateTime = appContext.read<DateTimeProvider>();
    views = appContext.read<ViewsProvider>();
    labels = appContext.read<ViewsProvider>();
    selection = appContext.read<SelectionProvider>();
    tts = appContext.read<TTSProvider>();
    pomodoro = appContext.read<PomodoroProvider>();
    ble = appContext.read<BleProvider>();
    hub = appContext.read<HubProvider>();
    scroll = appContext.read<ScrollProvider>();
    hover = appContext.read<HoverProvider>();
    share = appContext.read<ShareProvider>();
  }
}

AppState state = AppState();
