import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_providers/common/input.dart';
import '../../_providers/providers.dart';
import '../../_variables/ui.dart';
import '../../_widgets/abcs/buttons/buttons.dart';
import '../../_widgets/others/icons.dart';
import '../../_widgets/others/text.dart';
import '../_spaces/_helpers/checks_space.dart';
import '../ai/ai_sheet.dart';
import '../files/_helpers/helper.dart';
import '../files/_helpers/upload.dart';
import '../files/file_list.dart';
import '_helpers/send_message.dart';
import '_w/send_btn.dart';

class MessageInputBar extends StatelessWidget {
  const MessageInputBar({super.key});

  @override
  Widget build(BuildContext context) {
    messageController.text = state.input.data['n'] ?? '';
    messageController.selection = TextSelection.collapsed(offset: messageController.text.length);

    return Align(
      alignment: Alignment.bottomCenter,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadiusSmall),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
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
                          builder: (context, input, child) => FileList(fileData: getFiles(input.data), isOverview: false)),
                      //
                      Row(
                        children: [
                          //
                          AppButton(
                            onPressed: () async => getFilesToUpload(),
                            tooltip: 'Attach',
                            height: 45,
                            width: 45,
                            noStyling: true,
                            isSquare: true,
                            child: AppIcon(Icons.add_rounded),
                          ),
                          //
                          AppButton(
                            onPressed: () => showAISheet(),
                            tooltip: 'AI Prompt',
                            height: 45,
                            width: 45,
                            noStyling: true,
                            isSquare: true,
                            child: AppIcon(Icons.blur_on),
                          ),
                          // Message Input
                          Expanded(
                            child: TextFormField(
                              onFieldSubmitted: (_) => sendMessage(),
                              onChanged: (value) => state.input.update(action: 'add', key: 'n', value: value.trim()),
                              controller: messageController,
                              keyboardType: TextInputType.multiline,
                              textCapitalization: TextCapitalization.sentences,
                              textInputAction: kIsWeb ? TextInputAction.next : null,
                              minLines: 1,
                              maxLines: 8,
                              style: TextStyle(fontSize: medium, fontWeight: FontWeight.w600, color: styler.textColor()),
                              decoration: InputDecoration(
                                hintText: 'Type a message...',
                                hintStyle: TextStyle(fontSize: medium, fontWeight: FontWeight.w600, color: styler.textColor(faded: true)),
                                filled: false,
                                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          //
                          spw(),
                          //
                          SendMessageButton(),
                          //
                        ],
                      ),
                      //
                    ],
                  )
                : Padding(
                    padding: itemPaddingMedium(),
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
    );
  }
}
