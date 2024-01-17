#include <MsgBoxConstants.au3>

#include <inc DateiAusfuehren.au3>

Func DirListe($OpenPath, $SeitenActual, $hWnd, $wahl, $DateiNr)
	Local $hSearch, $sFileName, $iAnzahl = 0

; Assign a Local variable the search handle of all files in the current directory.
	$hSearch = FileFindFirstFile($OpenPath & "*.PDF")

; Check if the search was successful, if not display a message and return False.
	if $hSearch = -1 then
        MsgBox($MB_SYSTEMMODAL, "", "Error: No files/directories matched the search pattern.")
        Return False
    EndIf

; Assign a Local variable the empty string which will contain the files names found.
	Local $sFileName = ""

    While 1
		$sFileName = FileFindNextFile($hSearch)
; If there is no more file matching the search.
		If @error Then ExitLoop

; ReadOnly of the file name reset
		FileSetAttrib($OpenPath & $sFileName,"-R")
		;MsgBox($MB_SYSTEMMODAL, "", $sFileName)
; Use File name
		;MsgBox($MB_SYSTEMMODAL, "", "$hWnd: " & $hWnd)
		;MsgBox($MB_SYSTEMMODAL, "", "$sFileName: " & $sFileName)
		$iAnzahl = $iAnzahl + 1
		Switch $wahl
			Case 0
			Case 1
				GUICtrlSetData($DateiNr, $iAnzahl)
				DateiAusfuehren($OpenPath, $sFileName, $SeitenActual, $hWnd)
		EndSwitch
	WEnd

; Close the search handle.
	FileClose($hSearch)
	Return $iAnzahl
EndFunc
