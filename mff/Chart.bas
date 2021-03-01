﻿'################################################################################
'#  Chart.bi                                                                    #
'#  This file is part of MyFBFramework                                          #
'#  Authors: Xusinboy Bekchanov (2019-2021)                                     #
'#  not finished, in progress                                                   #
'################################################################################

#include once "Chart.bi"

Namespace My.Sys.Forms
	Function Chart.ReadProperty(ByRef PropertyName As String) As Any Ptr
		FTempString = LCase(PropertyName)
		Select Case FTempString
		Case Else: Return Base.ReadProperty(PropertyName)
		End Select
		Return 0
	End Function
	
	Function Chart.WriteProperty(ByRef PropertyName As String, Value As Any Ptr) As Boolean
		If Value = 0 Then
			Select Case LCase(PropertyName)
			Case Else: Return Base.WriteProperty(PropertyName, Value)
			End Select
		Else
			Select Case LCase(PropertyName)
			Case Else: Return Base.WriteProperty(PropertyName, Value)
			End Select
		End If
		Return True
	End Function
	
	Public Sub Chart.GetCenterPie(X As Single, Y As Single)
		X = m_CenterCircle.x
		Y = m_CenterCircle.Y
	End Sub
	
	Public Property Chart.Count() As Long
		Count = ItemsCount
	End Property
	
	Public Property Chart.Special(Index As Long, Value As Boolean)
		m_Item(Index).Special = Value
		Me.Refresh
	End Property
	
	Public Property Chart.Special(Index As Long) As Boolean
		Return m_Item(Index).Special
	End Property
	
	Public Property Chart.ItemColor(Index As Long, Value As OLE_COLOR)
		m_Item(Index).ItemColor = Value
		Me.Refresh
	End Property
	
	Public Property Chart.ItemColor(Index As Long) As OLE_COLOR
		Return m_Item(Index).ItemColor
	End Property
	
	Public Sub Chart.Clear()
		Dim i As Long
		For i = 0 To ItemsCount - 1
			#ifndef __USE_GTK__
				GdipDeletePath m_Item(i).hPath
			#endif
		Next
		ItemsCount = 0
		ReDim Preserve m_Item(0)
		Me.Refresh
	End Sub
	
	Public Sub Chart.AddItem(ByRef ItemName As WString, Value As Single, Item_Color As Long, bSpecial As Boolean = False)
		ReDim Preserve m_Item(ItemsCount)
		With m_Item(ItemsCount)
			.ItemName = ItemName
			.ItemColor = Item_Color
			.Value = Value
			.Special = bSpecial
		End With
		ItemsCount = ItemsCount + 1
	End Sub
	
	Public Property Chart.Title() ByRef As WString
		Return *m_Title.vptr
	End Property
	
	Public Property Chart.Title(ByRef New_Value As WString)
		m_Title = New_Value
		Refresh
	End Property
	
	Public Property Chart.TitleFont() As My.Sys.Drawing.Font
		Return m_TitleFont
	End Property
	
	Public Property Chart.TitleFont(ByRef New_Value As My.Sys.Drawing.Font)
		m_TitleFont = New_Value
		Refresh
	End Property
	
	Public Property Chart.TitleForeColor() As OLE_COLOR
		TitleForeColor = m_TitleForeColor
	End Property
	
	Public Property Chart.TitleForeColor(ByVal New_Value As OLE_COLOR)
		m_TitleForeColor = New_Value
		Refresh
	End Property
	
	Public Property Chart.BackColorOpacity() As Long
		BackColorOpacity = m_BackColorOpacity
	End Property
	
	Public Property Chart.BackColorOpacity(ByVal New_Value As Long)
		m_BackColorOpacity = New_Value
		Refresh
	End Property
	
	Public Property Chart.FillOpacity() As Long
		FillOpacity = m_FillOpacity
	End Property
	
	Public Property Chart.FillOpacity(ByVal New_Value As Long)
		m_FillOpacity = New_Value
		Refresh
	End Property
	
	Public Property Chart.Border() As Boolean
		Border = m_Border
	End Property
	
	Public Property Chart.Border(ByVal New_Value As Boolean)
		m_Border = New_Value
		Refresh
	End Property
	
	Public Property Chart.BorderRound() As Long
		BorderRound = m_BorderRound
	End Property
	
	Public Property Chart.BorderRound(ByVal New_Value As Long)
		m_BorderRound = New_Value
		Refresh
	End Property
	
	Public Property Chart.BorderColor() As OLE_COLOR
		BorderColor = m_BorderColor
	End Property
	
	Public Property Chart.BorderColor(ByVal New_Value As OLE_COLOR)
		m_BorderColor = New_Value
		Refresh
	End Property
	
	Public Property Chart.LabelsFormats() As String
		LabelsFormats = m_LabelsFormats
	End Property
	
	Public Property Chart.LabelsFormats(ByVal New_Value As String)
		m_LabelsFormats = New_Value
		Refresh
	End Property
	
	Public Property Chart.FillGradient() As Boolean
		FillGradient = m_FillGradient
	End Property
	
	Public Property Chart.FillGradient(ByVal New_Value As Boolean)
		m_FillGradient = New_Value
		Refresh
	End Property
	
	Public Property Chart.ChartStyle() As ChartStyles
		ChartStyle = m_ChartStyle
	End Property
	
	Public Property Chart.ChartStyle(ByVal New_Value As ChartStyles)
		m_ChartStyle = New_Value
		Refresh
	End Property
	
	Public Property Chart.LegendAlign() As ucPC_LegendAlign
		LegendAlign = m_LegendAlign
	End Property
	
	Public Property Chart.LegendAlign(ByVal New_Value As ucPC_LegendAlign)
		m_LegendAlign = New_Value
		Refresh
	End Property
	
	Public Property Chart.LegendVisible() As Boolean
		LegendVisible = m_LegendVisible
	End Property
	
	Public Property Chart.LegendVisible(ByVal New_Value As Boolean)
		m_LegendVisible = New_Value
		Refresh
	End Property
	
	Public Property Chart.DonutWidth() As Single
		DonutWidth = m_DonutWidth
	End Property
	
	Public Property Chart.DonutWidth(ByVal New_Value As Single)
		m_DonutWidth = New_Value
		Refresh
	End Property
	
	Public Property Chart.SeparatorLine() As Boolean
		SeparatorLine = m_SeparatorLine
	End Property
	
	Public Property Chart.SeparatorLine(ByVal New_Value As Boolean)
		m_SeparatorLine = New_Value
		Refresh
	End Property
	
	Public Property Chart.SeparatorLineWidth() As Single
		SeparatorLineWidth = m_SeparatorLineWidth
	End Property
	
	Public Property Chart.SeparatorLineWidth(ByVal New_Value As Single)
		m_SeparatorLineWidth = New_Value
		Refresh
	End Property
	
	Public Property Chart.SeparatorLineColor() As OLE_COLOR
		SeparatorLineColor = m_SeparatorLineColor
	End Property
	
	Public Property Chart.SeparatorLineColor(ByVal New_Value As OLE_COLOR)
		m_SeparatorLineColor = New_Value
		Refresh
	End Property
	
	Public Property Chart.LabelsPosition() As LabelsPositions
		LabelsPosition = m_LabelsPositions
	End Property
	
	Public Property Chart.LabelsPosition(ByVal New_Value As LabelsPositions)
		m_LabelsPositions = New_Value
		Refresh
	End Property
	
	Public Property Chart.LabelsVisible() As Boolean
		LabelsVisible = m_LabelsVisible
	End Property
	
	Public Property Chart.LabelsVisible(ByVal New_Value As Boolean)
		m_LabelsVisible = New_Value
		Refresh
	End Property
	
	Public Property Chart.Rotation() As Long
		Rotation = m_Rotation
	End Property
	
	Public Property Chart.Rotation(ByVal New_Value As Long)
		m_Rotation = New_Value Mod 360
		If m_Rotation < 0 Then m_Rotation = 360 + m_Rotation
		Refresh
	End Property
	
	Private Sub Chart.tmrMOUSEOVER_Timer_(ByRef Sender As TimerComponent)
		*Cast(Chart Ptr, Sender.Designer).tmrMOUSEOVER_Timer(Sender)
	End Sub
	Private Sub Chart.tmrMOUSEOVER_Timer(ByRef Sender As TimerComponent)
