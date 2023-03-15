import 'package:flutter_modular/flutter_modular.dart';
import 'package:listinha/src/home/edit_task_board_page.dart';

import 'home_page.dart';

class HomeModule extends Module {
  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, args) => const HomePage()),
        ChildRoute('/edit', child: (_, args) => const EditTaskBoardPage()),
      ];
}
