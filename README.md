# HerSheild
https://hershield-app.vercel.app/#/welcome here is the link of browser

HerSheild is a Flutter application for confidential and anonymous reporting,
safety planning, and institution case management.

## Run the app

From this directory, install the Flutter dependencies and launch the app:

```powershell
flutter pub get
flutter run -d chrome
```

## Deploy to Vercel

Build the static web app with `flutter build web --release`, then import the
generated `build/web` folder as a new Vercel project using the Vercel dashboard.
The web folder includes a rewrite rule for Flutter's client-side routes.

## Configure Supabase

Authentication and institution registration require a Supabase project. Set the
project URL and public anon key in `lib/config.dart`; never put a service-role
key in the Flutter app. Then run `supabase_schema.sql` in the Supabase SQL
Editor. The schema configures institution applications and row-level access
policies.

Institution signups can enter the dashboard after any required email
confirmation. Registration stays pending until an administrator reviews it;
row-level security only permits approved institutions to access matching
reports. The dashboard currently displays local sample data, not live reports.
Do not connect it to real case data until server-side access is restricted to
verified organization memberships rather than self-entered organization names.

The institution dashboard currently reads the app's local sample database.
Configure a secured server-side data source before using it for production
case management; do not treat sample cases as live reports.

## Languages

The language selector supports English, Amharic, and Afaan Oromo. The chosen
language applies to the app interface; user-submitted report content remains
in the language it was written in.
