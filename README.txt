CHURCH AUCTION — LIVE TV CAMERA + BUYER HISTORY

This package includes:
- TV page with a persistent live product camera and live auction/bid updates using Supabase Realtime. No 1-second browser polling on TV.
- Bidding page with live auction updates using Supabase Realtime and a persistent camera stream. No 1-second browser polling.
- Admin page keeps Recent Bids + Clear Recent Bid History. The old Buyer History section has been removed.
- Home page now has a separate Buyer History table with Buyer Name, Online/Offline, Item Name, Amount, Gmail and Address.
- Online buyer Gmail/address are saved with each bid. Offline buyer Gmail/address remain blank.

IMPORTANT SUPABASE SETUP
1. Run supabase.sql for a fresh project.
2. For an existing project, run buyer_history_migration.sql.
3. Run google_bidding.sql after the migration (or use buyer_history_migration.sql by itself if you want the complete 5-argument Google-authenticated place_bid function).
4. Keep Supabase Realtime enabled for auction_state and bids.

LIVE CAMERA
- Open camera.html on the phone, sign in, unlock the camera and press START CAMERA.
- Leave that page open. TV and bidding pages connect to it through WebRTC signaling over Supabase Broadcast.
- TV and bidding no longer refresh the page every second.
