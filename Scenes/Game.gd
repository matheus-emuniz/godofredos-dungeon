extends Node2D
onready var esqueleto_tscn = load("res://Scenes/Esqueleto.tscn")
onready var zumbi_tscn = load("res://Scenes/Zumbi.tscn")
onready var slime_tscn = load("res://Scenes/Slime.tscn")

onready var espada_tscn = load("res://Scenes/Espada.tscn")
onready var espada_dourada_tscn = load("res://Scenes/EspadaDourada.tscn")
onready var pocao_tscn = load("res://Scenes/Pocao.tscn")

onready var vaziokkj = load("res://Scenes/vaziokkj.tscn")

onready var stats = get_node("Stats")
onready var sound_effects_player = get_node("SoundEffects")

onready var Player = get_node("Player")
export var player_level: int = 1
export var tipo = "player"

onready var area_player = [0,1,4,5]
onready var visao_player = [0,1,4,5]

var can_move = []
onready var map_sprite = [
	null, null, null, null, 
	null, null, null, null, 
	null, null, null, null, 
	null, null, null, null, 
]
onready var map = [
	get_node("Map/MapTile0"), get_node("Map/MapTile1"), get_node("Map/MapTile2"), get_node("Map/MapTile3"),
	get_node("Map/MapTile4"), get_node("Map/MapTile5"), get_node("Map/MapTile6"), get_node("Map/MapTile7"),
	get_node("Map/MapTile8"), get_node("Map/MapTile9"), get_node("Map/MapTile10"), get_node("Map/MapTile11"),
	get_node("Map/MapTile12"), get_node("Map/MapTile13"), get_node("Map/MapTile14"), get_node("Map/MapTile15"),
]
var oldi = null
var newi = null
onready var player_position: TouchScreenButton = get_node("Map/MapTile6")


func _ready():
	map[player_position.index] = Player
	
	print(map)
	move_player(player_position)
	
	SimpleSave.load_scene_partial(stats, 'stats.tscn')
	
	stats.current_score = 0

func check_visao(posicao):
	#return
	# Descomentar o return pra desativar rolê de visão @mat
	if posicao.tipo == "player":
		return
	if posicao.index in visao_player and posicao.tipo != "vazio":
		var tcn
		if posicao.tipo == "espada":
			tcn = espada_tscn
		elif posicao.tipo == "espada_dourada":
			tcn = espada_dourada_tscn
		elif posicao.tipo == "pocao":
			tcn = pocao_tscn
		elif posicao.tipo == "slime":
			tcn = slime_tscn
		elif posicao.tipo == "esqueleto":
			tcn = esqueleto_tscn
		elif posicao.tipo == "zumbi":
			tcn = zumbi_tscn
		inject_sprite(posicao, tcn)
	if !(posicao.index in visao_player):
		inject_sprite(posicao, vaziokkj)
	else:
		if posicao.tipo != "vazio" and posicao.tipo != "player":
			var tcn
			if posicao.tipo == "espada":
				tcn = espada_tscn
			elif posicao.tipo == "espada_dourada":
				tcn = espada_dourada_tscn
			elif posicao.tipo == "pocao":
				tcn = pocao_tscn
			elif posicao.tipo == "slime":
				tcn = slime_tscn
			elif posicao.tipo == "esqueleto":
				tcn = esqueleto_tscn
			elif posicao.tipo == "zumbi":
				tcn = zumbi_tscn
			inject_sprite(posicao, tcn)

