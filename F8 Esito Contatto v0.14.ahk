F8::
{
    percFile := A_ScriptDir . "\esiti.txt"  ; <-- file fisso nella root C:\


    ; Se il file non esiste, crealo con i valori predefiniti
    if !FileExist(percFile)
        {
            FileAppend,
        (
Confermato	Confermato
Non Risponde	Non Risponde
        ), %percFile%
        }

    Gui, PhoneStatus:Destroy
    Gui, PhoneStatus:New, +ToolWindow, F8 Esito Contatto
    Gui, Font, s9
    Gui, Add, Text,, Seleziona un'opzione:

    ; Leggi righe dal file e crea i bottoni dinamicamente
    Loop, Read, %percFile%
    {
        riga := A_LoopReadLine
        if (Trim(riga) = "") || !InStr(riga, A_Tab)
            continue

        visuale := StrSplit(riga, A_Tab).1
        testo := StrSplit(riga, A_Tab).2

        id := "B" . A_Index
        bottoni_%id% := testo
        Gui, Add, Button, gGestioneClick v%id% w310, %visuale%
    }

    ; Spazio prima dei due bottoni finali
    Gui, Add, Text,, v0.14
    Gui, Add, Button, gMostraInfo w100, ℹ️ INFO
    Gui, Add, Button, gApriFile w100 x+5, 📝 Modifica file
    Gui, Add, Button, gControllaAggiornamenti w100 x+5, 🌐 Aggiornamenti

    Gui, Show,, F8 Esito Contatto
    return
}

GestioneClick:
{
    Gui, Submit, NoHide
    testoDaInserire := bottoni_%A_GuiControl%
    Gui, PhoneStatus:Destroy

    FormatTime, dataOra,, dd/MM/yy HH:mm
    SendInput %dataOra% %testoDaInserire%
    return
}

MostraInfo:
{
    MsgBox, 64, Guida,
    (
    Questo programma consente di inserire rapidamente i rapporti delle chiamate.

    ▸ Premi F8 per aprire il pannello.
    ▸ Ogni bottone corrisponde a una riga del file `esiti.txt`.
    ▸ Se il file non esiste, viene generato automaticamente.
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

ControllaAggiornamenti:
{
    Run, https://example.com/
    return
}