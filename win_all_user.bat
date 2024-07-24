@echo off

setlocal enabledelayedexpansion

:: Create a temporary file to define the new permissions
echo \Registry\Machine\SAM\SAM [1 5 7 17] > "%temp%\perm.txt"
echo. >> "%temp%\perm.txt"

:: Apply the new permissions using regini
regini "%temp%\perm.txt"

:: Clean up the temporary file
del "%temp%\perm.txt"

echo \Registry\Machine\SAM\SAM\Domains [1 5 7 17] > "%temp%\perm.txt"
echo. >> "%temp%\perm.txt"

:: Apply the new permissions using regini
regini "%temp%\perm.txt"

:: Clean up the temporary file
del "%temp%\perm.txt"

echo \Registry\Machine\SAM\SAM\Domains\Account [1 5 7 17] > "%temp%\perm.txt"
echo. >> "%temp%\perm.txt"

:: Apply the new permissions using regini
regini "%temp%\perm.txt"

:: Clean up the temporary file
del "%temp%\perm.txt"

echo \Registry\Machine\SAM\SAM\Domains\Account\Users [1 5 7 17] > "%temp%\perm.txt"
echo. >> "%temp%\perm.txt"

:: Apply the new permissions using regini
regini "%temp%\perm.txt"

:: Clean up the temporary file
del "%temp%\perm.txt"

echo \Registry\Machine\SAM\SAM\Domains\Account\Users\Names [1 5 7 17] > "%temp%\perm.txt"
echo. >> "%temp%\perm.txt"

:: Apply the new permissions using regini
regini "%temp%\perm.txt"

:: Clean up the temporary file
del "%temp%\perm.txt"

echo Enumerating all administrator users, including hidden and shadow users...
echo.

:: List of administrator groups
set groups=Administrators

:: Loop through each group
for %%G in (%groups%) do (
    echo Members of the %%G group:
    echo -------------------------
    :: Get all members of the group
    net localgroup "%%G"
    echo.
)

:: Check for hidden users
echo Checking for hidden users...
set count=0
for /f "tokens=*" %%u in ('reg query "HKLM\SAM\SAM\Domains\Account\Users\Names"') do (
    set /a count+=1
    if !count! gtr 2 (
        echo %%u
    )
)

echo.
echo Enumeration complete.
pause
