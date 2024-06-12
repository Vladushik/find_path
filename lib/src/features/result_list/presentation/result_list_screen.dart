import 'package:find_path/src/core/app_routes.dart';
import 'package:find_path/src/core/utils/format_string.dart';
import 'package:find_path/src/core/widgets/ui_kit/default_padding_widget.dart';
import 'package:find_path/src/core/widgets/ui_kit/divider_widget.dart';
import 'package:find_path/src/features/home/bloc/home_bloc.dart';
import 'package:find_path/src/features/home/data/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ResultListScreen extends StatelessWidget {
  const ResultListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _View();
  }
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Result list screen')),
      body: DefaultPaddingWidget(
        child: CustomScrollView(
          slivers: [
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                return SliverList.separated(
                  separatorBuilder: (_, __) => const SizedBox(height: 0),
                  itemCount: state.shortWayPoints.length,
                  itemBuilder: (BuildContext context, int index) {
                    final text =
                        FormatString.formatPath(state.shortWayPoints[index]);
                    final List<Point> param = state.shortWayPoints[index];
                    return _ItemWidget(
                      text: text,
                      onTap: () {
                        context.pushNamed(AppPages.preview.name, extra: param);
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ItemWidget extends StatelessWidget {
  const _ItemWidget({
    required this.onTap,
    required this.text,
  });

  final void Function() onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(text),
          const DividerWidget(vp: 16),
        ],
      ),
    );
  }
}
