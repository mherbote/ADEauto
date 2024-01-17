#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=ADE_32_32_32.ico
#AutoIt3Wrapper_Outfile_x64=ADEauto.exe
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#Region ### include - Befehle
#include <GUIConstantsEx.au3>
#include <GuiEdit.au3>
#include <MsgBoxConstants.au3>

#include <inc Acrobat.au3>
#include <inc Dirliste.au3>
#include <inc Koda GUI.au3>
#EndRegion

#Region ### Globale Variablen
Global $PRGname      = "Adobe Acrobat Professional"
Global $sWinTitle    = "Dokumenteigenschaften"
Global $OpenPath     = ""
Global $Error1       = "Es muss ein Verzeichnis ausgewählt werden!"

Global $GUIChecked   = 1
Global $SeitenActual = 2
Global $hWnd
#EndRegion

; Programm Anfang
; ===============
	$OpenPath = IniRead("ADEauto.INI","Path","OpenPath","")

	_GUICtrlEdit_SetText($Pfad, $OpenPath)
; Acrobat starten, eventuell vorher benden
	CloseAcrobat($sWinTitle, $Button[7][0])
	$hWnd = OpenAcrobat($PRGname)
	;MsgBox($MB_SYSTEMMODAL, "", "$hWnd: " & $hWnd)
While 1
	Sleep(100)
WEnd

Func ADEautoClose()
	CloseAcrobat($sWinTitle, $Button[7][0])
	Exit
EndFunc
Func ADEautoMaximize()
EndFunc
Func ADEautoMinimize()
EndFunc
Func ADEautoRestore()
EndFunc

Func StartClick()
	Local $iAnzahl

	If (_GUICtrlEdit_GetText($Pfad) = "") Then
		MsgBox($MB_SYSTEMMODAL, "Error", $Error1)
		Return
	EndIf

	;MsgBox($MB_SYSTEMMODAL, "", "$SeitenActual: " & $SeitenActual)
	$iAnzahl = DirListe(_GUICtrlEdit_GetText($Pfad), $SeitenActual, $hWnd, 0, $DateiNr)
	GUICtrlSetData($DateiAnzahl, $iAnzahl)
	DirListe(_GUICtrlEdit_GetText($Pfad), $SeitenActual, $hWnd, 1, $DateiNr)
EndFunc
Func BeendenClick()
	ADEautoClose()
EndFunc

#Region ### Radiobutton auswählen
Func EinzelClick()
	$SeitenActual = 0
EndFunc
Func DoppelseiteClick()
	$SeitenActual = 1
EndFunc
Func DeckblattClick()
	$SeitenActual = 2
EndFunc
Func KeineClick()
	$SeitenActual = 3
EndFunc
#EndRegion

Func AuswahlClick()
	Local $P

	$P = FileSelectFolder("Verzeichnis der PDF-Datei(en) auswählen", "", 0, _GUICtrlEdit_GetText($Pfad))
	if ($P = "") Then
		_GUICtrlEdit_SetText( $Pfad, $P)
		MsgBox($MB_SYSTEMMODAL, "Error", $Error1)
	Else
		;MsgBox($MB_SYSTEMMODAL, "", $Pfad)
		_GUICtrlEdit_SetText( $Pfad, $P & "\")
		;MsgBox($MB_SYSTEMMODAL, "", $Pfad)
	EndIf
EndFunc
Func PfadChange()
EndFunc
