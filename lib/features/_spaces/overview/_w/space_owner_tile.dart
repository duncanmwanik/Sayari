import 'package:flutter/material.dart';

import '../../../../_helpers/clipboard.dart';
import '../../../../_services/firebase/_helpers/helpers.dart';
import '../../../../_services/hive/local_storage_service.dart';
import '../../../../_widgets/others/loader.dart';
import '../../../../_widgets/others/others/list_tile.dart';
import '../../../../_widgets/others/text.dart';
import '../../_helpers/common.dart';

class SpaceOwnerTile extends StatelessWidget {
  const SpaceOwnerTile({super.key});

  @override
  Widget build(BuildContext context) {
    String ownerId = liveSpaceOwner();

    return AppListTile(
      onTap: () async => await copyText(ownerId, description: 'Copied email.'),
      leading: AppText(
        text: 'Owner',
      ),
      trailing: userEmailsBox.get(ownerId, defaultValue: null) != null
          ? AppText(
              text: userEmailsBox.get(ownerId, defaultValue: '---'),
            )
          : FutureBuilder(
              future: getUserEmailFromCloud(ownerId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return AppText(
                      text: '-',
                    );
                  } else if (snapshot.hasData) {
                    String ownerEmail = snapshot.data as String;
                    userEmailsBox.put(ownerId, ownerEmail);
                    return AppText(
                      text: ownerEmail,
                    );
                  }
                }
                return AppLoader();
              }),
    );
  }
}
