// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter_quill/flutter_quill.dart';

// import '../../../../_providers/providers.dart';
// import '../../../../_variables/constants.dart';
// import 'editor.dart';

// class NotesBlockEmbed extends CustomBlockEmbed {
//   NotesBlockEmbed(String value) : super(noteType, value);

//   static String noteType = 'notes';

//   static NotesBlockEmbed fromDocument(Document document) => NotesBlockEmbed(jsonEncode(document.toDelta().toJson()));

//   Document get document => Document.fromJson(jsonDecode(data));
// }

// class NotesEmbedBuilder extends EmbedBuilder {
//   NotesEmbedBuilder({required this.addEditNote});

//   Future<void> Function(BuildContext context, {Document? document}) addEditNote;

//   @override
//   String get key => 'notes';

//   @override
//   Widget build(
//     BuildContext context,
//     QuillController controller,
//     Embed node,
//     bool readOnly,
//     bool inline,
//     TextStyle textStyle,
//   ) {
//     final notes = NotesBlockEmbed(node.value.data).document;

//     return Material(
//       color: Colors.transparent,
//       child: ListTile(
//         title: Text(
//           notes.toPlainText().replaceAll('\n', ' '),
//           maxLines: 3,
//           overflow: TextOverflow.ellipsis,
//         ),
//         leading: Icon(Icons.notes),
//         onTap: () => addEditNote(context, document: notes),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10),
//           side: BorderSide(color: Colors.grey),
//         ),
//       ),
//     );
//   }
// }

// Future<void> _addEditNote(BuildContext context, {Document? document}) async {
//   final isEditing = document != null;
//   final quillEditorController = QuillController(
//     document: document ?? Document(),
//     selection: TextSelection.collapsed(offset: 0),
//   );

//   await showDialog(
//     context: context,
//     builder: (context) => AlertDialog(
//       titlePadding: EdgeInsets.only(left: 16, top: 8),
//       title: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text('${isEditing ? 'Edit' : 'Add'} note'),
//           IconButton(
//             onPressed: () => Navigator.of(context).pop(),
//             icon: Icon(Icons.close),
//           )
//         ],
//       ),
//       content: QuillEditor.basic(
//         controller: quillEditorController,
//       ),
//     ),
//   );

//   if (quillEditorController.document.isEmpty()) return;

//   final block = BlockEmbed.custom(
//     NotesBlockEmbed.fromDocument(quillEditorController.document),
//   );
//   final controller = _controller!;
//   final index = controller.selection.baseOffset;
//   final length = controller.selection.extentOffset - index;

//   if (isEditing) {
//     final offset = getEmbedNode(controller, controller.selection.start).offset;
//     controller.replaceText(offset, 1, block, TextSelection.collapsed(offset: offset));
//   } else {
//     controller.replaceText(index, length, block, null);
//   }
// }
