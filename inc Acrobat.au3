Func CloseAcrobat($sWinTitle, $Button)
	Local $hWnd, $hControl
; Ist Dialog "Dokumenteigenschaften" offen, dann Abbrechen
	$hWnd = WinGetHandle($sWinTitle)
	If (WinActivate($hWnd) <>  0) Then
		$hControl = ControlGetHandle($hWnd,"", $Button)
		If IsHWnd($hControl) Then
			ControlClick($hWnd, "", "Abbrechen")
		EndIf
	EndIf
; Ist Adobe Acrobat offen, dann schließen
	if ProcessExists("Acrobat.exe") then
		ProcessClose("Acrobat.exe")
		Sleep(1000)
	EndIf
EndFunc

Func OpenAcrobat($PRGname)
	Local $hWin
; Acrobat starten
	if ProcessExists("Acrobat.exe") then
; Acrobat ist gestartet
		$hWnd = WinGetHandle($PRGname)
	else
		;MsgBox($MB_SYSTEMMODAL,"","nein")
		Run("C:\Programme\Adobe\Acrobat 8.0\Acrobat\Acrobat.exe")
		$hWnd = WinWait("Adobe Acrobat Professional")
	endif

	;MsgBox($MB_SYSTEMMODAL,"",$hWnd)
	WinActivate("Adobe Acrobat Professional")
	Return $hWnd
EndFunc