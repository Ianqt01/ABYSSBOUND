create table if not exists public.player_progress (
  user_id uuid primary key references auth.users(id) on delete cascade,
  username text unique not null,
  selected_hero text not null default 'rimuru',
  data jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

alter table public.player_progress enable row level security;

drop policy if exists "Players can view their own progress" on public.player_progress;
drop policy if exists "Players can create their own progress" on public.player_progress;
drop policy if exists "Players can update their own progress" on public.player_progress;

create policy "Players can view their own progress"
on public.player_progress
for select
to authenticated
using (auth.uid() = user_id);

create policy "Players can create their own progress"
on public.player_progress
for insert
to authenticated
with check (auth.uid() = user_id);

create policy "Players can update their own progress"
on public.player_progress
for update
to authenticated
using (auth.uid() = user_id)
with check (auth.uid() = user_id);

create index if not exists player_progress_username_idx on public.player_progress(username);
