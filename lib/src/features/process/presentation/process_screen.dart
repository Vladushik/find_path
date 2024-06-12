import 'package:find_path/src/core/app_routes.dart';
import 'package:find_path/src/core/form_status_enum.dart';
import 'package:find_path/src/core/widgets/buttons/app_button_widget.dart';
import 'package:find_path/src/core/widgets/ui_kit/default_padding_widget.dart';
import 'package:find_path/src/core/widgets/persent_indicator_widget.dart';
import 'package:find_path/src/features/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProcessScreen extends StatelessWidget {
  const ProcessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _View();
  }
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state.postStatus.isSuccess) {
          context.pushNamed(AppPages.resultList.name);
        }
        if (state.postStatus.isFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Something went wrong')),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Process screen')),
        body: DefaultPaddingWidget(
          child: Column(
            children: [
              const Spacer(),
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  return switch (state.startStatus) {
                    FormStatus.initial => const SizedBox(),
                    FormStatus.loading => const Text('Calculating'),
                    FormStatus.success => const Text(
                        'All calculations has finished, you can send your results to server',
                        textAlign: TextAlign.center,
                      ),
                    FormStatus.failure => const SizedBox(),
                  };
                },
              ),
              const SizedBox(height: 20),
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  final submitStatus = state.startStatus.isSuccess;
                  return PercentIndicatorWidget(isFinished: submitStatus);
                },
              ),
              const Spacer(),
              const _ButtonWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class _ButtonWidget extends StatelessWidget {
  const _ButtonWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return AppButtonWidget(
          title: 'Send results to server',
          isValid: state.startStatus.isSuccess,
          isLoading: state.postStatus.isLoading,
          onPressed: () {
            context.read<HomeBloc>().add(const HomePostSubmittedEvent());
          },
        );
      },
    );
  }
}
