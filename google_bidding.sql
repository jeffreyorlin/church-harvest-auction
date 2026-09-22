-- GOOGLE LOGIN + BUYER HISTORY PATCH
-- Run this AFTER supabase.sql in Supabase SQL Editor.

alter table public.bids add column if not exists auth_user_id uuid;
alter table public.bids add column if not exists bidder_email text;
alter table public.bids add column if not exists bidder_address text;
alter table public.bids add column if not exists item_name text;

-- Replace the old four-argument RPC with the new five-argument version.
drop function if exists public.place_bid(integer,text,numeric,text);
drop function if exists public.place_bid(integer,text,numeric,text,text);

create or replace function public.place_bid(
  p_item_number integer,
  p_bidder_name text,
  p_amount numeric,
  p_source text default 'online',
  p_bidder_address text default ''
)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
  a auction_state%rowtype;
  v_user_id uuid := auth.uid();
  v_email text := auth.jwt() ->> 'email';
  v_name text := trim(coalesce(auth.jwt() -> 'user_metadata' ->> 'full_name', auth.jwt() -> 'user_metadata' ->> 'name', p_bidder_name, v_email, 'Google user'));
begin
  if v_user_id is null then
    return jsonb_build_object('ok', false, 'message', 'Please sign in with Google before bidding.');
  end if;
  if p_source not in ('online','offline') then
    return jsonb_build_object('ok', false, 'message', 'Invalid bid source.');
  end if;
  select * into a from public.auction_state where id = 1 for update;
  if a.status <> 'open' then
    return jsonb_build_object('ok', false, 'message', 'Bidding is closed.');
  end if;
  if p_item_number <> a.item_number then
    return jsonb_build_object('ok', false, 'message', 'This item is no longer active.');
  end if;
  if length(v_name) < 2 then
    return jsonb_build_object('ok', false, 'message', 'Could not determine your name.');
  end if;
  if p_amount <= a.current_bid then
    return jsonb_build_object('ok', false, 'message', 'Your bid must be higher than ₹' || to_char(a.current_bid, 'FM9999999990.00'));
  end if;
  update public.auction_state
  set current_bid = p_amount, highest_bidder = v_name, highest_bid_source = p_source, updated_at = now()
  where id = 1;
  insert into public.bids(item_number, item_name, bidder_name, amount, source, auth_user_id, bidder_email, bidder_address)
  values (p_item_number, a.item_name, v_name, p_amount, p_source, v_user_id, v_email, nullif(trim(coalesce(p_bidder_address,'')), ''));
  return jsonb_build_object('ok', true, 'message', 'Bid accepted.');
end;
$$;

revoke execute on function public.place_bid(integer,text,numeric,text,text) from public;
revoke execute on function public.place_bid(integer,text,numeric,text,text) from anon;
grant execute on function public.place_bid(integer,text,numeric,text,text) to authenticated;

-- Keep the clear-history RPC in the database for maintenance, but it is no longer shown on the Admin page.
create or replace function public.clear_bidding_history()
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
begin
  if auth.uid() is null then
    return jsonb_build_object('ok', false, 'message', 'Admin login required.');
  end if;
  delete from public.bids;
  return jsonb_build_object('ok', true, 'message', 'Bidding history cleared.');
end;
$$;
revoke execute on function public.clear_bidding_history() from public;
grant execute on function public.clear_bidding_history() to authenticated;

-- Password-protected Buyer History clear button for the Home page.
create or replace function public.clear_buyer_history(p_password text)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
begin
  if p_password is distinct from '1206' then
    return jsonb_build_object('ok', false, 'message', 'Incorrect password.');
  end if;

  delete from public.bids;

  return jsonb_build_object('ok', true, 'message', 'Buyer History cleared.');
end;
$$;

revoke execute on function public.clear_buyer_history(text) from public;
revoke execute on function public.clear_buyer_history(text) from anon;
revoke execute on function public.clear_buyer_history(text) from authenticated;
grant execute on function public.clear_buyer_history(text) to anon, authenticated;
