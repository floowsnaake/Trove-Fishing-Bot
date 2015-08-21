/*

#Simple Fisher Trove

This is my Trove Fishing Bot 100% me made :p
 
Note that you will need to edit this your self:

Adress = 0x106345330 ; Enter your Dynamic/static Pointer Address here. no offsets is needed only the address for when there is a fish on your hook and the value turns int to 1.

Baits = 96 ; Enter the amount of Baits you have here, how many baits you have in the inventory when the bot starts.
§:: ; Enter the Hotkey you want to use to start the Bot.

also note that dropping boots isn't something i use so i don't have it in the code, you could make a simple image search/pixel search for it to drag out all the boots you fish up if you want.

I'll show you guys few tips to NEVER (just unlucky guys get banned) get banned using fishing bot.
- Never use fishing bot at the HUB, it is stupid.
- Do it far away from the spawn point, somewhere at no one will see you.
- Enable the option ''Appear Offline'' at the Settings/Social that way no one can follow you.
- Don't trade high amounts of Glim at the trade post, drop it or do in small parts.
- Don't say ''Selling 500k of Glim'' at the chat, it's very suspicious.
- Try to use fishing bot at a private club world (make your self a club), its better to transfer between accounts too.

thanks to : Pardieiro & krazyshank for the Anti ban tips.
Also HUGE thank you to Geekdude,Tidbit and Xtra for helping me/learning me how to read pointers with Autohtokey and how to make my code faser,look nicer and easier to read!

Watch this Youtube Video on how to find Static/Base Pointers in the game to use for the fishing bot if you don't want to use Dynamic Pointers:

https://www.youtube.com/watch?v=FYzix68bxFA

Also note that more information can be found on my Github or MPGH Page :)
Github: https://github.com/floowsnaake/Trove-Fishing-Bot
MPGH: http://www.mpgh.net/forum/showthread.php?t=1010460

How to use the code/Simple Fisher Trove:
1) Download Autohotkey (Download Link)
2) Install Autohotkey 64 or 32 Bits.
3) Copy the Code.
4) Paste it in to notepad or any other text editor you use
5) Save it as Simple Fisher Trove.ahk
6) Dubble click at "Simple Fisher Trove.ahk"
7) Now its running, you should see a small icon with a "H" on it in the corner of the Taskbar/Startbar.

more information about how to make a script and how to downland Autohotkey can be found in this Link (Help Link)

If you need any help with the installation of Autohtokey or anything else don't be afraid to send me a Personal message

Simple Fisher Trove
Floow_Snake
FloowSnaake
SnowFlake
Snow_Flake
Autohtokey
AHK
Trove
Fishing Bot
tnx to Xtra
*/

IF NOT A_IsAdmin
{
   Run *RunAs "%A_ScriptFullPath%"
   ExitApp
}

#SingleInstance force

ProcessName := "trove.exe"
hwnd := MemoryOpenFromName(ProcessName)

Adress = 0x106345330 ; Enter your Pointer Adress here
Baits = 96 ; Enter the amount of Baits you have here.

FishCatched = 0

Gui, Add, Text,,Adress:
Gui, Add, Text,,On Hook:
Gui, Add, Text,,Catches:
Gui, Add, Text,,Baits Left:
Gui, Add, Text,,Droping Boots:
Gui, Add, Edit, ReadOnly ym,%Adress%
Gui, Add, Edit, ReadOnly w30 vOn_Hook_GUI,--
Gui, Add, Edit, ReadOnly w30 vFishCatched_GUI,--
Gui, Add, Edit, ReadOnly w30 vBaits_GUI,--
Gui, Show, ,Simple Fisher

GuiControl,, FishCatched_GUI, %FishCatched%
GuiControl,, Baits_GUI, %Baits%
return

§:: ; Enter the Hotkey you want to use to start the Bot
SoundBeep
Loop
{
GuiControl,, On_Hook_GUI, % Adress2 := MemoryReadPointer(hwnd,Adress, "int")

IFEqual, Adress2, 1,{
ControlSend, , {f Down}, ahk_exe trove.exe
Sleep, 80
ControlSend, , {f up}, ahk_exe trove.exe

GuiControl,, FishCatched_GUI, % ++FishCatched
GuiControl,, Baits_GUI, % --Baits

Sleep, 3000
ControlSend, , {f Down}, ahk_exe trove.exe
Sleep, 80
ControlSend, , {f up}, ahk_exe trove.exe
}
}
return

MemoryOpenFromName(Name)
{
    Process, Exist, %Name%
    Return DllCall("OpenProcess", "Uint", 0x1F0FFF, "int", 0, "int", PID := ErrorLevel)
}

MemoryReadPointer(hwnd, base, datatype="int", length=4, offsets=0, offset_1=0, offset_2=0, offset_3=0, offset_4=0, offset_5=0, offset_6=0, offset_7=0, offset_8=0, offset_9=0)
{
	B_FormatInteger := A_FormatInteger 
	Loop, %offsets%
	{
		baseresult := MemoryRead(hwnd,base)
		Offset := Offset_%A_Index%
		SetFormat, integer, h
		base := baseresult + Offset
		SetFormat, integer, d
	}
	SetFormat, Integer, %B_FormatInteger%
	return MemoryRead(hwnd,base,datatyp,length)
}

MemoryRead(hwnd, address, datatype="int", length=4, offset=0)
{
	VarSetCapacity(readvalue,length, 0)
	DllCall("ReadProcessMemory","Uint",hwnd,"Uint",address+offset,"Str",readvalue,"Uint",length,"Uint *",0)
	finalvalue := NumGet(readvalue,0,datatype)
	return finalvalue
}
