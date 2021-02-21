{{/*Trigger type: Command*/}}
{{/*Trigger: active-dm*/}}
{{/*Role Restrictions: Role allowing the advertisement verification*/}}

✅ You have correctly activated the reminder of punishment in DM !
{{dbDel .User.ID "DM"}}
