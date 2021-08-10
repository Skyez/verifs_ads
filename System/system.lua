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
	"title" (joinStr "" "**" .User.Username " validated the advertisement of " .Message.Author "**")
	"description" (joinStr "" .Message.Content "\n \n **Channel:** <#" .Channel.ID "> \n **Author:** " .Message.Author "")
	"color" 454749 
	"thumbnail" (sdict "url" $avatar)}}
{{$remove1 := cembed 
	"title" (joinStr "" "**" .User.Username " removed advertising of " .Message.Author " for the reason: Inappropriate channel of advertising.**")
	"description" (joinStr "" .Message.Content "\n \n **Channel:** <#" .Channel.ID "> \n **Author:** " .Message.Author "")
	"color" 16711680
	"thumbnail" (sdict "url" $avatar)}}
{{$remove2 := cembed 
	"title" (joinStr "" "**" .User.Username " removed advertising of " .Message.Author " for the reason: Forbidden/Illegal server.**")
	"description" (joinStr "" .Message.Content "\n \n **Channel:** <#" .Channel.ID "> \n **Author:** " .Message.Author "")
	"color" 16711680
	"thumbnail" (sdict "url" $avatar)}}
{{$remove3 := cembed 
	"title" (joinStr "" "**" .User.Username " removed advertising of " .Message.Author " for the reason: Invalid invitation link.**")
	"description" (joinStr "" .Message.Content "\n \n **Channel:** <#" .Channel.ID "> \n **Author:** " .Message.Author "")
	"color" 16711680
	"thumbnail" (sdict "url" $avatar)}}
{{$remove4 := cembed 
	"title" (joinStr "" "**" .User.Username " removed advertising of " .Message.Author " for the reason: Advertising with pornographic, racist or hateful content. **")
	"description" (joinStr "" .Message.Content "\n \n **Channel:** <#" .Channel.ID "> \n **Author:** " .Message.Author "")
	"color" 16711680
	"thumbnail" (sdict "url" $avatar)}}
{{$remove5 := cembed 
	"title" (joinStr "" "**" .User.Username " removed advertising of " .Message.Author " for the reason: No description.**")
	"description" (joinStr "" .Message.Content "\n \n **Channel:** <#" .Channel.ID "> \n **Author:** " .Message.Author "")
	"color" 16711680
	"thumbnail" (sdict "url" $avatar)}}
{{$remove6 := cembed 
	"title" (joinStr "" "**" .User.Username " removed advertising of " .Message.Author " for the reason: Reason not specified.**")
	"description" (joinStr "" .Message.Content "\n \n **Channel:** <#" .Channel.ID "> \n **Author:** " .Message.Author "")
	"color" 16711680
	"thumbnail" (sdict "url" $avatar)}}
{{if eq .Reaction.Emoji.Name "✅"}}
	{{if hasRoleID $role}} 
		{{deleteAllMessageReactions nil .Reaction.MessageID}}
		{{addReactions "🆗"}}
		{{sendMessage $logs $accept}}
		{{dbSet 118 $key (add (toInt ($userVerif.Value)) 1)}}
	{{else}}
		{{sendDM "You are not a moderator !"}}
	{{end}}
{{end}}
{{if eq .Reaction.Emoji.Name "❎"}}
	{{if hasRoleID $role}} 
		{{deleteAllMessageReactions nil .Reaction.MessageID}}
		{{addReactions "1️⃣" "2️⃣" "3️⃣" "4️⃣" "5️⃣" "6️⃣"}}
		{{if $DM}}
		{{else}}
			{{sendDM "__Here are the motives of warn:__ \n1️⃣ Inappropriate channel of advertising \n2️⃣ Forbidden/Illegal server. \n3️⃣ Invalid invitation link. \n4️⃣ Advertising with pornographic, racist or hateful content. \n5️⃣ No description.\n6️⃣ Reason not specified."}}
		{{end}}
	{{else}}
		{{sendDM "You are not a moderator !"}}
	{{end}}
{{end}}
{{if eq .Reaction.Emoji.Name "1️⃣"}}
	{{if hasRoleID $role}} 
		{{deleteMessage nil .Reaction.MessageID 0}}
		{{exec "warn" .Message.Author "Inappropriate channel of advertising." }}
		{{sendMessage $logs $remove1}}
		{{dbSet 118 $key (add (toInt ($userVerif.Value)) 1)}}
	{{else}}
		{{sendDM "You are not a moderator !"}}
	{{end}}
{{end}}
{{if eq .Reaction.Emoji.Name "2️⃣"}}
	{{if hasRoleID $role}} 
		{{deleteMessage nil .Reaction.MessageID 0}}
		{{exec "warn" .Message.Author "Forbidden/Illegal server. " }}
		{{sendMessage $logs $remove2}}
		{{dbSet 118 $key (add (toInt ($userVerif.Value)) 1)}}
	{{else}}
		{{sendDM "You are not a moderator !"}}
	{{end}}
{{end}}
{{if eq .Reaction.Emoji.Name "3️⃣"}}
	{{if hasRoleID $role}} 
		{{deleteMessage nil .Reaction.MessageID 0}}
		{{exec "warn" .Message.Author "Invalid invitation link." }}
		{{sendMessage $logs $remove3}}
		{{dbSet 118 $key (add (toInt ($userVerif.Value)) 1)}}
	{{else}}
		{{sendDM "You are not a moderator !"}}
	{{end}}
{{end}}
{{if eq .Reaction.Emoji.Name "4️⃣"}}
	{{if hasRoleID $role}} 
		{{deleteMessage nil .Reaction.MessageID 0}}
		{{exec "warn" .Message.Author "Advertising with pornographic, racist or hateful content." }}
		{{sendMessage $logs $remove4}}
		{{dbSet 118 $key (add (toInt ($userVerif.Value)) 1)}}
	{{else}}
		{{sendDM "You are not a moderator !"}}
	{{end}}
{{end}}
{{if eq .Reaction.Emoji.Name "5️⃣"}}
	{{if hasRoleID $role}} 
		{{deleteMessage nil .Reaction.MessageID 0}}
		{{exec "warn" .Message.Author "No description." }}
		{{sendMessage $logs $remove5}}
		{{dbSet 118 $key (add (toInt ($userVerif.Value)) 1)}}
	{{else}}
		{{sendDM "You are not a moderator !"}}
	{{end}}
{{end}}
{{if eq .Reaction.Emoji.Name "6️⃣"}}
	{{if hasRoleID $role}} 
		{{deleteMessage nil .Reaction.MessageID 0}}
		{{exec "warn" .Message.Author "Reason not specified." }}
		{{sendMessage $logs $remove5}}
		{{dbSet 118 $key (add (toInt ($userVerif.Value)) 1)}}
	{{else}}
		{{sendDM "You are not a moderator !"}}
	{{end}}
{{end}}
