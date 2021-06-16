;
; VRoid PNG mass export
; Automatically exports PNG images in sequence in VRoid Studio Camera/Exporter tab.
; Images can then be used to create high quality videos.
;
; To use:
;  - Load VRoid Studio and configure model as you like.
;  - Go to Camera/Exports tab and configure export settings as you like.
;  - Go to the Pose & Animation page.
;  - Click the Stop button to ensure the animation isn't playing.
;  - Click the Capture button and select folder to save images to.
;  - Press ENTER key when prompted to begin.
;

frames := 60 ; total number of frames to record (60fps = 60 frames for 1 second of video)
click_delay := 20 ; delay between clicks of Play/Stop button
filesave_delay := 2000 ; delay to ensure VRoid has qdequate time to save before continuing

counter := 1

; Find VRoid window
WinWait, ahk_exe VRoidStudio.exe, , 3
if ErrorLevel
{
  MsgBox, VRoid Studio window not found.
  return
}
else
  MsgBox, VRoid Studio window. Press Capture button in Camera/Exporter to get started.

WinWait, Capture ahk_class #32770
  MsgBox, Press OK. Then locate the folder for exported images and press Save to begin.

n := SubStr("00000" counter, -4)
SendInput %n%
WinWaitClose

MsgBox Export process will now begin. Press ENTER.

; Begin loop
Loop %frames%
{
  counter += 1
  CoordMode, Mouse, Screen
  x := 1565
  y := 1025
  MouseMove, %x%, %Y%
  Sleep, %filesave_delay%
  ; Click Play/Stop button twice to advance frame
  Click %x% %Y%
  Sleep, %click_delay%
  Click %x% %Y%
  ; Click Export button
  x := 1450
  y := 1025
  MouseMove, %x%, %Y%
  Sleep, 500 ; wait just a moment before proceeding to export
  Click %x% %Y%
  ; Wait for save dialog to appear
  WinWait, Capture ahk_class #32770
  if ErrorLevel
  {
	  MsgBox, A problem has occurred.
    return
  }
  else
    ; Enter padded counter and send input
    n := SubStr("00000" counter, -4)
    SendInput %n%
    Sleep, 500
    SendInput {ENTER}

  WinWaitClose
}

; Click Stop button
x := 1565
y := 1025
Click %x% %Y%

MsgBox Export complete.