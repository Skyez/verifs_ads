{{/*Trigger type: Reaction*/}}
{{/*Trigger: Added reactions only*/}}
{{/*Channel Restrictions: Your advertising channel*/}}

{{/*Set the id of the role allowing the advertisement verification*/}}
{{ $role := 793098376043823104 }}

{{/*Set the id of the log channel*/}}
{{ $logs := 793100591559606292 }}

{{/* Don't touch this !*/}}
{{$key := joinStr "" "verif_tracker_"  .User.ID}}
{{$DM := dbGet .User.ID "DM"}}
{{$userVerif := dbGet 118 $key}}
{{if $userVerif}}
{{else}}
{{dbSet 118 $key 0}}
{{end}}

{{$avatar := .User.AvatarURL "256"}}

{{$accept := cembed 
	"title" (joinStr "" "**" .User.Username " a validé la publicité de " .Message.Author "**")
	"description" (joinStr "" .Message.Content "\n \n **Salon:** <#" .Channel.ID "> \n **Auteur:** " .Message.Author "")
	"color" 454749 
	"thumbnail" (sdict "url" $avatar)}}

{{$remove1 := cembed 
	"title" (joinStr "" "**" .User.Username " a supprimé la publicité de " .Message.Author " pour la raison: Publicité dans le salon inapproprié.**")
	"description" (joinStr "" .Message.Content "\n \n **Salon:** <#" .Channel.ID "> \n **Auteur:** " .Message.Author "")
	"color" 16711680
	"thumbnail" (sdict "url" $avatar)}}

{{$remove2 := cembed 
	"title" (joinStr "" "**" .User.Username " a supprimé la publicité de " .Message.Author " pour la raison: Serveur interdit/illégal.**")
	"description" (joinStr "" .Message.Content "\n \n **Salon:** <#" .Channel.ID "> \n **Auteur:** " .Message.Author "")
	"color" 16711680
	"thumbnail" (sdict "url" $avatar)}}

{{$remove3 := cembed 
	"title" (joinStr "" "**" .User.Username " a supprimé la publicité de " .Message.Author " pour la raison: Lien d’invitation invalide.**")
	"description" (joinStr "" .Message.Content "\n \n **Salon:** <#" .Channel.ID "> \n **Auteur:** " .Message.Author "")
	"color" 16711680
	"thumbnail" (sdict "url" $avatar)}}

{{$remove4 := cembed 
	"title" (joinStr "" "**" .User.Username " a supprimé la publicité de " .Message.Author " pour la raison: Publicité à contenu pornographique, raciste, ou haineux. **")
	"description" (joinStr "" .Message.Content "\n \n **Salon:** <#" .Channel.ID "> \n **Auteur:** " .Message.Author "")
	"color" 16711680
	"thumbnail" (sdict "url" $avatar)}}

{{$remove5 := cembed 
	"title" (joinStr "" "**" .User.Username " a supprimé la publicité de " .Message.Author " pour la raison: Autre Motif.**")
	"description" (joinStr "" .Message.Content "\n \n **Salon:** <#" .Channel.ID "> \n **Auteur:** " .Message.Author "")
	"color" 16711680
	"thumbnail" (sdict "url" $avatar)}}

{{$remove6 := cembed 
	"title" (joinStr "" "**" .User.Username " a supprimé la publicité de " .Message.Author " pour la raison: Autre Motif.**")
	"description" (joinStr "" .Message.Content "\n \n **Salon:** <#" .Channel.ID "> \n **Auteur:** " .Message.Author "")
	"color" 16711680
	"thumbnail" (sdict "url" $avatar)}}


{{if eq .Reaction.Emoji.Name "✅"}}
	{{if hasRoleID $role}} 
		{{deleteAllMessageReactions nil .Reaction.MessageID}}
		{{addReactions "🆗"}}
		{{sendMessage $logs $accept}}
		{{dbSet 118 $key (add (toInt ($userVerif.Value)) 1)}}
	{{else}}
		{{sendDM "Tu n'es pas un modérateur !"}}
	{{end}}
{{end}}

