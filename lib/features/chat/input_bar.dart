import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../__styling/breakpoints.dart';
import '../../__styling/helpers.dart';
import '../../__styling/spacing.dart';
import '../../__styling/variables.dart';
import '../../_helpers/_common/navigation.dart';
import '../../_providers/common/input.dart';
import '../../_providers/providers.dart';
import '../../_widgets/abcs/buttons/buttons.dart';
import '../../_widgets/others/icons.dart';
import '../../_widgets/others/text.dart';
import '../_tables/_helpers/checks_table.dart';
import '../files/_helpers/helper.dart';
import '../files/_helpers/upload.dart';
import '../files/file_list.dart';
import '_helpers/send_message.dart';

class MessageInputBar extends StatelessWidget {
  final TextEditingController messageController = TextEditingController();

  MessageInputBar({super.key});

  @override
  Widget build(BuildContext context) {
    messageController.text = state.input.data['n'] ?? '';
    messageController.selection = TextSelection.collapsed(offset: messageController.text.length);

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: webMaxWidth,
        padding: EdgeInsets.symmetric(horizontal: 2, vertical: 1),
        margin: partitionPadding(bottom: isNotPhone(), left: true, right: true),
        decoration: BoxDecoration(
          color: Color.alphaBlend(styler.appColor(isDark() ? 1 : 2), styler.primaryColor()),
          borderRadius: BorderRadius.circular(borderRadiusLarge),
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
                        borderRadius: borderRadiusCrazy,
                        child: AppIcon(Icons.add_rounded),
                      ),
                      //
                      AppButton(
                        onPressed: () {},
                        tooltip: 'AI',
                        height: 45,
                        width: 45,
                        noStyling: true,
                        borderRadius: borderRadiusCrazy,
                        child: AppIcon(Icons.blur_on),
                      ),
                      // Message Input
                      Expanded(
                        child: TextFormField(
                          onFieldSubmitted: (_) async {
                            messageController.clear();
                            sendMessageToFirebase();
                            hideKeyboard();
                          },
                          onChanged: (value) => state.input.update(action: 'add', key: 'n', value: value.trim()),
                          controller: messageController,
                          keyboardType: TextInputType.multiline,
                          textCapitalization: TextCapitalization.sentences,
                          textInputAction: kIsWeb ? TextInputAction.next : null,
                          minLines: 1,
                          maxLines: 8,
                          style: TextStyle(fontSize: normal, fontWeight: FontWeight.w600, color: styler.textColor()),
                          decoration: InputDecoration(
                            hintText: 'Message...',
                            hintStyle: TextStyle(
                                fontSize: normal, fontWeight: FontWeight.w600, color: styler.textColor(faded: true)),
                            filled: false,
                            contentPadding: EdgeInsets.symmetric(horizontal: 10),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      //
                      spw(),
                      //
                      AppButton(
                        onPressed: () async {
                          messageController.clear();
                          sendMessageToFirebase();
                          hideKeyboard();
                        },
                        // noStyling: true,
                        tooltip: 'Send',
                        height: 45,
                        width: 45,
                        borderRadius: borderRadiusCrazy,
                        child: AppIcon(Icons.arrow_forward_rounded),
                      ),
                      //
                    ],
                  ),
                  //
                ],
              )
            : Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppIcon(Icons.lock_rounded, size: 12, faded: true),
                    tpw(),
                    AppText(size: small, text: 'Only admins can send messages', faded: true),
                  ],
                ),
              ),
      ),
    );
  }
}
