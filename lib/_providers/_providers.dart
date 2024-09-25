import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../features/_notes/state/quill.dart';
import '../features/_notes/state/selection.dart';
import '../features/calendar/state/datetime.dart';
import '../features/chat/state/chat.dart';
import '../features/files/state/data.dart';
import '../features/pomodoro/state/pomodoro.dart';
import '../features/share/state/share.dart';
import '../features/tts/_state/tts_provider.dart';
import 'global.dart';
import 'hover.dart';
import 'input.dart';
import 'theme.dart';
import 'views.dart';

//
// all app providers
//

List<SingleChildWidget> allProviders = [
  ChangeNotifierProvider(create: (context) => DataProvider()),
  ChangeNotifierProvider(create: (context) => InputProvider()),
  //
  ChangeNotifierProvider(create: (context) => QuillProvider()),
  ChangeNotifierProvider(create: (context) => TTSProvider()),
  ChangeNotifierProvider(create: (context) => PomodoroProvider()),
  ChangeNotifierProvider(create: (context) => ChatProvider()),
  //
  ChangeNotifierProvider(create: (context) => GlobalProvider()),
  ChangeNotifierProvider(create: (context) => ThemeProvider()),
  ChangeNotifierProvider(create: (context) => ViewsProvider()),
  ChangeNotifierProvider(create: (context) => DateTimeProvider()),
  ChangeNotifierProvider(create: (context) => SelectionProvider()),
  // misc
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
  late QuillProvider quill;
  late DateTimeProvider dateTime;
  late ViewsProvider views;
  late SelectionProvider selection;
  late TTSProvider tts;
  late PomodoroProvider pomodoro;
  late ChatProvider chat;
  late HoverProvider hover;
  late ShareProvider share;

  void setContext(BuildContext appContext) {
    theme = appContext.read<ThemeProvider>();
    global = appContext.read<GlobalProvider>();
    data = appContext.read<DataProvider>();
    input = appContext.read<InputProvider>();
    quill = appContext.read<QuillProvider>();
    dateTime = appContext.read<DateTimeProvider>();
    views = appContext.read<ViewsProvider>();
    selection = appContext.read<SelectionProvider>();
    tts = appContext.read<TTSProvider>();
    pomodoro = appContext.read<PomodoroProvider>();
    chat = appContext.read<ChatProvider>();
    hover = appContext.read<HoverProvider>();
    share = appContext.read<ShareProvider>();
  }
}

AppState state = AppState();
