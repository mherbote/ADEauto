#include <MsgBoxConstants.au3>

Func _IsChecked($hWin, $Button, $iButton)
    $hControl = ControlGetHandle($hWin,"", $Button[$iButton][0])
    If Not IsHWnd($hControl) Then
		MsgBox($MB_SYSTEMMODAL, "", "Error at _IsChecked (" & $Button[$iButton][0] & ")!")
        Return False
    EndIf

	Return ControlCommand($hWin,"",$hControl,"IsChecked","")
EndFunc	;===> _IsChecked
