#####################################################################
#
# CSCB58 Winter 2025 Assembly Final Project
# University of Toronto, Scarborough
#
# Student: Eric Liu, 1009906005, liueri35, eri.liu@mail.utoronto.ca
#
# Bitmap Display Configuration:
# - Unit width in pixels: 4 (update this as needed)
# - Unit height in pixels: 4 (update this as needed)
# - Display width in pixels: 256 (update this as needed)
# - Display height in pixels: 256 (update this as needed)
# - Base Address for Display: 0x10008000 ($gp)
#
# Which milestoneshave been reached in this submission?
# (See the assignment handout for descriptions of the milestones)
# - Milestone 1/2/3/4 (choose the one the applies)
#
# Which approved features have been implemented for milestone 3?
# (See the assignment handout for the list of additional features)
# 1. moving enemies (objects)
# 2. moving platforms
# 3. double jump
# ... (add more if necessary)
#
# Link to video demonstration for final submission:
# https://www.youtube.com/watch?v=j_pdhIAEpfs
#
# Are you OK with us sharing the video with people outside course staff?
# - yes
# https://github.com/eliu0412/b58-assembly-project
#
# Any additional information that the TA needs to know:
# - (write here, if any)
#
#####################################################################


# Bitmap display starter code
#
# Bitmap Display Configuration:
# - Unit width in pixels: 4
# - Unit height in pixels: 4
# - Display width in pixels: 256
# - Display height in pixels: 256
# - Base Address for Display: 0x10008000 ($gp)a
#
    .eqv BASE_ADDRESS  0x10008000   # Base address for display
    .eqv KEYBOARD_STATUS  0xffff0000  # MMIO keyboard status
    .eqv KEYBOARD_DATA    0xffff0004  # MMIO keyboard data
    .eqv JUMP_CYCLES, 10

    .data
	message:    .asciiz "hello world\n"  # Message to print when 'a' is pressed\
	quit:    .asciiz "quitting game...\n"

    .text
    .globl main

