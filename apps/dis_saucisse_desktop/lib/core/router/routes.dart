import 'package:dis_saucisse_desktop/core/presentation/desktop_section.dart';
import 'package:dis_saucisse_desktop/core/presentation/widgets/desktop_shell.dart';
import 'package:dis_saucisse_desktop/features/history/presentation/bloc/history_cubit.dart';
import 'package:dis_saucisse_desktop/features/history/presentation/history_screen.dart';
import 'package:dis_saucisse_desktop/features/pairing/presentation/bloc/reception_cubit.dart';
import 'package:dis_saucisse_desktop/features/pairing/presentation/reception_screen.dart';
import 'package:dis_saucisse_desktop/features/storage/presentation/bloc/storage_settings_cubit.dart';
import 'package:dis_saucisse_desktop/features/storage/presentation/storage_settings_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

part 'desktop_shell_route.dart';
part '../../features/history/presentation/history_page_route.dart';
part '../../features/pairing/presentation/reception_page_route.dart';
part '../../features/storage/presentation/storage_page_route.dart';
part 'routes.g.dart';