func randomize_spawn():
	for espaco in map:
		#if lugar in area_player:
		#	continue
			
		var node_spawn = null
		
		
		if espaco.tipo != "vazio":
			continue
			
		if espaco.tipo == "player" or (espaco.index in area_player):
			if espaco.tipo == "player":
				map[oldi] = get_node("Map/MapTile" + str(oldi))
				#inject_sprite(1, 0)
			#if espaco.tipo != "player":
			#	map[espaco.index] = get_node("Map/MapTile" + str(espaco.index))
			#	if map_sprite[espaco.index]:
			#		inject_sprite(espaco, vaziokkj)
			continue
		
			
		var tscn = null
		
		var spawns = randi()%10
		# @mat
		#var dificuldade = 20 + player_level
		#var spawns = randi()%dificuldade
		#var spawns = randi()%(20 + player_level)
		# Se deixar assim, sempre serão repetidos os mesmos números o.O
		# Mesmo você andando pelo mapa e matando bixo, os spawns sempre serão os mesmos
		# print(spawns)
		# Essa vai ser a sequência coom esse print e esse randi:
		#   14
		#	6
		#	16
		#	2
		#	0
		#	0
		#	2
		# Att: Acabei de descobrir que o randi sempre mantém um padrão
		# independente de como fazer o % e tal lul
		# Pelo menos no meu pc
		# Fazendo pathing diferentes só se altera a ordem do randi
		# Faz o teste:
		# Starta, vai dois pra esquerda e volta pra direita, vê o que spawnow na sua direita e direita baixo.
		# Starta, vai um pra esquerda, um pra baixo e + 1 pra esquerda, depois volta pra direita e olha
		# São os mesmos itens/bixos só que invertidos wtf
		
		var espada_instance
		var pocao_instance
		if spawns == 0:
			espada_instance = map[espaco.index]
			espada_instance.tipo = "espada_dourada"
			# Espada Dourada
			espada_instance.info.dano_espada = 4
			espada_instance.info.resistencia_espada = 3
			tscn = espada_dourada_tscn
			
			pass
		elif spawns in [1,2]:
			espada_instance = map[espaco.index]
			espada_instance.tipo = "espada"
			# Espada
			espada_instance.info.dano_espada = 3
			espada_instance.info.resistencia_espada = 2
			tscn = espada_tscn
			
		elif spawns in [3]:
			pocao_instance = map[espaco.index]
			pocao_instance.tipo = "pocao"
			pocao_instance.info.cura = 5
			tscn = pocao_tscn
		else:
			
			var monstro = randi()%5 + 1
			var minstance = map[espaco.index]
			if monstro in [1,2]:
				
				minstance.tipo = "slime"
				minstance.info.monstro_dano = 1
				minstance.info.monstro_vida = 2
				tscn = slime_tscn
				#slime
				pass
			elif monstro in [3,4]:
				minstance.tipo = "zumbi"
				minstance.info.monstro_dano = 2
				minstance.info.monstro_vida = 4
				tscn = zumbi_tscn
				# Zombie
				pass
			else:
				minstance.tipo = "esqueleto"
				minstance.info.monstro_dano = 3
				minstance.info.monstro_vida = 6
				tscn = esqueleto_tscn
				# Skeleton
			map[espaco.index] = minstance
		
		
		inject_sprite(espaco, tscn)
		#print(monstro)
		pass
		
func inject_sprite(map_instance, tscn):
	var sprite_anterior = map_sprite[map_instance.index]
	if sprite_anterior:
		sprite_anterior.queue_free()
	var instance = tscn.instance()
	instance.position = get_center(map_instance)
	add_child(instance)
	map_sprite[map_instance.index] = instance
	pass

func combate(godofo, inimigo):
	print(godofo.tipo)
	print(inimigo.tipo)
	print(inimigo.info)
	var istats = inimigo.info
	print(godofo.dano)
	print(godofo.resistencia)
	print(istats.monstro_vida)
	while godofo.vida > 0:
		print("Godofs Dano:" + str(godofo.dano))
		print("Godofs Vida:" + str(godofo.vida))
		print("Godofs Resistencia:" + str(godofo.resistencia))
		print("Inimigo Tipo:" + str(inimigo.tipo))
		print("Inimigo Dano:" + str(istats.monstro_dano))
		print("Inimigo Vida:" + str(istats.monstro_vida))
		var mato = false
		if godofo.dano >= istats.monstro_vida:
			mato = true
			godofo.resistencia -= 1
			if godofo.resistencia <= 0:
				godofo.dano = 1
				godofo.resistencia = 100
				#muda sprite pra torch @mat
			inject_sprite(map[newi], vaziokkj)
			break
		else:
			#rola trocação sincera
			istats.monstro_vida -= godofo.dano
			if godofo.vida - istats.monstro_dano <= 0:
				print("morreu")
				godofo.vida -= istats.monstro_dano
				sound_effects_player.play_death()
				SimpleSave.save_scene_partial(stats, "stats.tscn")
				break
				#faz alguma coisa ai matheus
			else:
				godofo.vida -= istats.monstro_dano
				godofo.resistencia -= 1
				if godofo.resistencia <= 0:
					godofo.dano = 1
					godofo.resistencia = 100
					#muda sprite pra torch @mat
	print(godofo.vida)
	