{{if eq .Reaction.Emoji.Name "❎"}}
	{{if hasRoleID $role}} 
		{{deleteAllMessageReactions nil .Reaction.MessageID}}
		{{addReactions "1️⃣" "2️⃣" "3️⃣" "4️⃣" "5️⃣" "6️⃣"}}
		{{if $DM}}

		{{else}}
			{{sendDM "__Voici les motifs de warn:__ \n1️⃣ Publicité dans le salon inapproprié. \n2️⃣ Serveur interdit/illégal. \n3️⃣ Lien d’invitation invalide. \n4️⃣ Publicité à contenu pornographique, raciste, ou haineux. \n5️⃣ Pas de description.\n6️⃣ Autre Motif."}}
		{{end}}
	{{else}}
		{{sendDM "Tu n'es pas un modérateur !"}}
	{{end}}
{{end}}

{{if eq .Reaction.Emoji.Name "1️⃣"}}
	{{if hasRoleID $role}} 
		{{deleteMessage nil .Reaction.MessageID 0}}
		{{exec "warn" .Message.Author "Publicité dans le salon inapproprié." }}
		{{sendMessage $logs $remove1}}
		{{dbSet 118 $key (add (toInt ($userVerif.Value)) 1)}}
	{{else}}
		{{sendDM "Tu n'es pas un modérateur !"}}
	{{end}}
{{end}}

{{if eq .Reaction.Emoji.Name "2️⃣"}}
	{{if hasRoleID $role}} 
		{{deleteMessage nil .Reaction.MessageID 0}}
		{{exec "warn" .Message.Author "Serveur interdit/illégal. " }}
		{{sendMessage $logs $remove2}}
		{{dbSet 118 $key (add (toInt ($userVerif.Value)) 1)}}
	{{else}}
		{{sendDM "Tu n'es pas un modérateur !"}}
	{{end}}
{{end}}

{{if eq .Reaction.Emoji.Name "3️⃣"}}
	{{if hasRoleID $role}} 
		{{deleteMessage nil .Reaction.MessageID 0}}
		{{exec "warn" .Message.Author "Lien d’invitation invalide." }}
		{{sendMessage $logs $remove3}}
		{{dbSet 118 $key (add (toInt ($userVerif.Value)) 1)}}
	{{else}}
		{{sendDM "Tu n'es pas un modérateur !"}}
	{{end}}
{{end}}

{{if eq .Reaction.Emoji.Name "4️⃣"}}
	{{if hasRoleID $role}} 
		{{deleteMessage nil .Reaction.MessageID 0}}
		{{exec "warn" .Message.Author "Publicité à contenu pornographique, raciste, ou haineux." }}
		{{sendMessage $logs $remove4}}
		{{dbSet 118 $key (add (toInt ($userVerif.Value)) 1)}}
	{{else}}
		{{sendDM "Tu n'es pas un modérateur !"}}
	{{end}}
{{end}}

{{if eq .Reaction.Emoji.Name "5️⃣"}}
	{{if hasRoleID $role}} 
		{{deleteMessage nil .Reaction.MessageID 0}}
		{{exec "warn" .Message.Author "Pas de description." }}
		{{sendMessage $logs $remove5}}
		{{dbSet 118 $key (add (toInt ($userVerif.Value)) 1)}}
	{{else}}
		{{sendDM "Tu n'es pas un modérateur !"}}
	{{end}}
{{end}}

{{if eq .Reaction.Emoji.Name "6️⃣"}}
	{{if hasRoleID $role}} 
		{{deleteMessage nil .Reaction.MessageID 0}}
		{{exec "warn" .Message.Author "Raison non précisée." }}
		{{sendMessage $logs $remove5}}
		{{dbSet 118 $key (add (toInt ($userVerif.Value)) 1)}}
	{{else}}
		{{sendDM "Tu n'es pas un modérateur !"}}
	{{end}}
{{end}}
