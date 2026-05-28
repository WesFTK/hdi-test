import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:hdi_test/pages/auth/bloc/auth_bloc.dart';
import 'package:hdi_test/pages/auth/ui/widgets/auth_app_icon.dart';
import 'package:hdi_test/pages/auth/ui/widgets/auth_brand_panel.dart';
import 'package:hdi_test/utils/enums/status_state.dart';
import 'package:hdi_test/utils/extensions/build_context_extension.dart';
import 'package:hdi_test/utils/ui/app_flushbar.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _obscure = true;
  bool _cooldown = false;

  void _submit() {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final values = _formKey.currentState!.value;
      context.read<AuthBloc>().add(
        AuthEvent.loginSubmitted(
          identifier: values['identifier'] as String,
          password: values['password'] as String,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == StatusState.error && state.errorMessage != null) {
          setState(() => _cooldown = true);
          AppFlushbar.showError(context, state.errorMessage!).then((_) async {
            await Future.delayed(const Duration(milliseconds: 1000));
            if (mounted) setState(() => _cooldown = false);
          });
        }
      },
      child: Scaffold(
        body: ScreenTypeLayout.builder(
          mobile: (_) => _buildMobileBody(),
          tablet: (_) => _buildTabletBody(),
        ),
      ),
    );
  }

  Widget _buildMobileBody() {
    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(40.h),
              const AuthAppIcon(),
              Gap(24.h),
              ..._buildFormContent(),
              Gap(40.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabletBody() {
    return Row(
      children: [
        const Expanded(child: AuthBrandPanel()),
        Expanded(
          child: SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 420.w),
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 40.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Gap(48.h),
                      ..._buildFormContent(),
                      Gap(48.h),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildFormContent() {
    return [
      Text(
        'Welcome back',
        style: context.textTheme.headlineMedium,
      ),
      Gap(8.h),
      Text(
        'Sign in to your member account',
        style: context.textTheme.bodyMedium?.copyWith(color: context.colorScheme.onSurfaceVariant),
      ),
      Gap(40.h),
      FormBuilder(
        key: _formKey,
        child: Column(
          children: [
            FormBuilderTextField(
              name: 'identifier',
              decoration: const InputDecoration(
                labelText: 'Member ID or Email',
                prefixIcon: Icon(Icons.person_outline_rounded),
              ),
              textInputAction: TextInputAction.next,
              validator: FormBuilderValidators.compose(
                  [FormBuilderValidators.required(errorText: 'Required')]),
            ),
            Gap(16.h),
            FormBuilderTextField(
              name: 'password',
              obscureText: _obscure,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: const Icon(Icons.lock_outline_rounded),
                suffixIcon: IconButton(
                  icon: Icon(_obscure
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined),
                  onPressed: () => setState(() => _obscure = !_obscure),
                ),
              ),
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _submit(),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(errorText: 'Required'),
                FormBuilderValidators.minLength(6,
                    errorText: 'Password must be at least 6 characters'),
              ]),
            ),
          ],
        ),
      ),
      Gap(32.h),
      BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          final isLoading = _cooldown ||
              state.status == StatusState.loading ||
              (state.status == StatusState.loaded && state.isAuthenticated);
          return ElevatedButton(
            onPressed: isLoading ? null : _submit,
            child: const Text('Sign In'),
          );
        },
      ),
      Gap(24.h),
      Center(
        child: Text(
          'Demo: MB001 / password123',
          style: context.textTheme.bodySmall?.copyWith(color: context.colorScheme.onSurfaceVariant),
        ),
      ),
    ];
  }
}
