CHURCH AUCTION — GOOGLE/GMAIL ONLINE BIDDING

1. Run supabase.sql first if you have not already.
2. Run google_bidding.sql in Supabase SQL Editor.
3. In Supabase Dashboard → Authentication → Providers → Google, enable Google.
4. Create a Google OAuth Web Client ID/Secret in Google Cloud Console and paste them into the Supabase Google provider settings.
5. In Supabase Dashboard → Authentication → URL Configuration, set the Site URL to your public Netlify website URL and add the public bid.html URL as an allowed redirect URL if needed.
6. Deploy the updated bid.html, admin.html, tv.html and style.css to Netlify.
7. Give bidders the public URL ending in /bid.html.
8. Each bidder clicks CONTINUE WITH GOOGLE, chooses their Gmail/Google account, and then places a bid.
9. The bidder's Google display name/email are used for the online bid. They do not type a bidder name manually.

IMPORTANT:
- Do not use the service_role/secret key in any HTML file.
- Use only the Supabase Publishable/anon key in the browser.
- Google OAuth will work from the public HTTPS Netlify site; opening the page as a local file (file://) is not the intended production setup.
