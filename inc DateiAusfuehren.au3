#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>
#include <inc SetComboBoxText.au3>
#include <inc IsChecked.au3>

Global $PRGname      = "Adobe Acrobat Professional"

Global $Button[][]   = [["[CLASS:Button;INSTANCE:1]",""], _
                        ["[CLASS:Button;INSTANCE:2]",""], _
						["[CLASS:Button;INSTANCE:3]",""], _
					    ["[CLASS:Button;INSTANCE:6]",""], _
						["[CLASS:Button;INSTANCE:7]",""], _
						["[CLASS:Button;INSTANCE:8]",""], _
                        ["[CLASS:Button;INSTANCE:11]","OK"], _
						["[CLASS:Button;INSTANCE:12]","Abbrechen"] _
                       ]

Func DateiAusfuehren($OpenPath, $Parameter, $SeitenActual, $hWnd)
	Local $sWinTitle    = "Dokumenteigenschaften"
	Local $CtrlO        = "^o"
	Local $CtrlD        = "^d"
	Local $NL           = Chr(13) & Chr(10)

	Local $Help, $hWin

	;MsgBox($MB_SYSTEMMODAL, "", "$Parameter   : " & $Parameter    & $NL & _
	;                            "$SeitenActual: " & $SeitenActual & $NL & _
	;                            "$hWnd        : " & $hWnd)
	;Return
	WinActivate($PRGname)

; Datei öffnen
	Send($CtrlO)
	Send($OpenPath & $Parameter)
	Send("{ENTER}")

; Dialog "Dokumenteigenschaften" öffnen
	Send($CtrlD)
	$hWin = 0
	While $hWin = 0
		$hWin = WinGetHandle($sWinTitle)
		Sleep(100)
	WEnd
	WinActivate($hWin)
	Sleep(100)

	_SetComboBoxText($hWin, 0, 0, 1)									;"Nur Seite"
	If $SeitenActual <> 3 Then
		_SetComboBoxText($hWin, 1, $SeitenActual, 1)
		Send("!t!t")
		Sleep(10)
		;MsgBox($MB_SYSTEMMODAL, "", "$hWin       : " & $hWin   & $NL & _
		;							"Seiten      : " & $Seiten & $NL & _
		;							"SeitenActual: " & $SeitenActual & $NL & _
		;							"Ergebnis    : " & $Seiten[$SeitenActual][1] & $NL & _
		;							"$ComboBox   : " & $ComboBox _
		;	  )
	EndIf
	_SetComboBoxText($hWin, 2, 2, 2)									;"Fenstergröße"
	_SetComboBoxText($hWin, 3, 1, 1)									;"..."
	_SetComboBoxText($hWin, 3, 0, 1)									;"Dateiname"

	If (    _IsChecked($hWin, $Button, 0)) Then Send("!t")				;Fenster an erste Seite anpassen
	Sleep(10)
	If (    _IsChecked($hWin, $Button, 1)) Then Send("!z")				;Fenster auf Bildschirm zentrieren
	Sleep(10)
	If (    _IsChecked($hWin, $Button, 2)) Then Send("!V")				;Im Vollbildmodus öffnen
	Sleep(10)

	if (Not _IsChecked($hWin, $Button, 3)) Then Send("!M")				;Menüleiste ausblenden
	Sleep(10)
	if (Not _IsChecked($hWin, $Button, 4)) Then Send("!W")				;Werkzeugleisten ausblenden
	Sleep(10)
	if (Not _IsChecked($hWin, $Button, 5)) Then Send("!F")				;Fenstersteuerelemente ausblenden
	Sleep(10)

;	Button "OK" zum Beenden der Eigenschaften
	$hControl = ControlGetHandle($hWin,"", $Button[6][0])
    If Not IsHWnd($hControl) Then
		MsgBox($MB_SYSTEMMODAL, "", "Error at 'OK' (" & $Button[6][0] & ")!")
        Return False
	Else
		ControlClick($hWin, "", "OK")
		Sleep(1000)
    EndIf

;	Speichern der Datei und Datei schließen
	$Help = _WinAPI_GetWindowText($hWnd)
	Send("^S")
	Send("!s")
	Send("!j")
	;MsgBox($MB_SYSTEMMODAL, "", "$Help   : " & $Help    & $NL & _
	;                            "$PRGname: " & $PRGname)
	While ($Help <> $PRGname)
		Send("^w")
		$Help = _WinAPI_GetWindowText($hWnd)
		Sleep(100)
	WEnd

	Return
EndFunc	;===> DateiAusfuehren
