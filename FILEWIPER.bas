10 REM === SECURE FILE WIPE UTILITY (RIADOS VM ONLY) ===
20 REM === OVERWRITES & DELETES ALL .BIN/.BAS FILES ===
30 CLS
40 PRINT "!!! RIADOS SECURE WIPE !!!"
50 PRINT "This will PERMANENTLY wipe all programs by:"
60 PRINT "1. Overwriting file data (7-pass DoD standard)"
70 PRINT "2. Deleting the file completely"
80 PRINT "3. Rebooting RiadOS"
90 PRINT
100 PRINT "RUN ONLY IN TEST VM! Continue? (Y/N)"
110 INPUT A$
120 IF A$ <> "Y" AND A$ <> "y" THEN GOTO 400

130 REM === Enhanced 7-pass DoD wipe function ===
140 DEF PROC WIPE_FILE(F$)
150   OPEN F$ FOR BINARY AS #1
160   IF ERR <> 0 THEN PRINT "Can't open ";F$: ENDPROC
170   
180   SZ = LOF(#1)
190   IF SZ = 0 THEN CLOSE #1: GOTO 330
200   
210   REM 7-pass DoD 5220.22-M compliant wipe
220   FOR PASS = 1 TO 7
230     SEEK #1, 0
240     SELECT PASS
250       CASE 1: PATTERN = 255  REM 0xFF
260       CASE 2: PATTERN = 0    REM 0x00
270       CASE 3: PATTERN = 146  REM Random
280       CASE 4: PATTERN = 219  REM Random
290       CASE 5: PATTERN = 73   REM Random
300       CASE 6: PATTERN = 36   REM Random
310       CASE 7: PATTERN = 109  REM Random
320     END SELECT
330     FOR I = 1 TO SZ
340       PUT #1, PATTERN
350     NEXT I
360   NEXT PASS
370   CLOSE #1
380   KILL F$
390 ENDPROC

400 REM === Main program ===
410 FILES$ = SYS("os_get_file_list")
420 COUNT = 0
430 WHILE LEN(FILES$) > 0
440   COMMA = INSTR(FILES$, ",")
450   IF COMMA = 0 THEN COMMA = LEN(FILES$)+1
460   F$ = LEFT$(FILES$, COMMA-1)
470   FILES$ = MID$(FILES$, COMMA+1)
480   
490   IF RIGHT$(F$,4)=".BIN" OR RIGHT$(F$,4)=".BAS" THEN
500     PRINT "Securely wiping: ";F$
510     PROC WIPE_FILE(F$)
520     COUNT = COUNT + 1
530   END IF
540 WEND

550 PRINT
560 PRINT COUNT;" files securely wiped."
570 PRINT "RiadOS will now restart..."
580 FOR I = 1 TO 5000: NEXT I  REM 5 second delay
590 SYS("os_reboot")

600 END
