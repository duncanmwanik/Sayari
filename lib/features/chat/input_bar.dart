import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_providers/_providers.dart';
import '../../_providers/input.dart';
import '../../_variables/ui.dart';
import '../../_widgets/buttons/button.dart';
import '../../_widgets/others/icons.dart';
import '../../_widgets/others/text.dart';
import '../_spaces/_helpers/checks_space.dart';
import '../files/_helpers/helper.dart';
import '../files/_helpers/upload.dart';
import '../files/file_list.dart';
import '_helpers/send.dart';
import 'w/clear_btn.dart';
import 'w/scroll_btn.dart';
import 'w/send_btn.dart';

class MessageInputBar extends StatelessWidget {
  const MessageInputBar({super.key});

  @override
  Widget build(BuildContext context) {
    messageController.text = state.input.item.data['n'] ?? '';
    messageController.selection = TextSelection.collapsed(offset: messageController.text.length);

    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          //
          ScrollChatsButton(),
          //
          ClipRRect(
            borderRadius: BorderRadius.circular(borderRadiusTiny),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                decoration: BoxDecoration(
                  color: styler.appColor(1),
                  borderRadius: BorderRadius.circular(borderRadiusSmall),
                ),
                child: isAdmin()
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //
                          Consumer<InputProvider>(
                              builder: (context, input, child) => FileList(fileData: getFiles(input.item.data), isOverview: false)),
                          //
                          Row(
                            children: [
                              //
                              AppButton(
                                onPressed: () => getFilesToUpload(),
                                tooltip: 'Attach File',
                                height: 45,
                                width: 45,
                                noStyling: true,
                                isSquare: true,
                                borderRadius: borderRadiusSmall,
                                child: AppIcon(Icons.add_rounded),
                              ),
                              //
                              // AppButton(
                              //   onPressed: () => showAISheet(),
                              //   tooltip: 'Ask AI',
                              //   height: 45,
                              //   width: 45,
                              //   noStyling: true,
                              //   isSquare: true,
                              //   child: AppIcon(Icons.bubble_chart_sharp),
                              // ),
                              // Message Input
                              Expanded(
                                child: TextFormField(
                                  onFieldSubmitted: (_) => sendMessage(),
                                  onChanged: (value) => state.input.update('n', value.trim()),
                                  controller: messageController,
                                  keyboardType: TextInputType.multiline,
                                  textCapitalization: TextCapitalization.sentences,
                                  textInputAction: kIsWeb ? TextInputAction.next : null,
                                  minLines: 1,
                                  maxLines: 8,
                                  style: GoogleFonts.inter(fontSize: medium, color: styler.textColor()),
                                  decoration: InputDecoration(
                                    hintText: 'Type a message...',
                                    hintStyle: GoogleFonts.inter(fontSize: medium, color: styler.textColor(faded: true)),
                                    filled: false,
                                    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              //
                              spw(),
                              ClearMessageButton(),
                              SendMessageButton(),
                              //
                            ],
                          ),
                          //
                        ],
                      )
                    : Padding(
                        padding: paddingM(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppIcon(Icons.lock_rounded, size: medium, faded: true),
                            spw(),
                            Flexible(child: AppText(size: small, text: 'Only admins can send messages.', faded: true)),
                          ],
                        ),
                      ),
              ),
            ),
          ),
          //
        ],
      ),
    );
  }
}
