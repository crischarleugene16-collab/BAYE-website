-- BAYE shared store data. Each signed-in account can access only its own row.
create table if not exists public.baye_store_data (
  owner_id uuid primary key references auth.users(id) on delete cascade,
  payload jsonb not null,
  updated_at timestamptz not null default now()
);

alter table public.baye_store_data enable row level security;

drop policy if exists "Read own BAYE store" on public.baye_store_data;
create policy "Read own BAYE store"
  on public.baye_store_data for select to authenticated
  using ((select auth.uid()) = owner_id);

drop policy if exists "Create own BAYE store" on public.baye_store_data;
create policy "Create own BAYE store"
  on public.baye_store_data for insert to authenticated
  with check ((select auth.uid()) = owner_id);

drop policy if exists "Update own BAYE store" on public.baye_store_data;
create policy "Update own BAYE store"
  on public.baye_store_data for update to authenticated
  using ((select auth.uid()) = owner_id)
  with check ((select auth.uid()) = owner_id);

grant select, insert, update on public.baye_store_data to authenticated;

-- Realtime lets other signed-in devices refresh when the store row changes.
do $$
begin
  alter publication supabase_realtime add table public.baye_store_data;
exception when duplicate_object then
  null;
end $$;
