{{/*Trigger type: Command*/}}
{{/*Trigger: verifs*/}}
{{/*Role Restrictions: Role allowing the advertisement verification*/}}

{{ $user := .User }}
{{ $args := parseArgs 0 "**Erreur, la commande est:** `-verifs [user]`" (carg "userid" "user") }}
{{ if $args.IsSet 0 }}
	{{ $user = userArg ($args.Get 0) }}
{{ end }}

{{$key := joinStr "" "verif_tracker_"  $user.ID}}

{{$verif := dbGet 118 $key}}
{{if $verif}}
**{{$user}}** verified **{{$verif.Value}}** ads.
{{else}}
**{{$user}}** hasn't verified any ad yet.
{{end}}
