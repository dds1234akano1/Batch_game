@echo off
title batch game by no1
color 2
setlocal EnableDelayedExpansion

:: Initialize variables
set playerHP=100
set playerAtk=20
set wildHP=50
set wildAtk=15
set playerName=Trainer
set pokemonName=Charmander

goto mainmenu

:mainmenu
cls
echo ==================
echo  Simple Pokémon Game
echo ==================
echo 1) Start New Game
echo 2) Load Game
echo 3) Save Game
echo 4) Credits
echo 5) Exit
choice /c 12345 /m "Choose an option:"
if %errorlevel% equ 1 goto startnewgame
if %errorlevel% equ 2 goto loadgame
if %errorlevel% equ 3 goto savegame
if %errorlevel% equ 4 goto credits
if %errorlevel% equ 5 exit

:startnewgame
cls
echo What is your name, Trainer?
set /p playerName=Name:
echo Which Pokémon do you choose? (Charmander, Bulbasaur, Squirtle)
set /p pokemonName=Pokémon:
goto continue

:savegame
cls
echo Enter a name for your save file:
set /p saveFileName=Save Name:
(
echo %playerName%
echo %pokemonName%
echo %playerHP%
echo %playerAtk%
echo %wildHP%
echo %wildAtk%
)>%saveFileName%.savefile
echo Game saved!
pause
goto mainmenu

:loadgame
cls
echo Enter the name of your save file:
set /p loadFileName=Save File Name:
if not exist "%loadFileName%.savefile" (
    echo Save file does not exist!
    pause
    goto mainmenu
)
<%loadFileName%.savefile (
    set /p playerName=
    set /p pokemonName=
    set /p playerHP=
    set /p playerAtk=
    set /p wildHP=
    set /p wildAtk=
)
echo Game loaded!
pause
goto continue

:continue
cls
echo What would you like to do?
echo 1) Explore
echo 2) Check Pokémon
echo 3) Save Game
echo 4) Exit
choice /c 1234 /m "Choose an option:"
if %errorlevel% equ 1 goto explore
if %errorlevel% equ 2 goto checkpokemon
if %errorlevel% equ 3 goto savegame
if %errorlevel% equ 4 goto mainmenu

:explore
cls
echo You encountered a wild Pokémon!
echo Wild Pokémon HP: %wildHP%
echo.
echo 1) Attack
echo 2) Run
choice /c 12 /m "Choose an option:"
if %errorlevel% equ 1 goto battle
if %errorlevel% equ 2 goto run

:battle
cls
echo You attack the wild Pokémon!
set /a wildHP=wildHP-playerAtk
if %wildHP% leq 0 goto victory
echo Wild Pokémon HP: %wildHP%
echo The wild Pokémon attacks you!
set /a playerHP=playerHP-wildAtk
if %playerHP% leq 0 goto defeat
echo Your HP: %playerHP%
pause
goto battle

:victory
cls
echo You defeated the wild Pokémon!
set wildHP=50
pause
goto continue

:defeat
cls
echo You were defeated by the wild Pokémon...
set playerHP=100
set wildHP=50
pause
goto mainmenu

:run
cls
echo You ran away safely!
pause
goto continue

:checkpokemon
cls
echo Trainer: %playerName%
echo Pokémon: %pokemonName%
echo HP: %playerHP%
echo Attack: %playerAtk%
pause
goto continue

:credits
cls
echo ==================
echo       CREDITS
echo ==================
echo Developed by: [no1/dds1234]
echo Inspired by: Pokémon series by Game Freak
echo 
echo.
echo Press any key to return to the main menu...
pause
goto mainmenu