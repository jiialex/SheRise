# HerSheild

HerSheild is a Flutter application for confidential and anonymous reporting,
safety planning, and institution case management.

## Run the app

From this directory, install the Flutter dependencies and launch the app:

```powershell
flutter pub get
flutter run -d chrome
```

## Configure Supabase

Authentication and institution registration require a Supabase project. Set the
project URL and public anon key in `lib/config.dart`; never put a service-role
key in the Flutter app. Then run `supabase_schema.sql` in the Supabase SQL
Editor. The schema configures institution applications and row-level access
policies.

Institution applications are created in the pending state. An administrator
must review an application and update its `status` to `approved` or `rejected`
in `public.institution_registrations` before the applicant can access the
institution dashboard. Approved institutions only see reports assigned to
their registered organization name.

The institution dashboard currently reads the app's local sample database.
Configure a secured server-side data source before using it for production
case management; do not treat sample cases as live reports.

## Languages

The language selector supports English, Amharic, and Afaan Oromo. The chosen
language applies to the app interface; user-submitted report content remains
in the language it was written in.
