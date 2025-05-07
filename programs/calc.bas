rem RiadCalc Application (CALC.BAS)
rem Modified calculator based on MikeOS original
rem Version 2.1 by Me (Riad)
rem Originally by Joshua Beck – Licensed under GNU GPL v3
rem Uses the MB++ Library (v3.0)

INCLUDE "MBPP.BAS"

START:
  CLS
  GOSUB STARTPRG
  C = 3 : H = 11 : T = 2
  MOVE 30 13
  PRINT "Launching Calculator..."
GOTO MAIN

MAIN:
  $T = "RiadCalc Main Menu"
  $5 = "Basic Math"
  $6 = "Advanced Math"
  $7 = "Customize Colors"
  $8 = "About This App"
  $9 = "Exit Program"
  GOSUB MENUBOX
  IF V = 1 THEN GOSUB BASEMATH
  IF V = 2 THEN GOSUB ADVMATH
  IF V = 3 THEN GOSUB COLCHANGE
  IF V = 4 THEN GOSUB ABOUT
  IF V = 5 THEN GOSUB ENDPROG
GOTO MAIN

COLCHANGE:
  $T = "Color Settings"
  $5 = "Outline color (1-255):"
  $6 = "Text color (1-15):"
  V = 0
  GOSUB DINBOX
  $E = "Invalid color value!"
  IF A < 1 OR A > 255 THEN GOTO ERRBOX
  IF B < 1 OR B > 15 THEN GOTO ERRBOX
  T = A : C = B
  $5 = "Highlight color (1-15):"
  $6 = ""
  V = 0
  GOSUB INPBOX
  IF V < 1 OR V > 15 THEN GOTO ERRBOX
  H = V
RETURN

BASEMATH:
  DO
    $T = "Basic Math"
    $5 = "Add Two Numbers"
    $6 = "Subtract Numbers"
    $7 = "Multiply"
    $8 = "Divide"
    $9 = "Return to Menu"
    GOSUB MENUBOX
    IF V = 1 THEN GOSUB ADD
    IF V = 2 THEN GOSUB SUB
    IF V = 3 THEN GOSUB MUL
    IF V = 4 THEN GOSUB DIV
  LOOP UNTIL V = 5
  V = 0
RETURN

ADD:
  V = 0
  $T = "Addition"
  $5 = "Enter first number:"
  $6 = "Enter second number:"
  GOSUB DINBOX
  A = A + B
  $5 = "Result:"
  $6 = ""
  GOSUB NUMBOX
RETURN

SUB:
  V = 0
  $T = "Subtraction"
  $5 = "Number to subtract from:"
  $6 = "Number to subtract:"
  GOSUB DINBOX
  A = A - B
  $5 = "Result:"
  $6 = ""
  GOSUB NUMBOX
RETURN

MUL:
  V = 0
  $T = "Multiplication"
  $5 = "First number:"
  $6 = "Second number:"
  GOSUB DINBOX
  A = A * B
  $5 = "Result:"
  $6 = ""
  GOSUB NUMBOX
RETURN

DIV:
  V = 0
  $T = "Division"
  $5 = "Dividend:"
  $6 = "Divisor:"
  GOSUB DINBOX
  $E = "Cannot divide by zero!"
  IF B = 0 THEN GOTO ERRBOX
  D = A / B
  E = A % B
  A = D : B = E
  $5 = "Quotient:"
  $6 = "Remainder:"
  GOSUB NUMBOX
RETURN

ADVMATH:
  DO
    $T = "Advanced Math"
    $5 = "Square & Cube"
    $6 = "Power (A^B)"
    $7 = "Mass Add (A+B+C+...)"
    $8 = "Mass Subtract (A−B−C...)"
    $9 = "Return to Menu"
    GOSUB MENUBOX
    IF V = 1 THEN GOSUB SQUARE
    IF V = 2 THEN GOSUB POWER
    IF V = 3 THEN GOSUB MASSADD
    IF V = 4 THEN GOSUB MASSTAKE
  LOOP UNTIL V = 5
  V = 0
RETURN

SQUARE:
  $T = "Square and Cube"
  $5 = ""
  $6 = "Enter a number:"
  V = 0
  GOSUB INPBOX
  A = V
  D = A : A = A * D
  B = A * D
  $5 = "Squared:" : $6 = "Cubed:"
  GOSUB NUMBOX
RETURN

POWER:
  $T = "Power Function"
  $5 = "Base:"
  $6 = "Exponent:"
  V = 0
  GOSUB DINBOX
  D = A
  IF B = 0 THEN A = 1 : GOTO POWERSKIP
  IF B = 1 THEN GOTO POWERSKIP
  DO
    A = A * D
    B = B - 1
  LOOP UNTIL B = 1
POWERSKIP:
  $5 = "Result:" : $6 = ""
  GOSUB NUMBOX
RETURN

MASSADD:
  $T = "Mass Addition"
  $5 = "Start number:"
  $6 = "First number to add:"
  V = 0
  GOSUB DINBOX
  N = A + B
ADDMORE:
  $5 = "Add another (0 to finish):"
  $6 = ""
  V = 0
  GOSUB INPBOX
  N = N + V
  IF V > 0 THEN GOTO ADDMORE
  $5 = "Final total:" : B = N
  $6 = ""
  GOSUB NUMBOX
RETURN

MASSTAKE:
  $T = "Mass Subtraction"
  $5 = "Start number:"
  $6 = "First number to subtract:"
  V = 0
  GOSUB DINBOX
  N = A - B
TAKEMORE:
  $5 = "Subtract another (0 to finish):"
  $6 = ""
  V = 0
  GOSUB INPBOX
  N = N - V
  IF V > 0 THEN GOTO TAKEMORE
  $5 = "Final result:" : B = N
  $6 = ""
  GOSUB NUMBOX
RETURN

ABOUT:
  $T = "About RiadCalc"
  $5 = "RiadCalc v2.1 – Text Mode Calculator"
  $6 = "Based on MikeOS Calculator"
  $7 = "Original by Joshua Beck"
  $8 = "Mod by Riad Achour (2025)"
  $9 = "Built with MB++ Library"
  GOSUB MESBOX
  $5 = "Learn OS dev at github.com/klange"
  $6 = "Email: mikeosdeveloper@gmail.com"
  $7 = "Try customizing this program!"
  $8 = "Runs on MikeOS, pure assembly!"
  $9 = "Stay curious and keep coding :)"
  GOSUB MESBOX
RETURN
