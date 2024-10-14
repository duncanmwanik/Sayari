import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import '../../../__styling/variables.dart';
import '../../../_helpers/global.dart';
import '../../../_helpers/helpers.dart';
import '../../../_providers/_providers.dart';
import '../../files/_helpers/upload.dart';
import '../../files/image.dart';

class QuillEmbedImage extends CustomBlockEmbed {
  QuillEmbedImage(String data) : super(noteType, data);
  static String noteType = 'image';
}

class QuillEmbedImageBuilder extends EmbedBuilder {
  QuillEmbedImageBuilder({required this.addQuillEmbedImageBlock});

  Future<void> Function() addQuillEmbedImageBlock;

  @override
  String get key => 'image';

  @override
  Widget build(BuildContext context, QuillController controller, Embed node, bool readOnly, bool inline, TextStyle textStyle) {
    bool isInput = state.global.isBottomSheetOpen;
    String fileId = splitList(node.value.data)[0];
    String fileName = splitList(node.value.data)[1];

    return ImageFile(
      key: Key(fileId),
      fileId,
      fileName,
      height: isInput || isShare() ? null : 100,
      images: {fileId: fileName},
      showOptions: false,
      hoverColor: transparent,
      radius: borderRadiusTiny,
    );
  }
}

Future<void> addQuillEmbedImageBlock() async {
  await getFilesToUpload(
    imagesOnly: true,
    allowMultiple: false,
    embed: true,
    onDone: (stash) {
      String fileId = stash.fileId();
      final block = BlockEmbed.custom(QuillEmbedImage(joinList([fileId, stash.fileName()])));
      final index = state.quill.controller.selection.baseOffset;
      final length = state.quill.controller.selection.extentOffset - index;
      state.quill.controller.replaceText(index, length, block, null);
    },
  );
}
