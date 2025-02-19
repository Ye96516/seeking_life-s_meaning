extends Node

##这是计算buff的函数
func buff(player_res:EntityAttributes,buff_res:EntityAttributes,ignore_array:Array=["name"]):
	if buff_res.attri.name=="buffx":
		for i in buff_res.attri:
			if i in ignore_array:
				continue
			player_res.attri[i]*=buff_res.attri[i]
	else:
		for i in buff_res.attri:
			if i in ignore_array:
				continue
			player_res.attri[i]+=buff_res.attri[i]
	ResourceSaver.save(player_res,"res://scripts/res/player_res.tres")
