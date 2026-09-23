CHURCH AUCTION - COMPLETE SETUP

This version includes:
1. Admin auction controls with Supabase Auth login.
2. START NEW ITEM / WAITING / SOLD / NEXT ITEM.
3. Offline bids entered by the admin.
4. Online bidders sign in with Google/Gmail through Supabase Auth.
5. Live auction state through Supabase Realtime.
6. PHONE PRODUCT CAMERA: open camera.html on a phone, log in as admin, and start the phone camera. The live product video is sent to tv.html and bid.html using WebRTC + Supabase Realtime signaling.

FILES
- admin.html = auction control page
- tv.html = TV/projector display
- bid.html = public online bidder page
- camera.html = phone camera page
- supabase.sql = base database setup
- google_bidding.sql = Google-login bidding security patch
- style.css = shared styles

SUPABASE DATABASE
1. Run supabase.sql in Supabase SQL Editor.
2. Then run google_bidding.sql.
3. Do not run supabase.sql AFTER google_bidding.sql, because the base script restores anonymous RPC permission.

GOOGLE LOGIN
1. Supabase Dashboard -> Authentication -> Providers -> Google -> enable Google.
2. Configure Google OAuth credentials in Google Cloud Console.
3. In Supabase Authentication -> URL Configuration, add your deployed Netlify site URL and the exact bid.html URL you use as a redirect URL.
4. Bidders open bid.html and choose CONTINUE WITH GOOGLE.

ADMIN LOGIN
Create the admin user in Supabase Authentication -> Users. The admin.html and camera.html pages use that email/password.

PHONE CAMERA
1. Deploy the complete folder to Netlify (HTTPS is required for phone camera access).
2. On the church phone, open: https://YOUR-NETLIFY-SITE/camera.html
3. Enter the same Supabase URL and Publishable key if requested.
4. Sign in using the admin email/password.
5. Tap START CAMERA and allow camera permission.
6. Prefer the rear/environment camera. Keep the phone pointed at the product.
7. Keep camera.html open while the auction runs.
8. Open the new tv.html on the TV/projector browser and bid.html for remote bidders. They will show the live product video automatically when the phone camera is live.

IMPORTANT CAMERA NOTES
- The phone must have HTTPS access to camera.html.
- WebRTC uses STUN servers for direct connections. Some strict networks/mobile carriers may block peer-to-peer connections; in that case a TURN server may be needed for guaranteed connectivity.
- The phone is the broadcaster. TV and online bidders are viewers.
- The camera room name is built into the files, so no extra room setup is needed.

OLD TV LINK
If your old TV URL is a Netlify deployment of this same project, replace the deployed files with this complete version and keep the same URL. If the old TV URL points to an older deployment, it will not have the new camera feature until the new tv.html is deployed there.

SECURITY
Never put a Supabase service-role key in these HTML files. Use the Publishable/anon key only. Keep the admin email/password private.


UPDATES:
- TV page now uses a landscape/full-screen layout with a slideshow between Auction and Live Product Camera. Interval: 5/10/15/30 seconds. Fullscreen button included.
- Camera page now has a passkey gate before the existing Supabase admin login. Default passkey: 2580. To change it, edit PASSKEY in camera.html.
