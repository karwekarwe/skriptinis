@echo off
SETLOCAL EnableDelayedExpansion


set "InputD=%~1"
if "%InputD%" =="" set "InputD=%USERPROFILE%"
set "InputE=%~2"
if "%InputE%" =="" set "InputE=.bat"

set "OutFile=%InputD%\naujas.txt"

set /a n=0

for /r "%InputD%" %%i in (*%InputE%) do (
    set a[!n!]=%%i
    set /a n+=1
)

@echo current date: %DATE% >"%OutFile%"
@echo current time: %TIME% >>"%OutFile%"


for /l %%i in (0,1,!n!-1) do (
    for %%j in ("!a[%%i]!") do (
        echo %%~nxj >> "%OutFile%"
        echo %%j >> "%OutFile%"
    )
)

start "" notepad.exe "%OutFile%"



pause
taskkill /IM notepad.exe /F
del "%OutFile%"
endlocal



rem 1.bat "C:\Users\domas\Desktop\test1" ".txt"
rem .txt

rem cd /d "C:\Users\domas\Desktop\skriptinis"
