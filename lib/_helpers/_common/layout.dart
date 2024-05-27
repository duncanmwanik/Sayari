import '../../__styling/breakpoints.dart';
import '../../_providers/providers.dart';
import '../../_services/hive/local_storage_service.dart';
import '../../_variables/features.dart';
import '../../features/_tables/_helpers/common.dart';

void resetListLayout() {
  if (!showWebBoxOptions()) {
    if (globalBox.get('${liveTable()}_layout_${feature.notes.t}', defaultValue: 'grid') == 'list') {
      state.views.setLayout(feature.notes.t, 'grid');
    }
    if (globalBox.get('${liveTable()}_layout_${feature.lists.t}', defaultValue: 'grid') == 'list') {
      state.views.setLayout(feature.lists.t, 'grid');
    }
    if (globalBox.get('${liveTable()}_layout_${feature.finances.t}', defaultValue: 'grid') == 'list') {
      state.views.setLayout(feature.finances.t, 'grid');
    }
  }
}
