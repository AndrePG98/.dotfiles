#Requires AutoHotkey v2.0.2
#SingleInstance Force

Komorebic(cmd) {
    RunWait(format("komorebic.exe {}", cmd), , "Hide")
}

#q::Komorebic("close")
#m::Komorebic("minimize")

; Focus windows
^Left::Komorebic("focus left")
^Down::Komorebic("focus down")
^Up::Komorebic("focus up")
^Right::Komorebic("focus right")

; !+[::Komorebic("cycle-focus previous")
; !+]::Komorebic("cycle-focus next")

; Move windows
#Left::Komorebic("move left")
#Down::Komorebic("move down")
#Up::Komorebic("move up")
#Right::Komorebic("move right")

; ; Stack windows
; !Left::Komorebic("stack left")
; !Down::Komorebic("stack down")
; !Up::Komorebic("stack up")
; !Right::Komorebic("stack right")
; !;::Komorebic("unstack")
; ![::Komorebic("cycle-stack previous")
; !]::Komorebic("cycle-stack next")

; Resize
^+Right::Komorebic("resize-axis horizontal increase")
^+Left::Komorebic("resize-axis horizontal decrease")
^+Up::Komorebic("resize-axis vertical increase")
^+Down::Komorebic("resize-axis vertical decrease")

; Manipulate windows
^t::Komorebic("toggle-float")
^f::Komorebic("toggle-monocle")

; ; Window manager options
; !+r::Komorebic("retile")
; !p::Komorebic("toggle-pause")

; ; Layouts
; !x::Komorebic("flip-layout horizontal")
; !y::Komorebic("flip-layout vertical")

