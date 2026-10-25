# Supabase setup

1. In the Supabase dashboard for this project, open **SQL Editor** and run [`schema.sql`](./schema.sql).
2. In **Authentication → Sign In / Providers**, enable **Anonymous Sign-Ins**. The app uses an anonymous authenticated session so row-level security can keep each browser's tasks private.
3. Start the app with `npm run dev`. The project URL and publishable key are read from `.env.local` (that file is ignored by Git).

On first successful connection, tasks already stored in this browser's local storage are copied into the new Supabase account if that account has no tasks yet. Anonymous accounts are tied to the current browser storage; clearing browser data or switching devices loses the ability to sign back into that anonymous account. Add a permanent sign-in method before relying on cross-device access.
