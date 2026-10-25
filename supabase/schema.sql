-- Louie To do List task storage.
-- Run this in the Supabase SQL Editor for the target project.

create table if not exists public.tasks (
  id uuid primary key,
  user_id uuid not null references auth.users (id) on delete cascade default auth.uid(),
  title text not null check (char_length(title) between 1 and 160),
  done boolean not null default false,
  created_at timestamptz not null default now(),
  due_at timestamptz,
  reminded boolean not null default false,
  notes text not null default '',
  color text not null default 'yellow' check (color in ('yellow', 'mint', 'rose', 'peach', 'sky', 'lilac')),
  updated_at timestamptz not null default now()
);

alter table public.tasks enable row level security;

drop policy if exists "Users can read their own tasks" on public.tasks;
create policy "Users can read their own tasks"
  on public.tasks for select to authenticated
  using ((select auth.uid()) = user_id);

drop policy if exists "Users can insert their own tasks" on public.tasks;
create policy "Users can insert their own tasks"
  on public.tasks for insert to authenticated
  with check ((select auth.uid()) = user_id);

drop policy if exists "Users can update their own tasks" on public.tasks;
create policy "Users can update their own tasks"
  on public.tasks for update to authenticated
  using ((select auth.uid()) = user_id)
  with check ((select auth.uid()) = user_id);

drop policy if exists "Users can delete their own tasks" on public.tasks;
create policy "Users can delete their own tasks"
  on public.tasks for delete to authenticated
  using ((select auth.uid()) = user_id);

grant select, insert, update, delete on public.tasks to authenticated;
create index if not exists tasks_user_created_idx on public.tasks (user_id, created_at desc);
