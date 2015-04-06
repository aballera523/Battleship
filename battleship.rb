#!/usr/bin/ruby
# -*- coding: utf-8 -*-
# Alexander Ballera alex@alexballera.com

def init_board
	board = []
	for i in (0..5)
		board.push([])
		for j in (0..5)
	 		board[i][j] = '[ ]'
		end
	end
	board
end

def print_board board
	puts "   0  1  2  3  4  5"
	for i in (0..5)
		line = "#{i} "
		for j in (0..5)
			line = line + board[i][j]
		end
		puts line
	end
end

def request_coordinates player_name, ship
	puts """
#{player_name} introduzca las coordenadas del barco tipo #{ship}, 
en el formato 'fila,columna' (p.e. 1,2): """
	coord = gets.chomp.split(',')
	for i in 0...2	
		coord[i] = coord[i].to_i
	end	
	coord
end

def request_direction player_name, ship
	puts """
#{player_name} introduzca la orientacion del barco de tamano 
#{ship}, el formato permitdo es H para Horizontal o V para 
vertical"""
	direction = gets.chomp.to_s

	direction
end

def check_position player_board, coord, direction, ship
	if direction == 'h' || direction == 'H'
		index_m = coord[1]
		index = coord[0]
	elsif direction == 'v' || direction == 'V'
		index_m = coord[0]
		index = coord[1]
	else return false
	end

	if index_m + ship <= 5
		max = index_m + ship
		for i in index_m...max
			valor = direction == 'h'? player_board[index][i] : player_board[i][index]
			if  valor != '[ ]'
				return false
			end
		end
	else
		return false
	end
	return true
end

def check_ship board, coord, direction, ship
	if board [coord[0]][coord[1]] != '[ ]'
		return false
	end
	if direction == 'h' || direction == 'H'
		aux = coord[1]
		k = coord[0]
		for i in 1..ship
				if board[k][aux] != '[ ]'
				return false
			end
			aux +=1
		end
	elsif direction == 'v' || direction == 'V'
		aux = coord[0]
		k = coord[1]
		for i in 1..ship
			if board[aux][k] != '[ ]'
				return false
			end
			aux +=1
		end
	end
	return true
end 

def ship_position board, coord, direction, ship
	if board [coord[0]][coord[1]] != '[ ]'
		return false
	elsif (direction == 'h' || direction == 'H')
		aux = coord[1]
		k = coord[0]
		for i in 1..ship
			if board[k][aux] != '[ ]'
				return false
			else
				board[k][aux] = "[#{ship}]"
			end
			aux +=1
		end
	elsif (direction == 'v' || direction == 'V')
		aux = coord[0]
		k = coord[1]
		for i in 1..ship
			if board[aux][k] != '[ ]'
				return false				
			else
				board[aux][k] = "[#{ship}]"
			end
			aux +=1
		end
	end
	return true
end

def init_ship player_board, player_name 
	ship = [2,3,4]
	puts """
#{player_name} a continuacion va a introducir las coordenadas 
y orientacion del barco, las coordenadas en el formato 
'fila,columna', numeros enteros del 0 al 5, la orientacion 'h' 
para Horizontal y 'v' para vertical, los barcos son del tipo y 
longitud #{ship}, guiese segun el tablero que se muestra a 
continuacion: \n\n"""
	print_board player_board
	for i in 0...ship.length
		coord = request_coordinates player_name, ship[i]
		direction = request_direction player_name, ship[i]
		if check_position player_board, coord, direction, ship[i]
		else 
			puts """
Coordenadas Invalidas! VUELVA A INTRODUCIRLAS!"""	
			print_board player_board
			redo
		end
		ship_position player_board, coord, direction, ship[i]
		print_board player_board	
	end
	return player_board
end

def print_attack_board player_attack_board
	puts "   0  1  2  3  4  5"
	for i in (0..5)
		line = "#{i} "
		for j in (0..5)
			line = line + player_attack_board[i][j]
		end
		puts line
	end
end

def request_coordinates_attack player_name
	coord_attack = gets.chomp.split(',')
	for i in 0...2	
		coord_attack[i] = coord_attack[i].to_i
	end	
	coord_attack
end

def init_attack player_name, player_board, player_attack_board
	puts """
#{player_name} Felicitaciones! Ya Posicionaste Tus Barcos, 
Ahora Es El Momento Del Ataque, A Continuacion Te Pediremos 
Que Introduzcas Las Coordenadas De Ataque \n\n"""
	puts """
#{player_name} Introduzca Las Coordenadas De Ataque, El Formato 
Permitido Es: 'fila,columna' (p.e. 1,4), En Numeros Enteros 
Desde El '0' al '5', Segun El Siguiente Tablero: \n\n """
	puts "+"*64
	puts "\n"
	puts """
#{player_name} Este Es Tu Tablero De Ataque: \n"""
	print_attack_board player_attack_board
	puts "\n"
	puts "+"*64
	puts "\n"
	puts """
#{player_name} Esta Es Tu Flota De Barcos: \n"""
	print_board player_board
end

