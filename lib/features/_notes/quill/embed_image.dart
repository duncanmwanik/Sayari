import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import '../../../__styling/variables.dart';
import '../../../_helpers/_common/global.dart';
import '../../../_helpers/_common/helpers.dart';
import '../../../_providers/_providers.dart';
import '../../files/_helpers/upload.dart';
import '../../files/image.dart';

class ImageBlockEmbed extends CustomBlockEmbed {
  ImageBlockEmbed(String data) : super(noteType, data);
  static String noteType = 'image';
}

class ImageEmbedBuilder extends EmbedBuilder {
  ImageEmbedBuilder({required this.addImageBlock});

  Future<void> Function() addImageBlock;

  @override
  String get key => 'image';

  @override
  Widget build(BuildContext context, QuillController controller, Embed node, bool readOnly, bool inline, TextStyle textStyle) {
    bool isInput = state.global.isBottomSheetOpen;
    String fileId = getSplitList(ImageBlockEmbed(node.value.data).data ?? '')[0];
    String fileName = getSplitList(ImageBlockEmbed(node.value.data).data ?? '')[1];

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

Future<void> addImageBlock() async {
  await getFilesToUpload(
    imagesOnly: true,
    multiple: false,
    embed: true,
    onDone: (stash) {
      String fileId = stash.fileId();
      final block = BlockEmbed.custom(ImageBlockEmbed(getJoinedList([fileId, stash.fileName()])));
      final index = state.quill.controller.selection.baseOffset;
      final length = state.quill.controller.selection.extentOffset - index;
      state.quill.controller.replaceText(index, length, block, null);
    },
  );
}
