// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../../_helpers/helpers.dart';
// import '../../_helpers/navigation.dart';
// import '../../_models/item.dart';
// import '../../_providers/_providers.dart';
// import '../../_providers/input.dart';
// import '../../_theme/breakpoints.dart';
// import '../../_theme/spacing.dart';
// import '../../_theme/variables.dart';
// import '../../_widgets/buttons/button.dart';
// import '../../_widgets/others/icons.dart';
// import '../../_widgets/others/others/scroll.dart';
// import '../../_widgets/quill/editor.dart';
// import '../../_widgets/sheets/bottom_sheet.dart';
// import '../files/overview.dart';
// import '../share/shared.dart';
// import '_helpers/ontap.dart';
// import 'types/bookings/_w/booking.dart';
// import 'types/finance/finance.dart';
// import 'types/habits/habit.dart';
// import 'types/links/_w/links.dart';
// import 'types/tasks/task_options.dart';
// import 'w/details.dart';
// import 'w/footer.dart';
// import 'w/title.dart';
// import 'w_actions/input_actions.dart';
 
// class NoteFloater extends StatelessWidget {
//   const NoteFloater({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         //
//         Row(
//           children: [
//             if (!isShare()) CommonInputActions(),
//             Spacer(),
//             AppButton(
//               onPressed: () => popWhatsOnTop(todo: () => whenCompleteNote()),
//               isSquare: true,
//               noStyling: true,
//               child: AppIcon(closeIcon, faded: true),
//             ),
//           ],
//         ),
//         //
//         Flexible(
//           child: NoScrollBars(
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   //
//                   Consumer<InputProvider>(builder: (x, input, c) => ImageOverview(item: Item(data: {}))),
//                   //
//                   sph(),
//                   Padding(
//                     padding: padL('lr'),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         //
//                         NoteTitle(item: item),
//                         Share(),
//                         Finance(),
//                         Links(),
//                         ItemDetails(item: Item.empty()),
//                         TaskOptions(),
//                         Habit(),
//                         Booking(),
//                         if (state.input.item.showEditor()) SuperEditor(),
//                         if (!item.isTask()) spph(),
//                         //
//                       ],
//                     ),
//                   ),
//                   //
//                 ],
//               ),
//             ),
//           ),
//         ),
//         //
//         if (item.showFooter()) NoteFooter(),
//         //
//       ],
//     );
//   }
// }
