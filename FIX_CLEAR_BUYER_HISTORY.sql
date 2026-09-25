-- CHURCH AUCTION: FIX BUYER HISTORY CLEAR
-- Run this ONCE in Supabase SQL Editor if the installed function still says:
-- "DELETE requires a WHERE clause"

create or replace function public.clear_bidding_history()
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare v_count integer;
begin
  if auth.uid() is null then
    return jsonb_build_object('ok', false, 'message', 'Admin login required.');
  end if;

  delete from public.bids where id is not null;
  get diagnostics v_count = row_count;

  return jsonb_build_object(
    'ok', true,
    'deleted', v_count,
    'message', 'Buyer history cleared.'
  );
end;
$$;

revoke execute on function public.clear_bidding_history() from public;
grant execute on function public.clear_bidding_history() to authenticated;

-- Also fix the Under-18 "clear all" function for the same DELETE safety rule.
create or replace function public.clear_underage_bidding_attempts()
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
begin
  if auth.uid() is null then
    return jsonb_build_object('ok', false, 'message', 'Admin login required.');
  end if;

  delete from public.underage_bidding_attempts where id is not null;
  return jsonb_build_object('ok', true, 'message', 'All under-18 attempts deleted.');
end;
$$;

revoke execute on function public.clear_underage_bidding_attempts() from public;
grant execute on function public.clear_underage_bidding_attempts() to authenticated;
