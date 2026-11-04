import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../data/institution_options.dart';
import '../data/repository.dart';
import '../secure_fields.dart';
import '../security/password_policy.dart';
import '../widgets.dart';
import 'institution_board_screen.dart';
import 'institution_case_detail_screen.dart';

class InstitutionPortalScreen extends StatelessWidget {
  const InstitutionPortalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageBody(
      showBack: true,
      fallback: '/welcome',
      title: 'Institution portal',
      subtitle: 'Register your organization or sign in to access its separate case dashboard.',
      children: [
        const InfoBox(
          icon: Icons.apartment,
          title: 'Institution access',
          text: 'Register your institution to access its dashboard after sign-up.',
        ),
        PrimaryButton(
          label: 'Register an institution',
          icon: Icons.apartment,
          onPressed: () => context.go('/institution/register'),
        ),
        SecondaryButton(
          label: 'Institution sign in',
          icon: Icons.login,
          onPressed: () => context.go('/institution/signin'),
        ),
      ],
    );
  }
}

class InstitutionRegistrationScreen extends StatefulWidget {
  const InstitutionRegistrationScreen({super.key});

  @override
  State<InstitutionRegistrationScreen> createState() =>
      _InstitutionRegistrationScreenState();
}

class _InstitutionRegistrationScreenState
    extends State<InstitutionRegistrationScreen> {
  final _institution = TextEditingController();
  final _applicant = TextEditingController();
  final _title = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _busy = false;
  bool _submitted = false;

  @override
  void dispose() {
    _institution.dispose();
    _applicant.dispose();
    _title.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final institution = _institution.text.trim();
    final applicant = _applicant.text.trim();
    final title = _title.text.trim();
    final email = _email.text.trim();
    if (institution.length < 2 || applicant.length < 2 || title.length < 2) {
      snack(context, 'Enter your institution, name, and role.');
      return;
    }
    final problem = PasswordPolicy.firstProblem(
      PasswordPolicy.check(
        _password.text,
        personal: [email, applicant, institution],
      ),
    );
    if (problem != null) {
      snack(context, problem);
      return;
    }

    setState(() => _busy = true);
    try {
      final result = await Repo.registerInstitution(
        institutionName: institution,
        applicantName: applicant,
        applicantTitle: title,
        email: email,
        password: _password.text,
      );
      if (!mounted) return;
      switch (result) {
        case SignUpResult.signedIn:
          context.go('/institution/dashboard');
        case SignUpResult.alreadyRegistered:
          setState(() => _busy = false);
          snack(context, 'This email already has an account. Please sign in.');
          context.go('/institution/signin');
        case SignUpResult.needsConfirmation:
          setState(() {
            _busy = false;
            _submitted = true;
          });
      }
    } on AuthException catch (e) {
      if (mounted) {
        setState(() => _busy = false);
        snack(context, Repo.authError(e));
      }
    } catch (e) {
      if (mounted) {
        setState(() => _busy = false);
        snack(context, e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageBody(
      showBack: true,
      fallback: '/institution',
      title: 'Register your institution',
      subtitle: 'Provide your organization details to access its dashboard after sign-up.',
      children: [
        if (!Repo.live)
          const InfoBox(
            title: 'Supabase setup required',
            text: 'Configure the Supabase project and run supabase_schema.sql before registering an institution.',
            tone: Tone.warn,
          ),
        if (_submitted)
          const InfoBox(
            title: 'Registration submitted',
            text: 'Confirm your email if requested, then sign in to access your dashboard. No administrator approval is required.',
            tone: Tone.ok,
          ),
        SuggestField(
          label: 'Institution name',
          controller: _institution,
          options: InstitutionOptions.institutions,
          hint: 'Start typing to see suggestions',
        ),
        LabeledField(label: 'Your full name', controller: _applicant),
        SuggestField(
          label: 'Your role or title',
          controller: _title,
          options: InstitutionOptions.roles,
          hint: 'Start typing to see suggestions',
        ),
        LabeledField(
          label: 'Institutional email address',
          controller: _email,
          keyboard: TextInputType.emailAddress,
        ),
        ListenableBuilder(
          listenable: Listenable.merge([_email, _applicant, _institution]),
          builder: (_, _) => PasswordField(
            controller: _password,
            personal: [_email.text, _applicant.text, _institution.text],
          ),
        ),
        PrimaryButton(
          label: _busy ? 'Submitting…' : 'Submit registration',
          onPressed: _busy || !Repo.live ? null : _submit,
        ),
        Center(
          child: TextButton(
            onPressed: () => context.go('/institution/signin'),
            child: const Tx('Already registered? Institution sign in'),
          ),
        ),
      ],
    );
  }
}

class InstitutionSignInScreen extends StatefulWidget {
  const InstitutionSignInScreen({super.key});

  @override
  State<InstitutionSignInScreen> createState() =>
      _InstitutionSignInScreenState();
}

class _InstitutionSignInScreenState extends State<InstitutionSignInScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _busy = false;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!Repo.live) {
      snack(context, 'Institution sign in requires Supabase configuration.');
      return;
    }
    setState(() => _busy = true);
    try {
      await Repo.signIn(_email.text, _password.text);
      final registration = await Repo.institutionRegistration();
      if (!mounted) return;
      if (registration == null) {
        await Repo.signOut();
        if (!mounted) return;
        setState(() => _busy = false);
        snack(
          context,
          'No institution registration is linked to this account.',
        );
        return;
      }
      context.go('/institution/dashboard');
    } on AuthException catch (e) {
      if (mounted) {
        setState(() => _busy = false);
        snack(context, Repo.authError(e));
      }
    } catch (e) {
      if (mounted) {
        setState(() => _busy = false);
        snack(context, e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageBody(
      showBack: true,
      fallback: '/institution',
      title: 'Institution sign in',
      subtitle: 'Use the account registered for your organization.',
      children: [
        if (!Repo.live)
          const InfoBox(
            title: 'Supabase setup required',
            text: 'Configure Supabase before institution accounts can sign in.',
            tone: Tone.warn,
          ),
        LabeledField(
          label: 'Email address',
          controller: _email,
          keyboard: TextInputType.emailAddress,
        ),
        PasswordField(controller: _password, showRules: false),
        PrimaryButton(
          label: _busy ? 'Signing in…' : 'Institution sign in',
          onPressed: _busy ? null : _submit,
        ),
        Center(
          child: TextButton(
            onPressed: () => context.go('/institution/register'),
            child: const Tx('Register your institution'),
          ),
        ),
      ],
    );
  }
}

class InstitutionDashboardGate extends StatefulWidget {
  const InstitutionDashboardGate({super.key, this.caseCode});

  final String? caseCode;

  @override
  State<InstitutionDashboardGate> createState() =>
      _InstitutionDashboardGateState();
}

class _InstitutionDashboardGateState extends State<InstitutionDashboardGate> {
  late Future<InstitutionRegistration?> _registration;

  @override
  void initState() {
    super.initState();
    _loadRegistration();
  }

  void _loadRegistration() {
    _registration = Repo.live && Repo.signedIn
        ? Repo.institutionRegistration()
        : Future<InstitutionRegistration?>.value();
  }

  void _refresh() {
    setState(_loadRegistration);
  }

  Future<void> _signOut() async {
    await Repo.signOut();
    if (mounted) context.go('/institution');
  }

  @override
  Widget build(BuildContext context) {
    if (!Repo.live) {
      return const _InstitutionGateMessage(
        title: 'Supabase setup required',
        message: 'Institution access is disabled until Supabase is configured and the registration schema is installed.',
        showPortalActions: true,
      );
    }
    if (!Repo.signedIn) {
      return const _InstitutionGateMessage(
        title: 'Institution sign in required',
        message: 'Sign in with an institution account to continue.',
        showPortalActions: true,
      );
    }

    return FutureBuilder<InstitutionRegistration?>(
      future: _registration,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return _InstitutionGateMessage(
            title: 'Could not verify institution access',
            message: snapshot.error.toString(),
            onRetry: _refresh,
            onSignOut: _signOut,
          );
        }
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final registration = snapshot.data;
        if (registration == null) {
          return _InstitutionGateMessage(
            title: 'Institution registration not found',
            message: 'This account has no institution registration and cannot open the institution dashboard.',
            onSignOut: _signOut,
            showPortalActions: true,
          );
        }
        if (registration.status == 'rejected') {
          return _InstitutionGateMessage(
            title: 'Institution registration was not approved',
            message: 'Contact the review team if you believe this decision was made in error.',
            onRetry: _refresh,
            onSignOut: _signOut,
          );
        }

        if (widget.caseCode != null) {
          return InstitutionCaseDetailScreen(code: widget.caseCode!);
        }
        return InstitutionBoardScreen(
          institutionName: registration.institutionName,
          staffName: Repo.displayName ?? Repo.email ?? 'Institution staff',
        );
      },
    );
  }
}

class _InstitutionGateMessage extends StatelessWidget {
  const _InstitutionGateMessage({
    required this.title,
    required this.message,
    this.onRetry,
    this.onSignOut,
    this.showPortalActions = false,
  });

  final String title;
  final String message;
  final VoidCallback? onRetry;
  final VoidCallback? onSignOut;
  final bool showPortalActions;

  @override
  Widget build(BuildContext context) {
    return PageBody(
      title: title,
      children: [
        InfoBox(title: title, text: message, tone: Tone.warn),
        if (onRetry != null)
          SecondaryButton(label: 'Check approval status', onPressed: onRetry),
        if (onSignOut != null)
          SecondaryButton(label: 'Sign out', onPressed: onSignOut),
        if (showPortalActions) ...[
          PrimaryButton(
            label: 'Institution sign in',
            onPressed: () => context.go('/institution/signin'),
          ),
          SecondaryButton(
            label: 'Register your institution',
            onPressed: () => context.go('/institution/register'),
          ),
        ],
        TextButton(
          onPressed: () => context.go('/home'),
          child: const Tx('Back to user dashboard'),
        ),
      ],
    );
  }
}