def attack player2board, player_board, player_attack_board, player_name
	puts """
Introduzca Las Coordenadas De Bombardeo Ahora:\n """
	coord_attack = request_coordinates_attack player_name
	for i in 1..72
		if player_attack_board [coord_attack[0]][coord_attack[1]] == '[X]'
			puts "+"*64
			puts """
En Ese Blanco Ya Jugaste! Pierdes Tu Turno!!! \n"""
			sleep 1
			break

		elsif player2board [coord_attack[0]][coord_attack[1]] != '[ ]'
			puts "+"*64
			puts """
Felicitaciones Diste En El Blanco \n"""
			player_attack_board [coord_attack[0]][coord_attack[1]] = '[X]'
			player2board [coord_attack[0]][coord_attack[1]] = '[X]'
			puts "+"*64
			puts "\n"
			puts """
#{player_name} Este Es Tu Tablero De Ataque: \n"""
			print_attack_board player_attack_board
			puts "\n"
			puts "+"*64
			puts "\n"
			puts """
#{player_name} Esta Es Tu Flota De Barcos: \n"""
			print_board player_board
			sleep 1
			break
		else
			puts """
Fallaste! Lo Siento Tu Ataque Fue Fallido!"""
			player_attack_board [coord_attack[0]][coord_attack[1]] = '[A]'
			puts "+"*64
			puts "\n"
			puts """
#{player_name} Este Es Tu Tablero De Ataque: \n"""
			print_attack_board player_attack_board
			puts "\n"
			puts "+"*64
			puts "\n"
			puts """
#{player_name} Esta Es Tu Flota De Barcos: \n"""
			print_board player_board
			sleep 1
			break
		end
	i += 1
	end
	return player_attack_board
end

def check_winner board
	target = 0
	for i in 0..5
		for j in 0..5
			if board[i][j] == '[X]'
				target += 1
			end
		end
	end

	if target == 9
		return true
	else
		return false
	end
end

def game 
	puts """
--->>>Bienvenido a Battleship El Juego de Estrategias<<<---
	
=== Tableros ===
Cada jugador maneja dos tableros cuadrados de 6 por 6, y cada 
posición en el tablero se identifica con un número para las 
columnas y filas (del 0 al 5). Cada tablero representa una zona 
diferente del mar abierto: la propia y la contraria. 

En uno de los tableros, el jugador coloca sus barcos; en el 
otro, se registran los tiros propios, al tiempo que se deduce 
la posicion de los barcos del contrincante.

=== Naves === 
Al comenzar, cada jugador posiciona sus barcos en el primer 
tablero, de forma secreta, invisible al oponente. Cada quien 
ocupa, segun sus preferencias, una misma cantidad de casillas, 
horizontal y/o verticalmente, las que representan sus naves. 

Ambos participantes deben ubicar igual el numero de naves. 
Se estipulan 3 tripos de naves: 'portaaviones' de tamano 4; 
'acorazado' de tamano 3 y 'submarino' de tamano 2.

=== Desarrollo del juego === 
Una vez todas las naves han sido posicionadas, se inicia una 
serie de rondas. En cada ronda, cada jugador en su turno 
'dispara' hacia la flota de su oponente indicando una posición 
(las coordenadas de una casilla), la que registra en el segundo 
tablero.

Si esa posición es ocupada por parte de un barco contrario, se 
marcara 'X' como muestra de haber dado en el banco. Si la 
posicion indicada no corresponde a una parte de barco alguno, 
se marca 'Agua'.

=== Fin del juego ===
El juego termina con un ganador: '''hay ganador''': quien 
descubra, quien destruya primero todas las naves de su oponente 
sera el vencedor

Presiona ENTER Para Continuar
"""
	pause = STDIN.gets
	puts `clear`
	puts "+"*64
	puts """
Jugador 1 Introduzca Su Nombre: """
	player_name = gets.chomp.capitalize
	player_board = init_board
	player_attack_board = init_board
	init_ship player_board, player_name
	puts "+"*64
	puts "Presiona ENTER Para Continuar"
	pause = STDIN.gets
	puts `clear`

	puts "+"*64
	puts """
Jugador 2 Introduzca Su Nombre: """
	player2_name = gets.chomp.capitalize
	player2_board = init_board
	player2_attack_board = init_board
	init_ship player2_board, player2_name
	puts "+"*64
	sleep 1
	puts `clear`

	puts "+"*64
	while true
		init_attack player_name, player_board, player_attack_board
		attack player2_board, player_board, player_attack_board, player_name
		if check_winner player_attack_board
			winner = player_name
			puts "\n"
			puts "+"*64
			puts "\n"
			puts """
Felicitaciones #{winner}! GANASTE!!!"""
			puts "\n"
			puts "+"*64
			puts "\n"
			break			
		end

		init_attack player2_name, player2_board, player2_attack_board 
		attack player_board, player2_board, player2_attack_board, player_name
		if check_winner player2_attack_board
			winner = player2_name
			puts "\n"
			puts "+"*64
			puts "\n"
			puts """
Felicitaciones #{winner}! GANASTE!!!"""
			puts "\n"
			puts "+"*64
			puts "\n"
			break			
		end
	end
end

game 
