extends Node
class_name Enumerations

var command = Commands.NONE
var command_mod = CommandsMods.NONE

enum Commands {
	NONE,
	MOVE,
	ATTACK_MOVE,
	HOLD
}

enum CommandsMods {
	NONE,
	ATTACK_MOVE
}