main:
	li $t0, BASE_ADDRESS
	li $t1, 0x000000
	li $t4, 65536
	li $t3, 0
	
	jal reset_screen
	
	li $t0, BASE_ADDRESS
	li $t1, 0x00ff00

	jal draw_floor
	
	# draw platforms
	li $t4, 32
	li $t2, BASE_ADDRESS       
    	addi $t2, $t2, 13280
    	jal draw_platform
    	
    	li $t4, 32
    	li $t2, BASE_ADDRESS       
    	addi $t2, $t2, 10528
    	jal draw_platform
    	
    	li $t4, 32
    	li $t2, BASE_ADDRESS       
    	addi $t2, $t2, 10688
    	jal draw_platform
    	
    	li $t4, 32
    	li $t2, BASE_ADDRESS       
    	addi $t2, $t2, 7936
    	jal draw_platform
    	
    	li $t4, 224
    	li $t2, BASE_ADDRESS       
    	addi $t2, $t2, 5408
    	jal draw_platform
    	
    	# draw health
    	li $t2, BASE_ADDRESS       
	addi $t2, $t2, 15880
	
	li $t1, 0xff0000
	sw $t1, 0($t2)
	sw $t1, 4($t2)
	sw $t1, 256($t2)
	sw $t1, 260($t2)
	
	addi $t2, $t2, 16
	
	sw $t1, 0($t2)
	sw $t1, 4($t2)
	sw $t1, 256($t2)
	sw $t1, 260($t2)
	
	
	#draw end
	li $t2, BASE_ADDRESS       
	addi $t2, $t2, 3040
	li $t1, 0xffffff
	sw $t1, 0($t2)
	sw $t1, 256($t2)
	sw $t1, 512($t2)
	
	addi $t2, $t2, 4
	sw $t1, 0($t2)
	sw $t1, 256($t2)
	sw $t1, 512($t2)
	
	addi $t2, $t2, 4
	sw $t1, 0($t2)
	sw $t1, 256($t2)
	sw $t1, 512($t2)
	
	addi $t2, $t2, 4
	sw $t1, 0($t2)
	sw $t1, 256($t2)
	sw $t1, 512($t2)
	
	li $t2, BASE_ADDRESS       
	addi $t2, $t2, 3056
	li $t1, 0xf7c22f
	sw $t1, 0($t2)
	sw $t1, 256($t2)
	sw $t1, 512($t2)
	sw $t1, 768($t2)
	sw $t1, 1024($t2)
	sw $t1, 1280($t2)
	sw $t1, 1536($t2)
	sw $t1, 1792($t2)
	sw $t1, 2048($t2)
	sw $t1, 2304($t2)
	
	
	
	
	#draw player
	li $t2, BASE_ADDRESS       
	addi $t2, $t2, 14852
	jal draw_player

	
	li $t3, 0
	
	#platform pos
	li $s0, BASE_ADDRESS
	addi $s0, $s0, 10528
	#loop counter
	li $s1, 0
	# move value
	li $s2, 4
	
	# same for enemy
	li $s3, BASE_ADDRESS
	li $s4, 0
	li $s5, -4
	
	#stagnant
	addi $s3, $s3, 4652
	li $t1, 0xf2f205
	sw $t1, 0($s3)
	sw $t1, 8($s3)
	sw $t1, 512($s3)
	sw $t1, 516($s3)
	sw $t1, 520($s3)
	
	li $t1, 0x05119c
	sw $t1, 4($s3)
	sw $t1, 256($s3)
	sw $t1, 260($s3)
	sw $t1, 264($s3)
	
	#moving
	li $s3, BASE_ADDRESS
	addi $s3, $s3, 15084
	li $t1, 0xf10af5
	sw $t1, 0($s3)
	sw $t1, 8($s3)
	sw $t1, 512($s3)
	sw $t1, 516($s3)
	sw $t1, 520($s3)
	
	li $t1, 0x05119c
	sw $t1, 4($s3)
	sw $t1, 256($s3)
	sw $t1, 260($s3)
	sw $t1, 264($s3)
	
	# hearts
	li $s6, 2
	
	# i frame
	li $s7, 0
	
	# jumps
	li $t6, 0
	
	# x-location for left-right bounds
	li $t5, 4
	
	
	j game_loop
	
	# exit program
	li $v0, 10
    	syscall

reset_screen:
	add $t5, $t0, $t3
	sw $t1, 0($t5)
	addi $t3, $t3, 4
	bge $t3, $t4, reset_screen_done
	j reset_screen
	
reset_screen_done:
	jr $ra
	
game_loop:
	jal delay
	jal handle_i_frame
	jal check_win
	jal move_platform
	jal move_enemy
	jal check_enemy_hit
	li $t9, KEYBOARD_STATUS
	lw $t8, 0($t9)
	beq $t8, 1, keypress_happened
	j is_jumping
	
	j game_loop
	
handle_i_frame:
	li $t7, 16
	blt $s7, $t7, continue_i
	jr $ra
	
continue_i:
	addi $s7, $s7, 1
	jr $ra
	
