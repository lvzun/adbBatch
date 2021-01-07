@echo off
setlocal enabledelayedexpansion
REM windows adb 脚本批量执行脚本，简易版
REM android 批量命令行执行程序，需要在系统PATH路径中设置好adb命令。

REM set option=reboot,install,start,stop,installAndStart,push,pull
REM echo option 可用参数 !option!


echo 参数：%1 %2 %3 %4 %5 %6 %7 %8 %9
if "%1" == "" goto help
if "%1" == "help" goto help

if not exist "%1" (
    echo %1%不存在
    goto end
)
if "%2" == "" goto help
if "%2" == "help" goto help

REM if "x!option:%2%=!"=="x!option!" (
REM    echo option 参数错误
REM    goto end
REM )

if "%2" == "installAndStart" (
    goto installAndStart
) else if "%2" == "reboot" (
    goto reboot
) else if "%2" == "install" (
    goto install
) else if "%2" == "start" (
    goto start
) else if "%2" == "stop" (
    goto stop
) else if "%2" == "restart" (
      goto restart
) else if "%2" == "uninstall" (
      goto uninstall
) else if "%2" == "push" (
    goto push
) else if "%2" == "pull" (
    goto pull
) else (
    goto all
)

@echo script start in a second
timeout /T 1 /NOBREAK >nul
@echo disconnect all
adb disconnect

:reboot
for /f %%i in (%1) do (
	set ip=%%i
	@echo start connect !ip!
	adb connect !ip!
	adb reboot
	adb disconnect
    timeout /T 1 /NOBREAK >nul
)
goto end


:installAndStart
for /f %%i in (%1) do (
	set ip=%%i
	@echo start connect !ip!
	adb connect !ip!
	adb install -r %3
	adb shell am start -n %4
	adb disconnect
    timeout /T 1 /NOBREAK >nul
)
goto end


:install
for /f %%i in (%1) do (
	set ip=%%i
	@echo start connect !ip!
	adb connect !ip!
	adb install -r %3
	adb disconnect
    timeout /T 1 /NOBREAK >nul
)
goto end

:uninstall
for /f %%i in (%1) do (
	set ip=%%i
	@echo start connect !ip!
	adb connect !ip!
	adb uninstall  %3
	adb disconnect
    timeout /T 1 /NOBREAK >nul
)
goto end


:start
for /f %%i in (%1) do (
	set ip=%%i
	@echo start connect !ip!
	adb connect !ip!
	adb shell am start -n %3
	adb disconnect
    timeout /T 1 /NOBREAK >nul
)
goto end

:restart
for /f %%i in (%1) do (
	set ip=%%i
	@echo start connect !ip!
	adb connect !ip!
	adb shell am force-stop %3
	timeout /T 1 /NOBREAK >nul
	adb shell am start -n %4
	adb disconnect
    timeout /T 1 /NOBREAK >nul
)
goto end


:stop
for /f %%i in (%1%) do (
	set ip=%%i
	@echo start connect !ip!
	adb connect !ip!
	adb shell am force-stop %3
	adb disconnect
    timeout /T 1 /NOBREAK >nul
)
goto end

:push
for /f %%i in (%1) do (
	set ip=%%i
	@echo start connect !ip!
	adb connect !ip!
	adb push %3 %4
	adb disconnect
    timeout /T 1 /NOBREAK >nul
)
goto end


:pull
for /f %%i in (%1) do (
    set ip=%%i
    set isDir=0
    set dest=%4
    dir/ad "%4%" >nul 2>nul && set isDir=1
    if "!isDir!"=="1" (
        set dest=%4\!ip!\
        mkdir !dest!
    ) else (
        set dest=%4_!ip!
    )
	@echo start connect !ip!
	adb connect !ip!
	adb pull %3 !dest!
	adb disconnect
    timeout /T 1 /NOBREAK >nul
)
goto end

:all
for /f %%i in (%1) do (
    set ip=%%i
	@echo start connect !ip!
	adb connect !ip!
	adb %2 %3 %4 %5 %6 %7 %8 %9
	adb disconnect
    timeout /T 1 /NOBREAK >nul
)
goto end


:help
@echo andShell [IP] [option] [params...]
@echo   IP 虚拟机IP文件，一行一个IP
@echo   option
@echo       reboot 重启
@echo       install 安装
@echo       start 启动
@echo       stop 停止
@echo       installAndStart 安装并启动
@echo   params:
@echo       reboot 无参数
@echo       install 参数：安装文件名
@echo       start 参数：包名/启动类名
@echo       restart 参数1：包名 参数2：包名/启动类名
@echo       stop 参数：包名
@echo       installAndStart 参数1：安装文件名，参数2：包名/启动类名
@echo       pull 参数1：虚拟机文件位置，参数2：本机保存位置，如果是文件夹会新建一个虚拟IP的子文件存放，如是文件后面会跟_IP
@echo       push 参数1：本机文件位置，参数2：虚拟机文件位置


:end
@echo 结束

