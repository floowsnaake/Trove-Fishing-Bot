/*

#Simple Fisher Trove

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