'		#ifndef __USE_GTK__
'			Dim PT As Point
'			Dim Rect As RectL
'			If c_lhWnd = 0 Then Exit Sub
'			
'			GetCursorPos @PT
'			ScreenToClient c_lhWnd, @PT
'			
'			With Rect
'				.Left = m_PT.X - (m_Left - ScaleX(This.Left))
'				.Top = m_PT.Y - (m_Top - ScaleY(This.Top))
'				.Right = This.ClientWidth
'				.Bottom = This.ClientHeight
'			End With
'			
'			If PtInRectL(Rect, PT.X, PT.Y) = 0 Then
'				'mHotBar = -1
'				HotItem = -1
'				tmrMOUSEOVER.Interval = 0
'				Me.Refresh
'				'RaiseEvent MouseLeave
'			End If
'		#endif
	End Sub
	
	Private Sub Chart.InitProperties()
		m_Title = This.Name
		FBackColor = clWhite
		m_BackColorOpacity = 100
		FForeColor = clBlack
		m_FillOpacity = 100
		m_Border = True
		m_BorderColor = &HF4F4F4
		m_LinesWidth = 1
		m_VerticalLines = False
		m_FillGradient = False
		m_HorizontalLines = True
		m_ChartStyle = CS_PIE
		m_ChartOrientation = CO_Vertical
		m_LegendAlign = LA_RIGHT
		m_LegendVisible = True
		m_TitleFont.Name = This.Font.Name
		m_TitleFont.Size = This.Font.Size + 8
		m_DonutWidth = 50!
		m_SeparatorLine = True
		m_SeparatorLineWidth = 2!
		m_SeparatorLineColor = clWhite
		m_LabelsVisible = True
		m_LabelsPositions = LP_Inside
		m_LabelsFormats = "{P}%"
		m_BorderRound = 0
		
		'c_lhWnd = UserControl.ContainerHwnd
		
	End Sub
	
	#ifndef __USE_GTK__
		Private Sub Chart.GetTextSize(ByVal hGraphics As GpGraphics Ptr, ByRef text As WString, ByVal lWidth As Long, ByVal Height As Long, ByRef oFont As My.Sys.Drawing.Font, ByVal bWordWrap As Boolean, ByRef SZ As SIZEF)
			Dim hBrush As Long
			Dim hFontFamily As GpFontFamily Ptr
			Dim hFormat As GpStringFormat Ptr
			Dim layoutRect As RectF
			Dim lFontSize As Long
			Dim lFontStyle As GDIPLUS_FONTSTYLE
			Dim hFont As GpFont Ptr
			Dim BB As RectF, CF As Long, LF As Long
			
			If GdipCreateFontFamilyFromName(WStrPtr(oFont.Name), 0, @hFontFamily) Then
				If GdipGetGenericFontFamilySansSerif(@hFontFamily) Then Exit Sub
			End If
			
			If GdipCreateStringFormat(0, 0, @hFormat) = 0 Then
				If Not bWordWrap Then GdipSetStringFormatFlags hFormat, StringFormatFlagsNoWrap
			End If
			
			If oFont.Bold Then lFontStyle = lFontStyle Or GDIPLUS_FONTSTYLE.FontStyleBold
			If oFont.Italic Then lFontStyle = lFontStyle Or GDIPLUS_FONTSTYLE.FontStyleItalic
			If oFont.Underline Then lFontStyle = lFontStyle Or GDIPLUS_FONTSTYLE.FontStyleUnderline
			If oFont.StrikeOut Then lFontStyle = lFontStyle Or GDIPLUS_FONTSTYLE.FontStyleStrikeout
			
			
			lFontSize = MulDiv(oFont.Size, GetDeviceCaps(GetDC(This.Handle), LOGPIXELSY), 72)
			
			layoutRect.Width = lWidth * nScale: layoutRect.Height = Height * nScale
			
			GdipCreateFont(hFontFamily, lFontSize, lFontStyle, UnitPixel, @hFont)
			
			GdipMeasureString hGraphics, @text, -1, hFont, @layoutRect, hFormat, @BB, @CF, @LF
			
			SZ.Width = BB.Width
			SZ.Height = BB.Height
			
			GdipDeleteFont hFont
			GdipDeleteStringFormat hFormat
			GdipDeleteFontFamily hFontFamily
			
		End Sub
	
		Private Sub Chart.DrawText(ByVal hGraphics As GpGraphics Ptr, hd As HDC, ByRef text As WString, ByVal X As Long, ByVal Y As Long, ByVal lWidth As Long, ByVal Height As Long, ByRef oFont As My.Sys.Drawing.Font, ByVal ForeColor As Long, HAlign As CaptionAlignmentH = 0, VAlign As CaptionAlignmentV = 0, bWordWrap As Boolean = False)
			Dim hBrush As GpSolidFill Ptr
			Dim hFontFamily As GpFontFamily Ptr
			Dim hFormat As GpStringFormat Ptr
			Dim layoutRect As RectF
			Dim lFontSize As Long
			Dim lFontStyle As GDIPLUS_FONTSTYLE
			Dim hFont As GpFont Ptr
			
			If GdipCreateFontFamilyFromName(@oFont.Name, 0, @hFontFamily) <> GDIP_OK Then
				If GdipGetGenericFontFamilySansSerif(@hFontFamily) <> GDIP_OK Then Exit Sub
				'If GdipGetGenericFontFamilySerif(hFontFamily) Then Exit Function
			End If
			
			If GdipCreateStringFormat(0, 0, @hFormat) = GDIP_OK Then
				If Not bWordWrap Then GdipSetStringFormatFlags hFormat, StringFormatFlagsNoWrap
				'GdipSetStringFormatFlags hFormat, HotkeyPrefixShow
				GdipSetStringFormatAlign hFormat, HAlign
				GdipSetStringFormatLineAlign hFormat, VAlign
			End If
			
			If oFont.Bold Then lFontStyle = lFontStyle Or GDIPLUS_FONTSTYLE.FontStyleBold
			If oFont.Italic Then lFontStyle = lFontStyle Or GDIPLUS_FONTSTYLE.FontStyleItalic
			If oFont.Underline Then lFontStyle = lFontStyle Or GDIPLUS_FONTSTYLE.FontStyleUnderline
			If oFont.Strikeout Then lFontStyle = lFontStyle Or GDIPLUS_FONTSTYLE.FontStyleStrikeout
			
			lFontSize = MulDiv(oFont.Size, GetDeviceCaps(hD, LOGPIXELSY), 72)
			
			layoutRect.X = X: layoutRect.Y = Y
			layoutRect.Width = lWidth: layoutRect.Height = Height

			If GdipCreateSolidFill(ForeColor, Cast(GpSolidFill Ptr Ptr, @hBrush)) = GDIP_OK Then
				If GdipCreateFont(hFontFamily, lFontSize, lFontStyle, UnitPixel, @hFont) = GDIP_OK Then
					GdipDrawString hGraphics, @text, -1, hFont, @layoutRect, hFormat, Cast(GpBrush Ptr, hBrush)
					GdipDeleteFont hFont
				End If
				GdipDeleteBrush Cast(GpBrush Ptr, hBrush)
			End If
			
			If hFormat Then GdipDeleteStringFormat hFormat
			GdipDeleteFontFamily hFontFamily
			
			
		End Sub
		
		Public Function Chart.GetWindowsDPI() As Double
			Dim hDC As HDC, LPX  As Double
			hDC = GetDC(0)
			LPX = CDbl(GetDeviceCaps(hDC, LOGPIXELSX))
			ReleaseDC 0, hDC
			
			If (LPX = 0) Then
				GetWindowsDPI = 1#
			Else
				GetWindowsDPI = LPX / 96#
			End If
		End Function
	
		Private Sub Chart.HitTest(X As Single, Y As Single, HitResult As Integer)
