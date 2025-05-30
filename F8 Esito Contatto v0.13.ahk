F8::
{
    Gui, PhoneStatus:Destroy
    Gui, PhoneStatus:New, +ToolWindow, Plugin Esito Contatto v0.13
    Gui, Font, s10
    Gui, Add, Text,, Seleziona un'opzione:

    percFile := A_ScriptDir . "\esiti.txt"
    if !FileExist(percFile) {
        MsgBox, 48, Errore, Il file "esiti.txt" non è stato trovato nella cartella dello script.
        return
    }

    ; Leggi righe dal file e crea i bottoni dinamicamente
    Loop, Read, % percFile
    {
        riga := A_LoopReadLine
        if (Trim(riga) = "") || !InStr(riga, A_Tab)
            continue

        visuale := StrSplit(riga, A_Tab)[1]
        testo := StrSplit(riga, A_Tab)[2]

        id := "B" . A_Index
        bottoni_%id% := testo
        Gui, Add, Button, gGestioneClick v%id% w250, %visuale%
    }

    ; Spazio vuoto prima dei due pulsanti extra
    Gui, Add, Text,, 
    Gui, Add, Button, gMostraInfo w120, ℹ️ INFO
    Gui, Add, Button, gApriFile w120 x+10, 📝 Modifica file

    Gui, Show,, Esito chiamata
    return
}

GestioneClick:
{
    Gui, Submit, NoHide
    testoDaInserire := bottoni_%A_GuiControl%
    Gui, PhoneStatus:Destroy

    FormatTime, dataOra,, dd/MM HH:mm
    SendInput %dataOra% %testoDaInserire%
    return
}

MostraInfo:
{
    MsgBox, 64, Istruzioni,
    (
    Questo programma consente di inserire rapidamente esiti chiamate.

    ▸ Premi F8 per aprire il pannello.
    ▸ Ogni bottone corrisponde a una riga del file `esiti.txt`.
    ▸ Il file deve essere nella stessa cartella dello script.
    ▸ Ogni riga è composta da:
       Testo bottone<TAB>Testo da incollare

    Esempio:
       Confermato	Confermato
    )
    return
}

ApriFile:
{
    Run, notepad.exe "%A_ScriptDir%\esiti.txt"
    return
}