func get_espada(godofo, espada):
	godofo.dano = espada.info.dano_espada
	godofo.resistencia = espada.info.resistencia_espada
	print("Pegou espada (dano): " + str(godofo.dano))
	print("Pegou espada (resistencia): " + str(godofo.resistencia))
	inject_sprite(map[newi], vaziokkj)
	sound_effects_player.play_pickup()
	#muda sprite @mat (Pode ser tanto gold qnd normal sword aq)
	
func get_pocao(godofo, pocao):
	godofo.vida += pocao.info.cura
	print("Curou: " + str(godofo.vida))
	inject_sprite(map[newi], vaziokkj)
	sound_effects_player.play_pickup()

func get_center(node: TouchScreenButton):
	return node.position + Vector2(
		(32 * player_position.scale.x) / 2,
		(32 * player_position.scale.x) / 2)

func move_player(node: TouchScreenButton):
	print(player_position)
	if !oldi:
		oldi = player_position.index - 1
	else: 
		oldi = player_position.index
	newi = node.index
	
	var parede_direita = [3,7,11,15]
	var parede_esquerda = [0,4,8,12]
		
	area_player = []
	if oldi in parede_direita and newi in [oldi - 1, oldi + 4, oldi -  4]:
		area_player = [newi, newi + 3, newi + 4, newi - 1, newi - 5, newi - 4, newi + 1, newi + 5, newi - 3]
		player_position = node
		Player.position = get_center(node)
	elif oldi in parede_esquerda and newi in [oldi + 1, oldi + 4, oldi -  4]:
		area_player = [newi, newi + 1, newi + 4, newi + 5, newi - 4, newi - 3, newi - 1, newi + 3, newi - 5]
		player_position = node
		Player.position = get_center(node)
	elif oldi in (parede_esquerda + parede_direita):
		return
	elif newi in [oldi + 1, oldi - 1, oldi + 4, oldi - 4]:
		area_player = [newi, newi + 1, newi + 3, newi + 4, newi + 5,
			newi - 1, newi - 3, newi - 4, newi -5]
		
		player_position = node
		Player.position = get_center(node)
	
	if newi in parede_direita:
		visao_player = [newi, newi + 3, newi + 4, newi - 1, newi - 5, newi - 4]
	elif newi in parede_esquerda:
		visao_player = [newi, newi + 1, newi + 4, newi + 5, newi - 4, newi - 3]
	else:
		visao_player = [newi, newi + 1, newi + 3, newi + 4, newi + 5,
			newi - 1, newi - 3, newi - 4, newi -5]
		
	if map[newi].tipo != "vazio" and map[newi].tipo != "player":
		# vai ter combate viado ou pot/espada
		if map[newi].tipo == "pocao":
			get_pocao(Player, map[newi])
		elif map[newi].tipo == "espada" or map[newi].tipo == "espada_dourada":
			get_espada(Player, map[newi])
		else:
			combate(Player, map[newi])
	print(area_player)
	
	
	map[newi] = Player
	print("atualizou")
	map[oldi] = get_node("Map/MapTile" + str(oldi))
	map[oldi].tipo = "vazio"
	
	randomize_spawn()
	for m in map:
		check_visao(m)
	

