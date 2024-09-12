import 'package:flutter/material.dart';

import '../../../../_helpers/_common/misc.dart';
import '../../../../_services/firebase/_helpers/helpers.dart';
import '../../../../_services/hive/local_storage_service.dart';
import '../../../../_widgets/others/loader.dart';
import '../../../../_widgets/others/others/list_tile.dart';
import '../../../../_widgets/others/text.dart';

class SpaceOwnerTile extends StatelessWidget {
  const SpaceOwnerTile({super.key, required this.ownerId});

  final String ownerId;

  @override
  Widget build(BuildContext context) {
    return AppListTile(
      onTap: () async => await copyToClipboard(ownerId),
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