'			If This.Enabled Then
'				HitResult = 3
'				If Not DesignMode Then
'					Dim PT As Point
'					
'					If tmrMOUSEOVER.Interval = 0 Then
'						GetCursorPos @PT
'						ScreenToClient c_lhWnd, @PT
'						m_PT.X = PT.X - X
'						m_PT.Y = PT.Y - Y
'						
'						m_Left = ScaleX(This.Left)
'						m_Top = ScaleY(This.Top)
'						
'						
'						tmrMOUSEOVER.Interval = 1
'						'RaiseEvent MouseEnter
'					End If
'					
'				End If
'			End If
		End Sub
		
		Private Sub Chart.MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
			
			Dim i As Long
			Dim lResult As Long
			
			If Button <> 0 Then Exit Sub
			
			For i = 0 To ItemsCount - 1
				
				lResult = 0
				GdipIsVisiblePathPoint(m_Item(i).hPath, X, Y, 0, Cast(BOOL Ptr, @lResult))
				
				If lResult Then
					If i = HotItem Then
						If OnItemClick Then OnItemClick(i)
					End If
					Exit Sub
				End If
				
			Next
		End Sub
		Private Sub Chart.MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
			Dim i As Long
			Dim lResult As Long 'BOOL
			'RaiseEvent MouseMove(Button, Shift, X, Y)
			If Button <> -1 Then Exit Sub
			For i = 0 To ItemsCount - 1
				
				If PtInRectL(m_Item(i).LegendRect, X, Y) Then
					If i <> HotItem Then
						HotItem = i
						Me.Refresh
					End If
					Exit Sub
				End If
				
				'?"MouseMove", X, Y
				lResult = 0
				GdipIsVisiblePathPoint(m_Item(i).hPath, X, Y, 0, Cast(BOOL Ptr, @lResult))
				
				If lResult Then
					If i <> HotItem Then
						HotItem = i
						Me.Refresh
					End If
					Exit Sub
				End If
				
			Next
			
			If HotItem <> -1 Then
				HotItem = -1
				Me.Refresh
			End If
			
		End Sub
	#endif
	
	Private Function Chart.PtInRectL(Rect_ As RectL, ByVal X As Long, ByVal Y As Long) As Boolean
		With Rect_
			'?"PtInRectL - X, Y: " & X & ", " & Y, "Left: " & .Left, "Width: " & .Right, "Right: " & .Left + .Right, "Top: " &  .Top, "Height: " &  .Bottom, "Bottom: " & .Top + .Bottom
			If X >= .Left And X <= .Left + .Right And Y >= .Top And Y <= .Top + .Bottom Then
				PtInRectL = True
			End If
		End With
	End Function
	
	#ifndef __USE_GTK__
		Private Sub Chart.Paint(hd As HDC)
			This.Draw hd
		End Sub
	#endif
	
	Public Sub Chart.Refresh()
'		Dim As HDC hd
'		hd = GetDC(FHandle)
'		This.Paint hd
'		ReleaseDc FHandle, hd
		'Repaint
		RedrawWindow(FHandle, NULL, NULL, RDW_INVALIDATE)
		UpdateWindow FHandle
	End Sub
	
	Private Sub Chart.Show()
		Me.Refresh
	End Sub
	
	#ifndef __USE_GTK__
		Private Sub Chart.ManageGDIToken(ByVal projectHwnd As HWND) ' by LaVolpe
			'If projectHwnd = 0& Then Exit Function
			
'			Dim hwndGDIsafe     As HWND                 'API window to monitor IDE shutdown
'			
'			Do
'				hwndGDIsafe = GetParent(projectHwnd)
'				If Not hwndGDIsafe = 0& Then projectHwnd = hwndGDIsafe
'			Loop Until hwndGDIsafe = 0&
'			' ok, got the highest level parent, now find highest level owner
'			Do
'				hwndGDIsafe = GetWindow(projectHwnd, GW_OWNER)
'				If Not hwndGDIsafe = 0& Then projectHwnd = hwndGDIsafe
'			Loop Until hwndGDIsafe = 0&
'			
'			hwndGDIsafe = FindWindowEx(projectHwnd, 0&, "Static", "GDI+Safe Patch")
'			
'			If hwndGDIsafe Then
'				ManageGDIToken = hwndGDIsafe    ' we already have a manager running for this VB instance
'				Exit Function                   ' can abort
'			End If
'			
			Dim StartupInput As Gdiplus.GdiplusStartupInput  'GDI+ startup info
			
'	'		
'	'		'On Error Resume Next
			StartupInput.GdiPlusVersion = 1                    ' attempt to start GDI+
			GdiplusStartup(@gToken, @StartupInput, NULL)
			If gToken = 0& Then                         ' failed to start
				'If Err Then Err.Clear
				Exit Sub
			End If
			
