{{/*Trigger type: Command*/}}
{{/*Trigger: help-verifs*/}}
{{/*Role Restrictions: Role allowing the advertisement verification*/}}

{{ $embed := cembed
	"title" "Liste des commandes de vérifications" 
	"description" "<a:fleche_droite:717525384262058095> **-verifs [user]** \n Allows you to see the number of verifications of a user.\n \n<a:fleche_droite:717525384262058095> **-lb**\n Allows you to see the leaderboard of server verifications.\n \n<a:fleche_droite:717525384262058095> **-disable-dm**\n Allows to deactivate the reminder of punishments in DM.\n \n<a:fleche_droite:717525384262058095> **-active-dm**\n Allows you to activate the reminder of punishments in DM.\n \n<a:fleche_droite:717525384262058095> **-help-verifs**\n Show this message." 
	"color" (randInt 0 16777216)
}}
{{sendMessage nil $embed}}