check_enemy_hit:
	sub $t7, $s3, $t2
	
	#right of enemy collision
	li $t8, 12
	beq $t7, $t8, hit
	
	li $t8, 268
	beq $t7, $t8, hit
	
	li $t8, 524
	beq $t7, $t8, hit
	
	#top of enemy collision
	li $t8, 776
	beq $t7, $t8, hit
	
	li $t8, 772
	beq $t7, $t8, hit
	
	li $t8, 768
	beq $t7, $t8, hit
	
	li $t8, 764
	beq $t7, $t8, hit
	
	li $t8, 760
	beq $t7, $t8, hit
	
	#left of enemy collision
	li $t8, 500
	beq $t7, $t8, hit
	
	li $t8, 244
	beq $t7, $t8, hit
	
	li $t8, -12
	beq $t7, $t8, hit
	
	# second
	li $t9, BASE_ADDRESS
	addi $t9, $t9, 4652
	sub $t7, $t9, $t2
	
	#right of enemy collision
	li $t8, 12
	beq $t7, $t8, hit
	
	li $t8, 268
	beq $t7, $t8, hit
	
	li $t8, 524
	beq $t7, $t8, hit
	
	#top of enemy collision
	li $t8, 776
	beq $t7, $t8, hit
	
	li $t8, 772
	beq $t7, $t8, hit
	
	li $t8, 768
	beq $t7, $t8, hit
	
	li $t8, 764
	beq $t7, $t8, hit
	
	li $t8, 760
	beq $t7, $t8, hit
	
	#left of enemy collision
	li $t8, 500
	beq $t7, $t8, hit
	
	li $t8, 244
	beq $t7, $t8, hit
	
	li $t8, -12
	beq $t7, $t8, hit
	
	jr $ra

hit:
	li $t7, 16
	beq $s7, $t7, take_damage
	jr $ra

take_damage:
	li $s7, 0
	
	# red frame
	li $t1, 0xff0000
	sw $t1, 0($t2)
	sw $t1, 8($t2)
	sw $t1, 512($t2)
	sw $t1, 516($t2)
	sw $t1, 520($t2)
	sw $t1, 4($t2)
	sw $t1, 256($t2)
	sw $t1, 260($t2)
	sw $t1, 264($t2)
	
	
	addi $s6, $s6, -1
	
	beq $s6, 0, lose
	
	li $t7, BASE_ADDRESS       
	addi $t7, $t7, 15896
	
	li $t1, 0x05119c
	sw $t1, 0($t7)
	sw $t1, 4($t7)
	sw $t1, 256($t7)
	sw $t1, 260($t7)
	
	j respond_to_w



lose:
	li $t7, BASE_ADDRESS       
	addi $t7, $t7, 15880
	
	li $t1, 0x05119c
	sw $t1, 0($t7)
	sw $t1, 4($t7)
	sw $t1, 256($t7)
	sw $t1, 260($t7)
	
	li $t1, 0xff0000
	li $t7, BASE_ADDRESS
	addi $t7, $t7, 8056
	sw $t1, 0($t7)
	sw $t1, 256($t7)
	sw $t1, 512($t7)
	sw $t1, 768($t7)
	sw $t1, 1024($t7)
	
	addi $t7, $t7, 1280
	sw $t1, 0($t7)
	sw $t1, 4($t7)
	sw $t1, 8($t7)
	sw $t1, 12($t7)
	
	jal lose_delay
	
	j respond_to_r
	
check_win:
	li $t7, BASE_ADDRESS
	addi $t7, $t7, 4836
	beq $t2, $t7, draw_w
	jr $ra

move_enemy:
	li $t7, 3
	addi $s4, $s4, 1
	blt, $s4, $t7, move_enemy_done
	
	# reset counter
	li $s4, 0
	
	li $t1, 0x000000
	sw $t1, 0($s3)
	sw $t1, 8($s3)
	sw $t1, 512($s3)
	sw $t1, 516($s3)
	sw $t1, 520($s3)
	sw $t1, 4($s3)
	sw $t1, 256($s3)
	sw $t1, 260($s3)
	sw $t1, 264($s3)
	
	add $s3, $s3, $s5
	
	li $t1, 0xf10af5
	sw $t1, 0($s3)
	sw $t1, 8($s3)
	sw $t1, 512($s3)
	sw $t1, 516($s3)
	sw $t1, 520($s3)
	li $t1, 0x05119c
	sw $t1, 4($s3)
	sw $t1, 256($s3)
	sw $t1, 260($s3)
	sw $t1, 264($s3)
	
	li $t7, BASE_ADDRESS
	addi $t7, $t7, 15084
	bge $s3, $t7, mover_enemy_left
	
	li $t7, BASE_ADDRESS
	addi $t7, $t7, 14892
	ble $s3, $t7, mover_enemy_right
	
	jr $ra
	
