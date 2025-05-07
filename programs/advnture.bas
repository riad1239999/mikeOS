REM ------------------------------------------------
REM ADVENTURE 2.3 -- By Justin Tokarchuk
REM For MikeOS and MikeBasic Derivatives
REM ------------------------------------------------

REM VARS:
REM $1 = Player Name
REM a = room number
REM b = got note
REM c = got flashlight
REM d = opened treasure chest
REM e = got key

a = 1
b = 0
c = 0
d = 0
e = 0
f = 0
$1 = ""

LOGO:
  CLS
  PRINT "          _______     __                     __                     __ " 
  PRINT "         |   _   |.--|  |.--.--.-----.-----.|  |_.--.--.----.-----.|  |"
  PRINT "         |       ||  _  ||  |  |  -__|     ||   _|  |  |   _|  -__||__|"
  PRINT "         |___|___||_____| \___/|_____|__|__||____|_____|__| |_____||__|"
  PRINT " "
  PRINT "         --------------------------------------------------------------"
  PRINT "                        |  modified version of advnture.bas from mikeOS |              "
  PRINT "                         -------------------------------               "
  PRINT ""
  PRINT ""
  PRINT ""
  PRINT ""

GETNAME:
  PRINT ""
  PRINT " What do you call yourself?: " ;
  INPUT $1
  IF $1 = "" THEN GOTO GETNAME

GETNAMEREMARK:
  RAND X 1 3
  PRINT ""
  PRINT " " ;
  PRINT $1 ;
  if x = 1 then PRINT "! What kind of name is that? It's okay, though."
  if x = 2 then PRINT "? What kind of name is that! Oh well, it's your name."
  if x = 3 then PRINT "!? Sounds like you came from somewhere far away!"
  GOSUB PRESSAKEY
  
GOTO GAMEINTRO

HELP:
  PRINT ""  
  PRINT " The following are valid commands ingame:"
  PRINT ""
  PRINT " CLS                       - CLEARS THE SCREEN"
  PRINT " LOOK                      - REPRINTS ROOM DESCRIPTION"
  PRINT " INVENTORY                 - VIEW WHAT YOU ARE CARRYING"
  PRINT " NORTH, WEST, SOUTH, EAST  - MOVES TO INPUTTED DIRECTION"
  PRINT " EXAMINE (OBJECT)          - EXAMINES AN OBJECT"
  PRINT " USE (OBJECT)              - USES AN OBJECT"
  PRINT " TAKE (OBJECT)             - TAKES AN OBJECT"
  PRINT " OPEN (OBJECT)             - OPENS A CONTAINER"
  PRINT " UNLOCK (OBJECT)           - ATTEMPTS TO UNLOCK A DOOR"
  PRINT " HELP                      - VIEW THESE COMMANDS AGAIN"
  PRINT " EXIT                      - QUITS THE GAME"
  RETURN

LOWERCASE:
  J = & $2
  FOR X = 1 TO 20
    PEEK K J
    IF K < 65 THEN GOTO NOTCAPITAL
    IF K > 90 THEN GOTO NOTCAPITAL
    K = K + 32
    POKE K J
    NOTCAPITAL:
    J = J + 1
  NEXT X
RETURN

GAMEINTRO:
  PRINT ""
  PRINT " LATE NIGHT, the sky is dark and the stars are bright. But you're stuck"
  PRINT " inside your own house, grounded. You can't even go outside for some fresh air."
  GOSUB PRESSAKEY
  PRINT " THIS IS RIDICULOUS! I am " ;
  PRINT $1 ;
  PRINT ", and I’m not staying locked up! I'm gonna break out!"
  PRINT " I’m going to find a way out and prove to my friends that my house isn’t haunted!"
  GOSUB PRESSAKEY
  PRINT " You quietly sneak out of your room and head down the stairs. You spot your father"
  PRINT " sleeping on the couch. It's the perfect time to slip out! You dash to the back door."
  GOSUB PRESSAKEY
  PRINT " You carefully open the door, but then suddenly – SLAM! The door closes behind you!"
  PRINT " The door is locked, and you’re stuck outside, in the backyard!"
  GOSUB PRESSAKEY
  PRINT " You spot a shed at the end of the yard with a rusty padlock on it. Could there be a way"
  PRINT " out of this situation?"
  GOSUB PRESSAKEY
  GOSUB MOVEROOM
  GOTO PARSER

MOVEROOM:
  IF a = 1 THEN GOSUB R1
  IF a = 2 THEN GOSUB R2
  IF a = 3 THEN GOSUB R3
  IF a = 4 THEN GOSUB R4
  IF a = 5 THEN GOSUB R5
  IF a = 6 THEN GOSUB R6
  RETURN

R1:
  PRINT ""
  PRINT " -- The Backyard -- "
  PRINT " You stand in the backyard with a locked door behind you."
  PRINT " The rusty shed seems like the next step to freedom."
  RETURN

R2:
  PRINT ""
  PRINT " -- The Shed -- "
  PRINT " There's an old wooden shed here. It looks like it hasn’t been used in years."
  PRINT " You see a strange key lying on the ground, but it's locked up inside the shed."
  RETURN

R3:
  PRINT ""
  PRINT " -- The Fence -- "
  PRINT " You try to climb over the fence, but it's too tall, and you don’t have any tools."
  RETURN

R4:
  PRINT ""
  PRINT " -- The Tool Box -- "
  PRINT " You find a toolbox here with some useful tools."
  IF c = 0 THEN PRINT " You take the flashlight from the box."
  RETURN

R5:
  PRINT ""
  PRINT " -- The Garage -- "
  PRINT " The garage door is closed, but you can hear noises from inside."
  RETURN

R6:
  PRINT ""
  PRINT " -- The Alley -- "
  IF c = 1 THEN PRINT " + You turn on your flashlight."
  IF c = 1 THEN PRINT " The alley is dark and creepy, but you can see now."
  IF c = 0 THEN PRINT " It's too dark to see anything."
  RETURN

PARSER:
  x = 0
  PRINT ""
  PRINT "> " ;
  INPUT $2
  GOSUB LOWERCASE
  IF $2 = "cls" THEN CLS
  IF $2 = "help" THEN GOSUB HELP
  IF $2 = "north" THEN GOSUB NORTH
  IF $2 = "n" THEN GOSUB NORTH
  IF $2 = "south" THEN GOSUB SOUTH
  IF $2 = "s" THEN GOSUB SOUTH
  IF $2 = "west" THEN GOSUB WEST
  IF $2 = "w" THEN GOSUB WEST
  IF $2 = "east" THEN GOSUB EAST
  IF $2 = "e" THEN GOSUB EAST
  IF $2 = "look" THEN GOSUB MOVEROOM
  IF $2 = "inventory" THEN GOSUB INVENTORY
  IF $2 = "examine shed" AND a = 1 THEN PRINT " An old shed with a rusty lock. You might be able to find something useful inside."
  IF $2 = "examine toolbox" AND a = 4 THEN PRINT " A toolbox with some handy items. There’s a flashlight in it."
  IF $2 = "take flashlight" AND a = 4 AND c = 0 THEN GOSUB FLASHLIGHT
  IF $2 = "take flashlight" AND a = 4 AND c =
