# BAYE POS website

This folder is the shared-data version of BAYE POS. It uses Supabase for email/password sign-in and shared storage, and can be hosted as a static website on Vercel.

## Set up the shared database

1. Create a Supabase project.
2. In its SQL Editor, run all of `schema.sql`.
3. In Supabase project settings, copy the Project URL and the **publishable key**.
4. Put those two values in `config.js`. Do not use a secret or service-role key in this browser app.
5. Deploy this folder as a static site. For Vercel, connect a Git repository containing these files and deploy the `BAYE-website` folder as the site root.
6. In Supabase Authentication URL settings, add the deployed website address to the allowed redirect URLs and set it as the Site URL so email confirmation returns to BAYE.

On first open, create the BAYE account with the stall email and a strong password. If email confirmation is enabled in Supabase, confirm the email before signing in. Use that same account on each device to access the same store records.

## Existing local data

When the account has no cloud record yet, the first device uploads its current BAYE POS data (or the starter setup). Later devices load the cloud record. Keep a downloaded JSON backup before moving data between accounts.

## Important operating note

The website syncs the whole store record when the app saves and listens for changes from other devices. For this first shared version, use one device at a time to record sales or update inventory; simultaneous edits can overwrite one another. The Cash drawer opening count, sales, cash paid out, and closing count are included in the shared record. Keep the original offline BAYE POS file as a separate backup.

## References

- [Supabase JavaScript installation](https://supabase.com/docs/reference/javascript/installing)
- [Supabase Row Level Security](https://supabase.com/docs/guides/database/postgres/row-level-security)
- [Vercel deployments](https://vercel.com/docs/deployments)

## Capital recovery tracking

The Capital return page separates estimated net profit eligible for recovery from cash actually set aside. Record each amount under **Set aside cash from net profit**; entries cannot exceed available net profit through the selected date. Capital collections are not operating expenses, so recording a collection will not reduce profit a second time. These records are included in the backup and shared store data.