'			On Error Goto 0
'			
'			Dim z_ScMem         As LPVOID                 'Thunk base address
'			Dim z_Code()        As Long                 'Thunk machine-code initialised here
'			Dim nAddr           As Long                 'hwndGDIsafe prev window procedure
'			
'			Const WNDPROC_OFF   As Long = &H30          'Offset where window proc starts from z_ScMem
'			Const PAGE_RWX      As Long = &H40&         'Allocate executable memory
'			Const MEM_COMMIT    As Long = &H1000&       'Commit allocated memory
'			Const MEM_RELEASE   As Long = &H8000&       'Release allocated memory flag
'			Const MEM_LEN       As Long = &HD4          'Byte length of thunk
'			
'			z_ScMem = VirtualAlloc(0, MEM_LEN, MEM_COMMIT, PAGE_RWX) 'Allocate executable memory
'			If z_ScMem <> 0 Then                                     'Ensure the allocation succeeded
'				' we make the api window a child so we can use FindWindowEx to locate it easily
'				hwndGDIsafe = CreateWindowExW(0&, "Static", "GDI+Safe Patch", WS_CHILD, 0&, 0&, 0&, 0&, projectHwnd, 0&, GetModuleHandle(0), ByVal 0&)
'				If hwndGDIsafe <> 0 Then
'					
'					ReDim z_Code(0 To MEM_LEN \ 4 - 1)
'					
'					z_Code(12) = &HD231C031: z_Code(13) = &HBBE58960: z_Code(14) = &H12345678: z_Code(15) = &H3FFF631: z_Code(16) = &H74247539: z_Code(17) = &H3075FF5B: z_Code(18) = &HFF2C75FF: z_Code(19) = &H75FF2875
'					z_Code(20) = &H2C73FF24: z_Code(21) = &H890853FF: z_Code(22) = &HBFF1C45: z_Code(23) = &H2287D81: z_Code(24) = &H75000000: z_Code(25) = &H443C707: z_Code(26) = &H2&: z_Code(27) = &H2C753339: z_Code(28) = &H2047B81: z_Code(29) = &H75000000
'					z_Code(30) = &H2C73FF23: z_Code(31) = &HFFFFFC68: z_Code(32) = &H2475FFFF: z_Code(33) = &H681C53FF: z_Code(34) = &H12345678: z_Code(35) = &H3268&: z_Code(36) = &HFF565600: z_Code(37) = &H43892053: z_Code(38) = &H90909020: z_Code(39) = &H10C261
'					z_Code(40) = &H562073FF: z_Code(41) = &HFF2453FF: z_Code(42) = &H53FF1473: z_Code(43) = &H2873FF18: z_Code(44) = &H581053FF: z_Code(45) = &H89285D89: z_Code(46) = &H45C72C75: z_Code(47) = &H800030: z_Code(48) = &H20458B00: z_Code(49) = &H89145D89
'					z_Code(50) = &H81612445: z_Code(51) = &H4C4&: z_Code(52) = &HC63FF00
'					
'					z_Code(1) = 0                                                   ' shutDown mode; used internally by ASM
'					z_Code(2) = zFnAddr("user32", "CallWindowProcA")                ' function pointer CallWindowProc
'					z_Code(3) = zFnAddr("kernel32", "VirtualFree")                  ' function pointer VirtualFree
'					z_Code(4) = zFnAddr("kernel32", "FreeLibrary")                  ' function pointer FreeLibrary
'					z_Code(5) = gToken                                              ' Gdi+ token
'					z_Code(10) = Cast(Long, LoadLibrary("gdiplus"))                             ' library pointer (add reference)
'					z_Code(6) = Cast(Long, GetProcAddress(Cast(HMODULE, z_Code(10)), "GdiplusShutdown"))       ' function pointer GdiplusShutdown
'					z_Code(7) = zFnAddr("user32", "SetWindowLongA")                 ' function pointer SetWindowLong
'					z_Code(8) = zFnAddr("user32", "SetTimer")                       ' function pointer SetTimer
'					z_Code(9) = zFnAddr("user32", "KillTimer")                      ' function pointer KillTimer
'					
'					z_Code(14) = Cast(Long, z_ScMem)                                            ' ASM ebx start point
'					z_Code(34) = Cast(Long, z_ScMem + WNDPROC_OFF)                              ' subclass window procedure location
'					
'					RtlMoveMemory(z_ScMem, VarPtr(z_Code(0)), MEM_LEN)               'Copy the thunk code/data to the allocated memory
'					
'					nAddr = SetWindowLongPtr(hwndGDIsafe, GWL_WNDPROC, Cast(LONG_PTR, z_ScMem + WNDPROC_OFF)) 'Subclass our API window
'					RtlMoveMemory(z_ScMem + 44, VarPtr(nAddr), 4&) ' Add prev window procedure to the thunk
'					gToken = 0& ' zeroize so final check below does not release it
'					
'					ManageGDIToken = hwndGDIsafe    ' return handle of our GDI+ manager
'				Else
'					VirtualFree z_ScMem, 0, MEM_RELEASE     ' failure - release memory
'					z_ScMem = 0&
'				End If
'			Else
'				VirtualFree z_ScMem, 0, MEM_RELEASE           ' failure - release memory
'				z_ScMem = 0&
'			End If
'			
'			If gToken Then GdiplusShutdown gToken       ' release token if error occurred
			
		End Sub
		
		Private Function Chart.zFnAddr(ByVal sDLL As String, ByVal sProc As String) As Long
			zFnAddr = Cast(Long, GetProcAddress(GetModuleHandleA(sDLL), sProc))  'Get the specified procedure address
		End Function
	
		Private Function Chart.SafeRange(Value As Long, Min As Long, Max As Long) As Long
			
			If Value < Min Then
				SafeRange = Min
			ElseIf Value > Max Then
				SafeRange = Max
			Else
				SafeRange = Value
			End If
		End Function
		
		Public Function Chart.RGBtoARGB(ByVal RGBColor As Long, ByVal Opacity As Long) As Long
			Return Color_MakeARGB(Opacity / 100 * 255, GetRed(RGBColor), GetGreen(RGBColor), GetBlue(RGBColor))
		End Function
	#endif
	
	Function Round(X As Double, Drob As Integer) As Integer
		If Drob = 0 Then
			Return CInt(X)
		Else
			Return CInt(X * 10 ^ Drob) / 10 ^ Drob
		End If
	End Function
	
	'*1
	#ifndef __USE_GTK__
		Private Sub Chart.Draw(hd As HDC)
			Dim hGraphics As GpGraphics Ptr
			Dim hBrush As GpSolidFill Ptr, hPen As GpPen Ptr
			Dim i As Single, j As Long
			Dim mHeight As Single
			Dim mWidth As Single
			Dim mPenWidth As Single
			Dim MarginLeft As Single
			Dim MarginRight As Single
			Dim TopHeader As Single
			Dim Footer As Single
			Dim TextWidth As Single
			Dim TextHeight As Single
			Dim XX As Single, YY As Single
			Dim lForeColor As Long
			Dim RectL_ As RectL
			Dim LabelsRect As RectL
			Dim PT16 As Single
			Dim ColRow As Integer
			Dim TitleSize As SIZEF
			Dim sDisplay As String
			Dim SafePercent As Single
			Dim Min As Single, LastAngle As Single, Angle As Single, Total  As Single
			Dim DonutSize As Single
			Dim R1 As Single, R2 As Single, R3 As Single
			Dim CX As Single, CY   As Single
			Dim Left_ As Single, Top_ As Single
			Dim Percent As Single
			Const PItoRAD = 3.141592 / 180
			Dim lTop As Single
			Dim sLabelText As String
			Dim bAngMaj180 As Boolean
			Dim LblWidth As Single
			Dim LblHeight As Single
			Dim mFormat As String
			Dim A As Single
			Dim Displacement As Single
			Dim lColor As Long
			
			If GdipCreateFromHDC(hD, @hGraphics) Then Exit Sub
			
			GdipSetSmoothingMode(hGraphics, SmoothingModeAntiAlias)
			
			PT16 = 16 * nScale
			mPenWidth = 1 * nScale
			DonutSize = m_DonutWidth * nScale
			
			MarginLeft = PT16
			TopHeader = PT16
			MarginRight = PT16
			Footer = PT16
			
			Canvas.Font = This.Font
			If m_LegendVisible Then
				For i = 0 To ItemsCount - 1
					m_Item(i).TextHeight = Canvas.TextHeight(m_Item(i).ItemName) * 1.5
					m_Item(i).TextWidth = Canvas.TextWidth(m_Item(i).ItemName) * 1.5 + m_Item(i).TextHeight
				Next
			End If
			
			If Len(m_Title) Then
				GetTextSize(hGraphics, *m_Title.vptr, This.ClientWidth, 0, m_TitleFont, True, TitleSize)
				TopHeader = TopHeader + TitleSize.Height
			End If
			mWidth = This.ClientWidth - MarginLeft - MarginRight
			mHeight = This.ClientHeight - TopHeader - Footer
			
			'Calculate the Legend Area
			If m_LegendVisible Then
				ColRow = 1
				Select Case m_LegendAlign
				Case LA_RIGHT, LA_LEFT
					With LabelsRect
						TextWidth = 0
						TextHeight = 0
						For i = 0 To ItemsCount - 1
							If TextHeight + m_Item(i).TextHeight > mHeight Then
								.Right = .Right + TextWidth
								ColRow = ColRow + 1
								TextWidth = 0
								TextHeight = 0
							End If
							
							TextHeight = TextHeight + m_Item(i).TextHeight
							.Bottom = .Bottom + m_Item(i).TextHeight
							
							If TextWidth < m_Item(i).TextWidth Then
								TextWidth = m_Item(i).TextWidth '+ PT16
							End If
						Next
						.Right = .Right + TextWidth
						If m_LegendAlign = LA_LEFT Then
							MarginLeft = MarginLeft + .Right
						Else
							MarginRight = MarginRight + .Right
						End If
						mWidth = mWidth - .Right
					End With
					
				Case LA_BOTTOM, LA_TOP
					With LabelsRect
						
						.Bottom = m_Item(0).TextHeight + PT16 / 2
						TextWidth = 0
						For i = 0 To ItemsCount - 1
							If TextWidth + m_Item(i).TextWidth > mWidth Then
								.Bottom = .Bottom + m_Item(i).TextHeight
								ColRow = ColRow + 1
								TextWidth = 0
							End If
							TextWidth = TextWidth + m_Item(i).TextWidth
							.Right = .Right + m_Item(i).TextWidth
						Next
						If m_LegendAlign = LA_TOP Then
							TopHeader = TopHeader + .Bottom
						End If
						mHeight = mHeight - .Bottom
					End With
				End Select
			End If
			
			
			Dim RectF_ As RectF
			With RectF_
				.Width = This.ClientWidth - 1 * nScale
				.Height = This.ClientHeight - 1 * nScale
			End With
			
			RoundRect hGraphics, RectF_, RGBtoARGB(FBackColor, m_BackColorOpacity), RGBtoARGB(m_BorderColor, 100), m_BorderRound * nScale, m_Border
			
			
			'    'Background
			'    If m_BackColorOpacity > 0 Then
			'        GdipCreateSolidFill RGBtoARGB(m_BackColor, m_BackColorOpacity), hBrush
			'        GdipFillRectangleI hGraphics, hBrush, 0, 0, UserControl.ScaleWidth, UserControl.ScaleHeight
			'        GdipDeleteBrush hBrush
			'    End If
			'
			'    'Border
			'    If m_Border Then
			'        Call GdipCreatePen1(RGBtoARGB(m_BorderColor, 50), mPenWidth, &H2, hPen)
			'        GdipDrawRectangleI hGraphics, hPen, mPenWidth / 2, mPenWidth / 2, UserControl.ScaleWidth - mPenWidth, UserControl.ScaleHeight - mPenWidth
			'        GdipDeletePen hPen
			'    End If
			'
			
			
			'Sum of itemes
			For i = 0 To ItemsCount - 1
				Total = Total + m_Item(i).Value
			Next
			
			'calculate max size of labels
			For i = 0 To ItemsCount - 1
				With m_Item(i)
					Percent = Round(100 * .Value / Total, 1)
					If i < ItemsCount - 1 Then
						SafePercent = SafePercent + Percent
					Else
						Percent = Round(100 - SafePercent, 1)
					End If
					.text = Replace(m_LabelsFormats, "{A}", .ItemName)
					.text = Replace(.text, "{P}", WStr(Percent))
					.text = Replace(.text, "{V}", WStr(Round(.Value, 1)))
					.text = Replace(.text, "{LF}", Chr(10))
					
					TextWidth = Canvas.TextWidth(.text) * 1.3
					TextHeight = Canvas.TextHeight(.text) * 1.3
					If TextWidth > LblWidth Then LblWidth = TextWidth
					If TextHeight > LblHeight Then LblHeight = TextHeight
				End With
			Next
			
			'size of pie
			If m_LabelsPositions = LP_Outside Or m_LabelsPositions = LP_TwoColumns Then
				Min = IIf(mWidth - LblWidth * 2 < mHeight - LblHeight * 2, mWidth - LblWidth * 2, mHeight - LblHeight * 2)
			Else
				Min = IIf(mWidth < mHeight, mWidth, mHeight)
			End If
			
			
			If Min / 3 < DonutSize Then DonutSize = Min / 3
			XX = MarginLeft + mWidth / 2 - Min / 2
			YY = TopHeader + mHeight / 2 - Min / 2
			m_CenterCircle.X = MarginLeft + mWidth / 2
			m_CenterCircle.Y = TopHeader + mHeight / 2
			R1 = Min / 2
			
			'    If m_SeparatorLine Then
			'        GdipCreateSolidFill RGBtoARGB(m_SeparatorLineColor, m_BackColorOpacity), hBrush
			'        GdipFillEllipseI hGraphics, hBrush, XX - m_SeparatorLineWidth, YY - m_SeparatorLineWidth, Min + m_SeparatorLineWidth * 2, Min + m_SeparatorLineWidth * 2
			'        GdipDeleteBrush hBrush
			'    End If
			
			LastAngle = m_Rotation - 90
			For i = 0 To ItemsCount - 1
				Angle = 360 * m_Item(i).Value / Total
				
				
				'*1
				If m_Item(i).Special Then
					R2 = PT16 / 1.5
					Left_ = XX + (R2 * Cos((LastAngle + Angle / 2) * PItoRAD))
					Top_ = YY + (R2 * Sin((LastAngle + Angle / 2) * PItoRAD))
				Else
					Left_ = XX
					Top_ = YY
				End If
				
				If m_Item(i).hPath <> 0 Then GdipDeletePath m_Item(i).hPath
				GdipCreatePath 0, @m_Item(i).hPath
				
				If m_ChartStyle = CS_DONUT Then
					GdipAddPathArc m_Item(i).hPath, Left_, Top_, Min, Min, LastAngle, Angle
					GdipAddPathArc m_Item(i).hPath, Left_ + DonutSize, Top_ + DonutSize, Min - DonutSize * 2, Min - DonutSize * 2, LastAngle + Angle, -Angle
				Else
					GdipAddPathPie m_Item(i).hPath, Left_, Top_, Min, Min, LastAngle, Angle
				End If
				
				If HotItem = i Then
					'?lColor
					lColor = RGBtoARGB(ShiftColor(m_Item(i).ItemColor, clWhite, 150), m_FillOpacity)
					'?lColor
				Else
					lColor = RGBtoARGB(m_Item(i).ItemColor, m_FillOpacity)
				End If
				If m_FillGradient Then
					With RectL_
						.Left = MarginLeft - R2
						.Top = TopHeader - R2
						.Right = mWidth + R2 * 2
						.Bottom = mHeight + R2 * 2
					End With
					GdipCreateLineBrushFromRectWithAngleI Cast(GpRect Ptr, @RectL_), lColor, RGBtoARGB(clWhite, 100), 180 + LastAngle + Angle / 2, 0, WrapModeTile, Cast(GpLineGradient Ptr Ptr, @hBrush)
				Else
					GdipCreateSolidFill lColor, Cast(GpSolidFill Ptr Ptr, @hBrush)
				End If
				GdipFillPath hGraphics, Cast(GpBrush Ptr, hBrush), m_Item(i).hPath
				GdipDeleteBrush Cast(GpBrush Ptr, hBrush)
				
				R1 = Min / 2
				R2 = m_Item(i).TextWidth / 2
				R3 = m_Item(i).TextHeight / 2
				
				CX = XX + Min / 2 + TextWidth
				CY = YY + Min / 2 + TextHeight
				
				Left_ = CX + ((R1 - R2) * Cos((LastAngle + Angle / 2) * PItoRAD)) - R2
				Top_ = CY + ((R1 - R3) * Sin((LastAngle + Angle / 2) * PItoRAD)) - R3
				'DrawText hGraphics, m_Item(i).ItemName, Left, Top, R2 * 2, R3 * 2, UserControl.Font, lForeColor, cCenter, cMiddle
				LastAngle = LastAngle + Angle '+ 2
			Next
			
			'*2
			
			LastAngle = m_Rotation - 90
			bAngMaj180 = False
			For i = 0 To ItemsCount - 1
				Angle = 360 * m_Item(i).Value / Total
				
				If m_SeparatorLine Then
					GdipCreatePen1 RGBtoARGB(m_SeparatorLineColor, 100), m_SeparatorLineWidth * nScale, 2, @hPen
					GdipSetPenEndCap hPen, 2
					
					R1 = (Min + mPenWidth / 2) / 2
					R2 = (Min - mPenWidth / 2) / 2 - DonutSize
					
					CX = XX + Min / 2
					CY = YY + Min / 2
					
					Left_ = CX + (R1 * Cos((LastAngle) * PItoRAD))
					Top_ = CY + (R1 * Sin((LastAngle) * PItoRAD))
					
					If m_ChartStyle = CS_DONUT Then
						CX = CX + (R2 * Cos((LastAngle) * PItoRAD))
						CY = CY + (R2 * Sin((LastAngle) * PItoRAD))
					Else
						'GdipDrawEllipseI hGraphics, hPen, XX, YY, Min, Min
					End If
					
					GdipDrawLineI hGraphics, hPen, Left_, Top_, CX, CY
					
					GdipDeletePen hPen
				End If
				
				TextWidth = LblWidth
				TextHeight = LblHeight
				
				If m_LabelsPositions = LP_Inside Then
					If DonutSize > TextWidth Then TextWidth = DonutSize
					If DonutSize > TextHeight Then TextHeight = DonutSize
				End If
				
				R2 = TextWidth / 2
				R3 = TextHeight / 2
				Displacement = IIf(m_Item(i).Special, PT16 / 1.5, 0)
				
				CX = XX + Min / 2
				CY = YY + Min / 2
				
				A = LastAngle + Angle / 2
				
				If m_LabelsPositions = LP_Inside Then
					Left_ = CX + ((R1 - R2 + Displacement) * Cos(A * PItoRAD)) - R2
					Top_ = CY + ((R1 - R3 + Displacement) * Sin(A * PItoRAD)) - R3
				Else
					Left_ = CX + ((R1 + R2 + Displacement) * Cos(A * PItoRAD)) - R2
					Top_ = CY + ((R1 + R3 + Displacement) * Sin(A * PItoRAD)) - R3
				End If
				If m_LabelsVisible Then
					If m_LabelsPositions = LP_TwoColumns Then
						Dim LineOut As Integer
						LineOut = Canvas.TextHeight("Aj") / 2
						
						GdipCreateSolidFill RGBtoARGB(m_Item(i).ItemColor, 50), Cast(GpSolidFill Ptr Ptr, @hBrush)
						GdipCreatePen1 RGBtoARGB(m_Item(i).ItemColor, 100), 1 * nScale, 2, @hPen
						
						If (LastAngle + Angle / 2 + 90) Mod 359 < 180 Then
							If bAngMaj180 Then
								bAngMaj180 = False
								lTop = Top_
							End If
							
							If lTop <= 0 Then lTop = Top_
							
							If Top_ < lTop Then
								lTop = lTop
							Else
								lTop = Top_
							End If
							
							Left_ = XX + Min + PT16
							GdipFillRectangleI hGraphics, Cast(GpBrush Ptr, hBrush), Left_, lTop, TextWidth, TextHeight
							DrawText hGraphics, hd, m_Item(i).text, Left_, lTop, TextWidth, TextHeight, This.Font, RGBtoARGB(FForeColor, 100), cCenter, cMiddle
							
							lTop = lTop + TextHeight
							
							Left_ = CX + (R1 * Cos(A * PItoRAD))
							Top_ = CY + (R1 * Sin(A * PItoRAD))
							CX = CX + ((R1 + LineOut) * Cos(A * PItoRAD))
							CY = CY + ((R1 + LineOut) * Sin(A * PItoRAD))
							
							GdipDrawLineI hGraphics, hPen, Left_, Top_, CX, CY
							Left_ = XX + Min + PT16
							Top_ = lTop - TextHeight / 2
							GdipDrawLineI hGraphics, hPen, CX, CY, Left_, Top_
						Else
							If bAngMaj180 = False Then
								bAngMaj180 = True
								lTop = TopHeader + mHeight
							End If
							
							If lTop <= 0 Then lTop = Top_
							
							If Top_ > lTop Then
								lTop = lTop
							Else
								lTop = Top_
							End If
							
							Left_ = XX - TextWidth - PT16
							GdipFillRectangleI hGraphics, Cast(GpBrush Ptr, hBrush), Left_, lTop, TextWidth, TextHeight
							DrawText hGraphics, hd, m_Item(i).text, Left_, lTop, TextWidth, TextHeight, This.Font, RGBtoARGB(FForeColor, 100), cCenter, cMiddle
							
							Left_ = CX + (R1 * Cos(A * PItoRAD))
							Top_ = CY + (R1 * Sin(A * PItoRAD))
							CX = CX + ((R1 + LineOut) * Cos(A * PItoRAD))
							CY = CY + ((R1 + LineOut) * Sin(A * PItoRAD))
							GdipDrawLineI hGraphics, hPen, Left_, Top_, CX, CY
							Left_ = XX - PT16
							Top_ = lTop + TextHeight / 2
							GdipDrawLineI hGraphics, hPen, CX, CY, Left_, Top_
							lTop = lTop - TextHeight
						End If
						GdipDeleteBrush Cast(GpBrush Ptr, hBrush)
						GdipDeletePen hPen
						
					ElseIf m_LabelsPositions = LP_Inside Then
						'lForeColor = IIf(IsDarkColor(m_Item(i).ItemColor), &H808080, vbWhite)
						'DrawText hGraphics, m_Item(i).Text, Left + 1, Top + 1, TextWidth, TextHeight, UserControl.Font, RGBtoARGB(lForeColor, 100), cCenter, cMiddle
						If HotItem = i Then
							lColor = ShiftColor(m_Item(i).ItemColor, clWhite, 150)
						Else
							lColor = m_Item(i).ItemColor
						End If
						lForeColor = IIf(IsDarkColor(lColor), clWhite, clBlack)
						DrawText hGraphics, hd, m_Item(i).text, Left_, Top_, TextWidth, TextHeight, This.Font, RGBtoARGB(lForeColor, 100), cCenter, cMiddle
					Else
						DrawText hGraphics, hd, m_Item(i).text, Left_, Top_, TextWidth, TextHeight, This.Font, RGBtoARGB(FForeColor, 100), cCenter, cMiddle
					End If
				End If
				LastAngle = LastAngle + Angle '+ 2
			Next
			
			
			
			If m_LegendVisible Then
				For i = 0 To ItemsCount - 1
					lForeColor = RGBtoARGB(FForeColor, 100)
					Select Case m_LegendAlign
					Case LA_RIGHT, LA_LEFT
						With LabelsRect
							TextWidth = 0
							
							If .Left = 0 Then
								TextHeight = 0
								If m_LegendAlign = LA_LEFT Then
									.Left = PT16
								Else
									.Left = MarginLeft + mWidth + PT16
								End If
								If ColRow = 1 Then
									.Top = TopHeader + mHeight / 2 - .Bottom / 2
								Else
									.Top = TopHeader
								End If
							End If
							
							If TextWidth < m_Item(i).TextWidth Then
								TextWidth = m_Item(i).TextWidth '+ PT16
							End If
							
							If TextHeight + m_Item(i).TextHeight > mHeight Then
								If i > 0 Then .Left = .Left + TextWidth
								.Top = TopHeader
								TextHeight = 0
							End If
							m_Item(i).LegendRect.Left = .Left
							m_Item(i).LegendRect.Top = .Top
							m_Item(i).LegendRect.Right = m_Item(i).TextWidth
							m_Item(i).LegendRect.Bottom = m_Item(i).TextHeight
							'?"LegendRect", m_Item(i).LegendRect.Left, m_Item(i).LegendRect.Top
							
							With m_Item(i).LegendRect
								GdipCreateSolidFill RGBtoARGB(m_Item(i).ItemColor, 100), @hBrush '&hB0000000
								GdipFillEllipseI hGraphics, Cast(GpBrush Ptr, hBrush), .Left, .Top + m_Item(i).TextHeight / 4, m_Item(i).TextHeight / 2, m_Item(i).TextHeight / 2
								GdipDeleteBrush Cast(GpBrush Ptr, hBrush)
							End With
							DrawText hGraphics, hd, m_Item(i).ItemName, .Left + m_Item(i).TextHeight / 1.5, .Top, m_Item(i).TextWidth, m_Item(i).TextHeight, This.Font, lForeColor, cLeft, cMiddle
							TextHeight = TextHeight + m_Item(i).TextHeight
							.Top = .Top + m_Item(i).TextHeight
							
						End With
						
					Case LA_BOTTOM, LA_TOP
						With LabelsRect
							If .Left = 0 Then
								If ColRow = 1 Then
									.Left = MarginLeft + mWidth / 2 - .Right / 2
								Else
									.Left = MarginLeft
								End If
								If m_LegendAlign = LA_TOP Then
									.Top = PT16 + TitleSize.Height
								Else
									.Top = TopHeader + mHeight + TitleSize.Height - PT16 / 2
								End If
							End If
							
							If .Left + m_Item(i).TextWidth - MarginLeft > mWidth Then
								.Left = MarginLeft
								.Top = .Top + m_Item(i).TextHeight
							End If
							
							GdipCreateSolidFill RGBtoARGB(m_Item(i).ItemColor, 100), @hBrush
							GdipFillEllipseI hGraphics, Cast(GpBrush Ptr, hBrush), .Left, .Top + m_Item(i).TextHeight / 4, m_Item(i).TextHeight / 2, m_Item(i).TextHeight / 2
							GdipDeleteBrush Cast(GpBrush Ptr, hBrush)
							m_Item(i).LegendRect.Left = .Left
							m_Item(i).LegendRect.Top = .Top
							m_Item(i).LegendRect.Right = m_Item(i).TextWidth
							m_Item(i).LegendRect.Bottom = m_Item(i).TextHeight
							
							DrawText hGraphics, hd, m_Item(i).ItemName, .Left + m_Item(i).TextHeight / 1.5, .Top, m_Item(i).TextWidth, m_Item(i).TextHeight, This.Font, lForeColor, cLeft, cMiddle
							.Left = .Left + m_Item(i).TextWidth '+ M_ITEM(i).TextHeight / 1.5
						End With
					End Select
					
					
				Next
			End If
			
			'Title
			If Len(m_Title) Then
				DrawText hGraphics, hd, m_Title, 0, PT16 / 2, This.ClientWidth, TopHeader, m_TitleFont, RGBtoARGB(m_TitleForeColor, 100), cCenter, cTop, True
			End If
			
			ShowToolTips hGraphics, hD
			
			GdipDeleteGraphics(hGraphics)
			
		End Sub
	#endif
	
	#ifndef __USE_GTK__
		Private Sub Chart.ShowToolTips(hGraphics As GpGraphics Ptr, hd As HDC)
			Dim i As Long, j As Long
			Dim sDisplay As String
			Dim bBold As Boolean
			Dim RectF_ As RectF
			Dim LW As Single
			Dim lForeColor As Long
			Dim sText As String
			Dim TM As Single
			Dim PT As POINTF
			Dim SZ As SIZEF
			
			If HotItem > -1 Then
				lForeColor = RGBtoARGB(FForeColor, 100)
				LW = m_LinesWidth * nScale
				TM = Canvas.TextHeight("Aj") / 4
				
				sText = m_Item(HotItem).ItemName & ": " & m_Item(HotItem).text
				GetTextSize hGraphics, sText, 0, 0, This.Font, False, SZ
				
				With RectF_
					GdipGetPathLastPoint m_Item(HotItem).hPath, Cast(GpPointF Ptr, @PT)
					.X = PT.X
					.Y = PT.Y
					.Width = SZ.Width + TM * 2
					.Height = SZ.Height + TM * 2
					
					If .X < 0 Then .X = LW
					If .Y < 0 Then .Y = LW
					If .X + .Width >= This.ClientWidth - LW Then .X = This.ClientWidth - .Width - LW
					If .Y + .Height >= This.ClientHeight - LW Then .Y = This.ClientHeight - .Height - LW
				End With
				
				RoundRect hGraphics, RectF_, RGBtoARGB(FBackColor, 90), RGBtoARGB(m_Item(HotItem).ItemColor, 100), TM, True
				
				With RectF_
					.X = .X + TM
					.Y = .Y
					DrawText hGraphics, hd, m_Item(HotItem).ItemName & ": ", .X, .Y, .Width, .Height, This.Font, lForeColor, cLeft, cMiddle
					GetTextSize hGraphics, m_Item(HotItem).ItemName & ": ", 0, 0, This.Font, False, SZ
					
					bBold = Canvas.Font.Bold
					Canvas.Font.Bold = True
					DrawText hGraphics, hd, m_Item(HotItem).text, .X + SZ.Width, .Y, .Width, .Height, Canvas.Font, lForeColor, cLeft, cMiddle
					Canvas.Font.Bold = bBold
				End With
				
			End If
		End Sub
		
		Private Sub Chart.RoundRect(ByVal hGraphics As GpGraphics Ptr, Rect As RectF, ByVal BackColor As Long, ByVal lBorderColor As Long, ByVal Round As Single, bBorder As Boolean = True)
			Dim hPen As GpPen Ptr, hBrush As GpBrush Ptr
			Dim mPath As GpPath Ptr
			
			GdipCreateSolidFill BackColor, Cast(GpSolidFill Ptr Ptr, @hBrush)
			If bBorder Then GdipCreatePen1 BorderColor, 1 * nScale, &H2, @hPen
			
			If Round = 0 Then
				With Rect
					GdipFillRectangleI hGraphics, hBrush, .X, .Y, .Width, .Height
					If hPen Then GdipDrawRectangleI hGraphics, hPen, .X, .Y, .Width, .Height
				End With
			Else
				If GdipCreatePath(&H0, @mPath) = 0 Then
					Round = Round * 2
					With Rect
						GdipAddPathArcI mPath, .X, .Y, Round, Round, 180, 90
						GdipAddPathArcI mPath, .X + .Width - Round, .Y, Round, Round, 270, 90
						GdipAddPathArcI mPath, .X + .Width - Round, .Y + .Height - Round, Round, Round, 0, 90
						GdipAddPathArcI mPath, .X, .Y + .Height - Round, Round, Round, 90, 90
						GdipClosePathFigure mPath
					End With
					GdipFillPath hGraphics, hBrush, mPath
					If hPen Then GdipDrawPath hGraphics, hPen, mPath
					GdipDeletePath(mPath)
				End If
			End If
			
			GdipDeleteBrush(hBrush)
			If hPen Then GdipDeletePen(hPen)
			
		End Sub
	
		Private Function Chart.ShiftColor(ByVal clrFirst As Long, ByVal clrSecond As Long, ByVal lAlpha As Long) As Long
			'Return 0
			Dim clrFore(3)         As ColorREF
			Dim clrBack(3)         As ColorREF
			
			OleTranslateColor clrFirst, 0, VarPtr(clrFore(0))
			OleTranslateColor clrSecond, 0, VarPtr(clrBack(0))
			
			clrFore(0) = (clrFore(0) * lAlpha + clrBack(0) * (255 - lAlpha)) / 255
			clrFore(1) = (clrFore(1) * lAlpha + clrBack(1) * (255 - lAlpha)) / 255
			clrFore(2) = (clrFore(2) * lAlpha + clrBack(2) * (255 - lAlpha)) / 255
			
			Dim lShiftColor As Long
			
			memcpy @lShiftColor, VarPtr(clrFore(0)), 4
			
			Return lShiftColor
			
		End Function
	
		Private Function Chart.IsDarkColor(ByVal lColor As Long) As Boolean
			Dim bBGRA(0 To 3) As Byte
			OleTranslateColor lColor, 0, VarPtr(lColor)
			CopyMemory(@bBGRA(0), @lColor, 4&)
			
			IsDarkColor = ((CLng(bBGRA(0)) + (CLng(bBGRA(1) * 3)) + CLng(bBGRA(2))) / 2) < 382
			
		End Function
	#endif
	
	Private Sub Chart.Example()
		Me.AddItem "Juan", 70, clRed
		Me.AddItem "Adan", 20, clGreen
		Me.AddItem "Pedro", 10, clBlue
	End Sub
	
	#ifndef __USE_GTK__
		Sub Chart.HandleIsAllocated(ByRef Sender As My.Sys.Forms.Control)
			With QChart(@Sender)
				.HotItem = -1
				.nScale = .GetWindowsDPI
				'.m_TitleFont = New My.SYs.FornFont
				If .Parent <> 0 Then .c_lhWnd = .Parent->Handle
				.m_FontSize = .Font.Size
				.m_TitleFontSize = .m_TitleFont.Size
				.m_Width = .Width
				.m_Height = .Height
				If .DesignMode Then .Example
				.ManageGDIToken(.c_lhWnd)
			End With
		End Sub
		
		Sub Chart.WndProc(ByRef Message As Message)
		End Sub
	#endif
	
	Sub Chart.ProcessMessage(ByRef Message As Message)
		Static DownButton As Integer = -1
		Dim As Integer HitResult
		#ifndef __USE_GTK__
			Select Case Message.Msg
			Case WM_ERASEBKGND
				Message.Result = 0
				Exit Sub 
			Case WM_PAINT
				Dim ps As PAINTSTRUCT
				Dim Dc As HDC
				Dim As HDC bufDC
				Dim As HBITMAP bufBMP
				Dim As Integer mClientWidth = This.ClientWidth, mClientHeight = This.ClientHeight
				Dc = BeginPaint(This.Handle, @ps)
				bufDC = CreateCompatibleDC(Dc)
				bufBMP = CreateCompatibleBitmap(Dc, mClientWidth, mClientHeight)
				SelectObject(bufDC, bufBMP)
				This.Paint bufDC
				BitBlt(Dc, 0, 0, mClientWidth, mClientHeight, bufDC, 0, 0, SRCCOPY)
				DeleteDc bufDC
				DeleteObject bufBMP
				EndPaint(This.Handle, @ps)
				Message.Result = 0
				Exit Sub
			Case WM_SIZE: 
				Font.Size = Max(m_FontSize, m_FontSize * This.Height / m_Height)
				m_TitleFont.Size = Max(m_TitleFontSize, (m_TitleFontSize) * This.Height / m_Height)
			Case WM_LBUTTONDOWN: DownButton = 0
			Case WM_RBUTTONDOWN: DownButton = 1
			Case WM_MBUTTONDOWN: DownButton = 2
			Case WM_LBUTTONUP: MouseUp DownButton, Message.wParam And &HFFFF, Message.lParamLo, Message.lParamHi: DownButton = -1
			Case WM_RBUTTONUP: MouseUp DownButton, Message.wParam And &HFFFF, Message.lParamLo, Message.lParamHi: DownButton = -1
			Case WM_MBUTTONUP: MouseUp DownButton, Message.wParam And &HFFFF, Message.lParamLo, Message.lParamHi: DownButton = -1
			Case WM_MOUSEMOVE: MouseMove DownButton, Message.wParam And &HFFFF, Message.lParamLo, Message.lParamHi
			Case WM_NCHITTEST: HitTest Message.lParamLo, Message.lParamHi, HitResult
			End Select
		#endif
		Base.ProcessMessage(Message)
	End Sub
	
	Operator Chart.Cast As My.Sys.Forms.Control Ptr
		Return Cast(My.Sys.Forms.Control Ptr, @This)
	End Operator
	
	Constructor Chart
		With This
			WLet(FClassName, "Chart")
			#ifdef __USE_GTK__
				widget = gtk_layout_new(NULL, NULL)
				.RegisterClass "Chart", @This
			#else
				.Style        = WS_CHILD
				.ExStyle      = 0
				.RegisterClass "Chart", ""
				.ChildProc    = @WndProc
				.OnHandleIsAllocated = @HandleIsAllocated
			#endif
			.Width        = 175
			.Height       = 21
			.Child        = @This
			.Canvas.Ctrl = @This
			.InitProperties()
			.tmrMOUSEOVER.Designer = @This
			.tmrMOUSEOVER.Interval = 0
			.tmrMOUSEOVER.OnTimer = @tmrMOUSEOVER_Timer_
			.tmrMOUSEOVER.Enabled = True
		End With
	End Constructor
	
	Destructor Chart
		#ifndef __USE_GTK__
			Dim i As Long
			For i = 0 To ItemsCount - 1
				GdipDeletePath m_Item(i).hPath
			Next
			If gToken Then
				GdiplusShutdown(gToken)
			End If
			'UnregisterClass "Chart",GetModuleHandle(NULL)
		#endif
	End Destructor
End Namespace


