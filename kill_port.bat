@echo off
rem 不显示@后面的命令

color a
rem 定义字体显示颜色

Title windows解除端口占用程序------By:www.wxy97.com

rem MODE con: COLS=80 LINES=25
rem MODE语句为设定窗体的宽和高(设置MODE后,缓冲区也被改变,无法查看历史信息)

:start
rem 定义一个转跳标签

echo.
echo                         ----------------------------------
echo                         请选择要启动的服务，输入数字按回车
echo                         ----------------------------------
echo. 
echo                         1:查询全部端口信息
echo.
echo                         2:查询指定端口信息
echo.
echo                         3:查询PID对应进程
echo.
echo                         4:解除端口占用
echo.
echo                         9:退出
echo.

:enter
rem 选择操作
set /p choice=请选择：
if /i "%choice%"=="1" (
	goto findAllPort
) else if /i "%choice%"=="2" (
	goto findPort
) else if /i "%choice%"=="3" (
	goto findPid
) else if /i "%choice%"=="4" (
	goto killPort
) else if /i "%choice%"=="9" (
	goto end
) else (
	goto useless
)

rem 无效操作
:useless
	echo.
	echo 选择无效,请重新输入
	echo.
	
	set choice=
	rem 清空变量choice的值
	
	rem pause
	rem 暂停
	
	rem cls
	rem 清屏
	
	goto enter
	rem 转跳到"start"标签

rem 查询全部端口信息
:findAllPort
	cls
	echo.	
	netstat -aon
	echo.
	goto start

rem 查询指定端口信息
:findPort
	echo.
  set /p mport=请输入要查找的端口:
	cls
	echo 您查询的端口是:%mport%
	echo.
	echo   协议   本地地址          	外部地址        	状态           PID
	netstat -aon|findstr %mport%
	echo.
	goto start
	
rem 查询PID对应进程
:findPid
	echo.
  set /p mPid=请输入端口对应的PID(进程ID):
  cls
	echo 您查询的PID(进程ID)是:%mPid%
	echo.
	tasklist /fi "pid eq %mPid%"
	echo.
	goto start

rem 解除端口占用
:killPort
	echo.
	set /p mPid=请输入要终止的PID(进程ID):
	cls
	echo 您要解除的PID是(进程ID):%mPid%
	echo.
	taskkill /f /t /pid %mPid%
	echo.
	goto start

:end