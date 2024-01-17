; $iButton = $Button[$iButton][0]

#include <GUIConstantsEx.au3>
#include <GuiComboBox.au3>
#include <GuiComboBoxEx.au3>
#include <GuiEdit.au3>
#include <MsgBoxConstants.au3>

Global $ComboBox[][] = [["[CLASS:ComboBox;INSTANCE:1]","Nur Seite"              ], _
						["[CLASS:ComboBox;INSTANCE:2]","Zwei Seiten (Deckblatt)"], _
                        ["[CLASS:ComboBox;INSTANCE:3]","Fenstergröße"           ], _
						["[CLASS:ComboBox;INSTANCE:4]","Dateiname"              ] _
					   ]

Global $Seiten[][]   = [["Einzelne Seite",1],["Zwei Seiten (Doppelseite)",3],["Zwei Seiten (Deckblatt)",5]]
;                         0                    1                               2

Func _SetComboBoxText($hWin, $CB, $iComboBox, $wahl)
	Local $ComboBox3 = "[CLASS:Edit;INSTANCE:1]"
	Local $NL        = Chr(13) & Chr(10)
	Local $sHelp, $hControl

; ComboBox - Text einstellen
	$hControl = ControlGetHandle($hWin, "", $ComboBox[$CB][0])
	;MsgBox($MB_SYSTEMMODAL,"", "$CB: " & $CB & "$iComboBox: " & $iComboBox & "CurSel: " & _GUICtrlComboBox_GetCurSel($hControl))
	If ($CB = 1) Then
		_GUICtrlComboBoxEx_SetCurSel($hControl, $Seiten[$iComboBox][1])
	Else
		_GUICtrlComboBoxEx_SetCurSel($hControl, $iComboBox)
	EndIf
	;MsgBox($MB_SYSTEMMODAL,"","CurSel: " & _GUICtrlComboBox_GetCurSel($hControl))

; Bei ComboBox mit Textbox, dann Textbox einstellen
	If $wahl = 2 then
		$hControl = ControlGetHandle($hWin, "", $ComboBox3)
		_GUICtrlEdit_SetText($hControl, $ComboBox[$CB][1])
	EndIf
	Return
EndFunc	;===> _SetComboBoxText