mover_enemy_left:
	li $s5, -4
	jr $ra
	
mover_enemy_right:
	li $s5, 4
	jr $ra

move_enemy_done:
	jr $ra

move_platform:
	li $t7, 8
	addi $s1, $s1, 1
	blt, $s1, $t7, move_platform_done
	
	# reset counter
	li $s1, 0
	
	# erase platform
	li $t1, 0x000000
	sw $t1, 0($s0)
	sw $t1, 4($s0)
	sw $t1, 8($s0)
	sw $t1, 12($s0)
	sw $t1, 16($s0)
	sw $t1, 20($s0)
	sw $t1, 24($s0)
	sw $t1, 28($s0)
	
	add $s0, $s0, $s2
	
	li $t1, 0x00ff00
	sw $t1, 0($s0)
	sw $t1, 4($s0)
	sw $t1, 8($s0)
	sw $t1, 12($s0)
	sw $t1, 16($s0)
	sw $t1, 20($s0)
	sw $t1, 24($s0)
	sw $t1, 28($s0)
	
	li $t7, BASE_ADDRESS
	addi $t7, $t7, 10656
	bge $s0, $t7, mover_set_left
	
	li $t7, BASE_ADDRESS
	addi $t7, $t7, 10528
	ble $s0, $t7, mover_set_right
	
	jr $ra
	
mover_set_left:
	li $s2, -4
	jr $ra
	
mover_set_right:
	li $s2, 4
	jr $ra

move_platform_done:
	jr $ra

keypress_happened:
	lw $t7, 4($t9)
	beq $t7, 0x61, can_a
	beq $t7, 0x64, can_d
	beq $t7, 0x77, has_jumps
	beq $t7, 0x72, respond_to_r
	beq $t7, 0x71, respond_to_q
	
	
	j game_loop

respond_to_q:
	li $v0, 4
	la $a0, quit
	syscall
	
	jal delay
	
	li $v0, 10
    	syscall

respond_to_r:
	j main
	
has_jumps:
	li $t7, 2
	blt $t6, $t7, respond_to_w
	j game_loop

respond_to_w:
	addi $t6, $t6, 1
	li $t3, 1
	j game_loop

is_jumping:
	li $t9, 9
	bge $t3, $t9, gravity
	li $t9, 0
	beq $t3, $t9, gravity

jump:
	jal reset_player_image
	subi $t2, $t2, 256
	addi $t3, $t3, 1
	jal draw_player
	j game_loop
	
gravity:
	j platform1_f
	
platform1_f:
	li $t9, BASE_ADDRESS
	addi $t9, $t9, 12504
	bge $t2, $t9, platform1_s
	j platform2_f
	
platform1_s:
	addi $t9, $t9, 32
	ble $t2, $t9, reset_jumps
	
platform2_f:
	li $t9, BASE_ADDRESS
	addi $t9, $t9, 9912
	bge $t2, $t9, platform2_s
	j platform3_f
	
platform2_s:
	addi $t9, $t9, 36
	ble $t2, $t9, reset_jumps

platform3_f:
	move $t9, $s0
	addi $t9, $t9, -776
	bge $t2, $t9, platform3_s
	j platform4_f

platform3_s:
	addi $t9, $t9, 36
	ble $t2, $t9, reset_jumps
	
platform4_f:
	li $t9, BASE_ADDRESS
	addi $t9, $t9, 7168
	bge $t2, $t9, platform4_s
	j platform5_f
	
platform4_s:
	addi $t9, $t9, 28
	ble $t2, $t9, reset_jumps
	
platform5_f:
	li $t9, BASE_ADDRESS
	addi $t9, $t9, 4632
	bge $t2, $t9, platform5_s
	j checkfall
	
platform5_s:
	addi $t9, $t9, 236
	ble $t2, $t9, reset_jumps
	
checkfall:
	li $t9, BASE_ADDRESS
	add $t9, $t9, 14848
	blt $t2, $t9, fall
	li $t6, 0
	j game_loop

