CHURCH AUCTION - SOLD OUT / BUYER HISTORY / UNDER-18 FIX

Changes in this build:
1. Online Bidding page has the SOLD OUT overlay with the SOLD OUT stamp, winner name, age, ONLINE/OFFLINE type, email and address, plus the 5-second clapping audio.
2. Admin Offline Bid form now asks only for bidder name and bid amount. Age, Gmail and Address were removed from the Admin form.
3. Admin Buyer History now shows: Buyer Name, Bid Type (ONLINE/OFFLINE), Item Name, Amount and Time.
4. CLEAR BUYER HISTORY uses the authenticated Supabase RPC and refreshes the history after deletion.
5. Under-18 attempts are logged through the public security-definer RPC. The bidding page reports if logging fails instead of silently ignoring the error.
6. Under-18 attempt table is added to Supabase Realtime so the Admin page can update live.
7. Bids store the item name so Buyer History can show the actual item name.

IMPORTANT:
Run the updated supabase.sql in the Supabase SQL Editor. This is required for the buyer-history clear function, item-name storage and Under-18 attempt logging/realtime changes.
