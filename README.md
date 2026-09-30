# ABYSSBOUND — Vercel + Supabase

This version fixes account creation when Supabase email confirmation is enabled.

## Included
- `index.html` — ABYSSBOUND game with Supabase Auth + online player saving
- `config.js` — Supabase URL and public publishable/anon key
- `supabase.sql` — `player_progress` table and RLS policies

## Important registration fix
If Supabase requires email confirmation, `auth.signUp()` does not return an active session. The previous version tried to insert `player_progress` immediately, which caused:

`new row violates row-level security policy for table "player_progress"`

This version only creates the profile immediately when a session exists. When email confirmation is required, it stores the username and starting hero in Auth metadata, asks the player to verify the email, and creates the game profile automatically on the first successful login.

## Setup
1. Create a Supabase project.
2. Open SQL Editor and run `supabase.sql`.
3. Open `config.js` and enter the Supabase Project URL and public Publishable/anon key.
4. Deploy the folder to Vercel.
5. In Supabase Authentication URL Configuration, set your Vercel URL as the Site URL.
6. Test Create Account.
7. If email confirmation is enabled, verify the email, then log in. The player profile is created automatically.

Never put a Supabase `service_role` or `sb_secret_...` key in `config.js` or frontend code.


### Mobile responsiveness
This build includes responsive fixes for portrait registration/login screens and landscape phone/tablet home screens.