fall:
	jal reset_player_image
	addi $t2, $t2, 256
	jal draw_player
	j game_loop
	
reset_jumps:
	li $t6, 0
	j game_loop
	
can_a:
	li $t7, 0
	bgt $t5, $t7, respond_to_a
	j game_loop

respond_to_a:
	jal reset_player_image
	subi $t2, $t2, 4
	addi $t5, $t5, -4
	jal draw_player
	j game_loop
	
can_d:
	li $t7, 244
	blt $t5, $t7, respond_to_d
	j game_loop
	
respond_to_d:
	jal reset_player_image
	addi $t2, $t2, 4
	addi $t5, $t5, 4
	jal draw_player
	j game_loop

	
draw_player:
	li $t1, 0xffffff
	sw $t1, 0($t2)
	sw $t1, 8($t2)
	sw $t1, 512($t2)
	sw $t1, 516($t2)
	sw $t1, 520($t2)
	
	li $t1, 0xa3a008
	sw $t1, 4($t2)
	sw $t1, 256($t2)
	sw $t1, 260($t2)
	sw $t1, 264($t2)
	jr $ra

reset_player_image:
	li $t1, 0x000000
	sw $t1, 0($t2)
	sw $t1, 4($t2)
	sw $t1, 8($t2)
	sw $t1, 256($t2)
	sw $t1, 260($t2)
	sw $t1, 264($t2)
	sw $t1, 512($t2)
	sw $t1, 516($t2)
	sw $t1, 520($t2)
	jr $ra
	
             
draw_floor:
	# initialize registers
    	li $t2, BASE_ADDRESS       
    	addi $t2, $t2, 15616

    	li $t3, 0             
    	li $t4, 256
    

draw_floor_loop:
	# move to next x
    	add $t5, $t2, $t3, 
    	
    	# draw floor 3 units thick
    	sw $t1, 0($t5)         
    	sw $t1, 256($t5)
    	sw $t1, 512($t5)
    	
    	addi $t3, $t3, 4       

    	bge $t3, $t4, draw_floor_done 
    	j draw_floor_loop     

draw_floor_done:
    	jr $ra      
    	
draw_platform:
	li $t3, 0             

draw_platform_loop:
	# before each call set:
	# t2 is platform location
	# t4 is platform width
                    
	# move to next x
    	add $t5, $t2, $t3, 
    	
    	sw $t1, 0($t5)         
    	
    	addi $t3, $t3, 4       

    	bge $t3, $t4, draw_platform_done 
    	j draw_platform_loop 
    	
draw_platform_done:
	jr $ra
	
delay:
    	li $t0, 100000      # Load the delay count value into $t0
delay_loop:
    	addi $t0, $t0, -1    # Decrement $t0
    	bnez $t0, delay_loop # If $t0 != 0, continue looping
    	jr $ra               # Return to the caller (game_loop)
    	
lose_delay:
    	li $t0, 10750000      # Load the delay count value into $t0
l_delay_loop:
    	addi $t0, $t0, -1    # Decrement $t0
    	bnez $t0, delay_loop # If $t0 != 0, continue looping
    	jr $ra               # Return to the caller (game_loop)
    	
draw_w:
	li $t1, 0xff0000
	li $t7, BASE_ADDRESS
	addi $t7, $t7, 8056
	sw $t1, 0($t7)
	sw $t1, 16($t7)
	
	addi $t7, $t7, 256
	sw $t1, 0($t7)
	sw $t1, 8($t7)
	sw $t1, 16($t7)
	
	addi $t7, $t7, 256
	sw $t1, 0($t7)
	sw $t1, 8($t7)
	sw $t1, 16($t7)
	
	addi $t7, $t7, 256
	sw $t1, 0($t7)
	sw $t1, 8($t7)
	sw $t1, 16($t7)
	
	addi $t7, $t7, 256
	sw $t1, 4($t7)
	sw $t1, 12($t7)
	j respond_to_q


	
	                
	
