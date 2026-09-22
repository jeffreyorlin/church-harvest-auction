CHURCH AUCTION — LIVE TV CAMERA + SEPARATE PROTECTED BUYER HISTORY

This package includes:
- TV page with persistent live product camera and live auction/bid updates using Supabase Realtime. No 1-second browser polling on TV.
- Bidding page with live auction updates using Supabase Realtime and a persistent camera stream. No 1-second browser polling.
- Admin page keeps Recent Bids + Clear Recent Bid History. The old Buyer History section has been removed from Admin.
- Home page contains only a button that opens buyer_history.html. Buyer History records are no longer displayed openly on the Home page.
- buyer_history.html is a separate password-protected page.
- Buyer History password: 12062009.
- Buyer History includes Buyer Name, Online/Offline, Item Name, Amount, Gmail and Address.
- The CLEAR BUYER HISTORY button is also protected by password 12062009 and calls a server-side password-checked RPC.

IMPORTANT SUPABASE SETUP
1. For a fresh project, run supabase.sql.
2. For an existing project, run buyer_history_migration.sql.
3. Run google_bidding.sql after the migration.
4. Keep Supabase Realtime enabled for auction_state and bids.

After running the migration, open buyer_history.html, enter 12062009, and verify the records load.
