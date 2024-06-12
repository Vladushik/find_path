import 'package:find_path/src/core/app_routes.dart';
import 'package:find_path/src/core/form_status_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:find_path/src/core/widgets/buttons/app_button_widget.dart';
import 'package:find_path/src/core/widgets/text_fields/text_field_widget.dart';
import 'package:find_path/src/core/widgets/ui_kit/default_padding_widget.dart';
import 'package:find_path/src/features/home/bloc/home_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
        if (state.startStatus.isFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Something went wrong')),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Home Screen')),
        body: const DefaultPaddingWidget(
          child: Column(
            children: [
              Text('Set valid API base URL in order to continue'),
              _TextFieldUrlWidget(),
              Spacer(),
              _ButtonWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class _TextFieldUrlWidget extends StatelessWidget {
  const _TextFieldUrlWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return TextFieldWidget(
          label: 'Url',
          onChanged: (String value) {
            context.read<HomeBloc>().add(HomeUrlChangedEvent(value));
          },
        );
      },
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
          title: 'Start counting process',
          isValid: state.isValid,
          onPressed: () {
            context.pushNamed(AppPages.process.name);
            context.read<HomeBloc>().add(const HomeStartSubmittedEvent());
          },
        );
      },
    );
  }
}
