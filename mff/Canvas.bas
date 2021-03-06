﻿'################################################################################
'#  Canvas.bi                                                                   #
'#  This file is part of MyFBFramework                                          #
'#  Authors: Nastase Eodor, Xusinboy Bekchanov, Liu XiaLin                      #
'#  Based on:                                                                   #
'#   TCanvas.bi                                                                 #
'#   FreeBasic Windows GUI ToolKit                                              #
'#   Copyright (c) 2007-2008 Nastase Eodor                                      #
'#   Version 1.0.0                                                              #
'################################################################################

#include once "Canvas.bi"

Namespace My.Sys.Drawing
	Function Canvas.ReadProperty(ByRef PropertyName As String) As Any Ptr
		Select Case LCase(PropertyName)
		Case "pen": Return @Pen
		Case "brush": Return @Brush
		Case "font": Return @Font
		Case "clip": Return @Clip
		Case "copymode": Return @CopyMode
			#ifdef __USE_GTK__
			Case "handle": Return Handle
			#else
			Case "handle": Return @Handle
			#endif
		Case "height": iTemp = This.Height: Return @iTemp
		Case "width": iTemp = This.Width: Return @iTemp
		Case Else: Return Base.ReadProperty(PropertyName)
		End Select
		Return 0
	End Function
	
	Function Canvas.WriteProperty(ByRef PropertyName As String, Value As Any Ptr) As Boolean
		Select Case LCase(PropertyName)
		Case "clip": This.Clip = QBoolean(Value)
		Case "copymode": This.CopyMode = QInteger(Value)
		Case Else: Return Base.WriteProperty(PropertyName, Value)
		End Select
		Return True
	End Function
	
	Property Canvas.Width As Integer
		If ParentControl Then
			Return ParentControl->Width
		End If
	End Property
	
	Property Canvas.Height As Integer
		If ParentControl Then
			Return ParentControl->Height
		End If
	End Property
	
	Property Canvas.Ctrl As My.Sys.ComponentModel.Component Ptr
		Return ParentControl
	End Property
	
	Property Canvas.Ctrl(Value As My.Sys.ComponentModel.Component Ptr)
		ParentControl = Value
		If ParentControl Then
			'ParentControl->Canvas = @This
			'			If *Ctrl Is My.Sys.Forms.Control Then
			'				Brush.Color = Cast(My.Sys.Forms.Control Ptr, Ctrl)->BackColor
			'			End If
		End If
	End Property
	
	Property Canvas.Pixel(xy As Point) As Integer
		GetDevice
		#ifndef __USE_GTK__
			Return .GetPixel(Handle,xy.x,xy.y)
		#else
			Return 0
		#endif
		ReleaseDevice
	End Property
	
	Property Canvas.Pixel(xy As Point, Value As Integer)
		GetDevice
		#ifdef __USE_GTK__
			cairo_set_source_rgb(Handle, GetRed(Value) / 255.0, GetBlue(Value) / 255.0, GetGreen(Value) / 255.0)
			.cairo_rectangle(Handle, xy.x, xy.y, 1, 1)
			cairo_fill(Handle)
		#else
			.SetPixel(Handle,xy.x,xy.y,Value)
		#endif
		ReleaseDevice
	End Property
	
	Sub Canvas.GetDevice
		If ParentControl Then
			#ifdef __USE_GTK__
				If ParentControl->Widget Then
					pcontext = gtk_widget_create_pango_context(ParentControl->Widget)
					layout = pango_layout_new(pcontext)
					pango_layout_set_font_description (layout, Font.Handle)
					If Not HandleSetted Then
						If ParentControl->layoutwidget Then
							Handle = gdk_cairo_create(gtk_layout_get_bin_window(gtk_layout(ParentControl->layoutwidget)))
						End If
					End If
				End If
			#else
				If ParentControl->Handle Then
					If Not HandleSetted Then
						If Clip Then
							Handle = GetDcEx(ParentControl->Handle,0,DCX_PARENTCLIP Or DCX_CACHE)
						Else
							Handle = GetDc(ParentControl->Handle)
						End If
					End If
					SelectObject(Handle,Font.Handle)
					SelectObject(Handle,Pen.Handle)
					SelectObject(Handle,Brush.Handle)
					SetROP2 Handle,Pen.Mode
				End If
			#endif
		End If
	End Sub
	
	Sub Canvas.ReleaseDevice
		If HandleSetted Then Exit Sub
		#ifdef __USE_GTK__
			If Handle Then cairo_destroy(Handle)
		#else
			If ParentControl Then If Handle Then ReleaseDc ParentControl->Handle,Handle
		#endif
	End Sub
	
	Sub Canvas.MoveTo(x As Integer,y As Integer)
		GetDevice
		#ifdef __USE_GTK__
			cairo_move_to(Handle, x - 0.5, y - 0.5)
		#else
			.MoveToEx Handle,x,y,0
		#endif
		ReleaseDevice
	End Sub
	
	Sub Canvas.LineTo(x As Integer,y As Integer)
		GetDevice
		#ifdef __USE_GTK__
			cairo_line_to(Handle, x - 0.5, y - 0.5)
			cairo_stroke(Handle)
		#else
			.LineTo Handle,x,y
		#endif
		ReleaseDevice
	End Sub
	
	Sub Canvas.Line(x As Integer,y As Integer,x1 As Integer,y1 As Integer)
		GetDevice
		#ifdef __USE_GTK__
			cairo_move_to(Handle, x - 0.5, y - 0.5)
			cairo_line_to(Handle, x1 - 0.5, y1 - 0.5)
			cairo_stroke(Handle)
		#else
			.MoveToEx Handle,x,y,0
			.LineTo Handle,x1,y1
		#endif
		ReleaseDevice
	End Sub
	
	Sub Canvas.Rectangle Overload(x As Integer,y As Integer,x1 As Integer,y1 As Integer)
		GetDevice
		#ifdef __USE_GTK__
			cairo_move_to (Handle, x - 0.5, y - 0.5)
			cairo_line_to (Handle, x1 - 0.5, y - 0.5)
			cairo_line_to (Handle, x1 - 0.5, y1 - 0.5)
			cairo_line_to (Handle, x - 0.5, y1 - 0.5)
			cairo_line_to (Handle, x - 0.5, y - 0.5)
			cairo_set_source_rgb(Handle, GetRedD(Brush.Color), GetGreenD(Brush.Color), GetBlueD(Brush.Color))
			cairo_fill_preserve(Handle)
			cairo_set_source_rgb(Handle, GetRedD(Pen.Color), GetGreenD(Pen.Color), GetBlueD(Pen.Color))
			cairo_stroke(Handle)
		#else
			.Rectangle Handle,x,y,x1,y1
		#endif
		ReleaseDevice
	End Sub
	
	Sub Canvas.Rectangle(R As Rect)
		GetDevice
		#ifdef __USE_GTK__
			.cairo_rectangle(Handle, R.Left - 0.5, R.Top - 0.5, R.Right - R.Left - 0.5, R.Bottom - R.Top - 0.5)
			cairo_set_source_rgb(Handle, GetRedD(Brush.Color), GetGreenD(Brush.Color), GetBlueD(Brush.Color))
			cairo_fill_preserve(Handle)
			cairo_set_source_rgb(Handle, GetRedD(Pen.Color), GetGreenD(Pen.Color), GetBlueD(Pen.Color))
			cairo_stroke(Handle)
		#else
			.Rectangle Handle, R.Left, R.Top, R.Right, R.Bottom
		#endif
		ReleaseDevice
	End Sub
	
	Sub Canvas.Ellipse Overload(x As Integer,y As Integer,x1 As Integer,y1 As Integer)
		GetDevice
		#ifdef __USE_GTK__
			cairo_arc(Handle, x + (x1 - x) / 2 - 0.5, y + (y1 - y) / 2 - 0.5, (x1 - x) / 2, 0, 2 * G_PI)
			cairo_fill_preserve(Handle)
			'			cairo_set_source_rgb(cr, 0.0, 0.0, 0.0)
			'			cairo_stroke(cr)
		#else
			.Ellipse Handle,x,y,x1,y1
		#endif
		ReleaseDevice
	End Sub
	
	Sub Canvas.Ellipse(R As Rect)
		GetDevice
		#ifdef __USE_GTK__
			cairo_arc(Handle, R.Left + (R.Right - R.Left) / 2 - 0.5, R.Top + (R.Bottom - R.Top) / 2 - 0.5, (R.Right - R.Left) / 2, 0, 2 * G_PI)
			cairo_fill_preserve(Handle)
		#else
			.Ellipse Handle,R.Left,R.Top,R.Right,R.Bottom
		#endif
		ReleaseDevice
	End Sub
	
	Sub Canvas.RoundRect Overload(x As Integer,y As Integer,x1 As Integer,y1 As Integer,nWidth As Integer,nHeight As Integer)
		GetDevice
		#ifdef __USE_GTK__
			Var radius = x1 - x
			cairo_move_to Handle, x - 0.5, y + nWidth / 2 - 0.5
			cairo_arc (Handle, x + radius - 0.5, y + nWidth / 2 - 0.5, nWidth / 2, G_PI, -G_PI / 2)
			cairo_line_to (Handle, x + nWidth - nWidth / 2 - 0.5, y - 0.5)
			cairo_arc (Handle, x + nWidth - nWidth / 2 - 0.5, y + nWidth / 2 - 0.5, nWidth / 2, -G_PI / 2, 0)
			cairo_line_to (Handle, x + nWidth - 0.5, y + nHeight - nWidth / 2 - 0.5)
			cairo_arc (Handle, x + nWidth - nWidth / 2 - 0.5, y + nHeight - nWidth / 2 - 0.5, nWidth / 2, 0, G_PI / 2)
			cairo_line_to (Handle, x + nWidth / 2 - 0.5, y + nHeight - 0.5)
			cairo_arc (Handle, x + nWidth / 2 - 0.5, y + nHeight - nWidth / 2 - 0.5, nWidth / 2, G_PI / 2, G_PI)
			cairo_close_path Handle
			cairo_fill_preserve(Handle)
		#else
			.RoundRect Handle,x,y,x1,y1,nWidth,nHeight
		#endif
		ReleaseDevice
	End Sub
	
	Sub Canvas.Polygon(Points As Point Ptr,Count As Integer)
		GetDevice
		#ifndef __USE_GTK__
			.Polygon Handle, Points, Count
		#endif
		ReleaseDevice
	End Sub
	
	Sub Canvas.RoundRect(R As Rect,nWidth As Integer,nHeight As Integer)
		GetDevice
		#ifdef __USE_GTK__
			This.RoundRect R.Left, R.Top, R.Right, R.Bottom, nWidth, nHeight
		#else
			.RoundRect Handle,R.Left,R.Top,R.Right,R.Bottom,nWidth,nHeight
		#endif
		ReleaseDevice
	End Sub
	
	Sub Canvas.Chord(x As Integer,y As Integer,x1 As Integer,y1 As Integer,nXRadial1 As Integer,nYRadial1 As Integer,nXRadial2 As Integer,nYRadial2 As Integer)
		GetDevice
		#ifndef __USE_GTK__
			.Chord(Handle,x,y,x1,y1,nXRadial1,nYRadial1,nXRadial2,nYRadial2)
		#endif
		ReleaseDevice
	End Sub
	
	Sub Canvas.Pie(x As Integer,y As Integer,x1 As Integer,y1 As Integer,nXRadial1 As Integer,nYRadial1 As Integer,nXRadial2 As Integer,nYRadial2 As Integer)
		GetDevice
		#ifndef __USE_GTK__
			.Pie(Handle,x,y,x1,y1,nXRadial1,nYRadial1,nXRadial2,nYRadial2)
		#endif
		ReleaseDevice
	End Sub
	
	Sub Canvas.Arc(x As Integer,y As Integer,x1 As Integer,y1 As Integer,xStart As Integer, yStart As Integer,xEnd As Integer,yEnd As Integer)
		GetDevice
		#ifndef __USE_GTK__
			.Arc(Handle,x,y,x1,y1,xStart, yStart,xEnd,yEnd)
		#endif
		ReleaseDevice
	End Sub
	
	Sub Canvas.ArcTo(x As Integer,y As Integer,x1 As Integer,y1 As Integer,nXRadial1 As Integer,nYRadial1 As Integer,nXRadial2 As Integer,nYRadial2 As Integer)
		GetDevice
		#ifndef __USE_GTK__
			.ArcTo Handle,x,y,x1,y1,nXRadial1,nYRadial1,nXRadial2,nYRadial2
		#endif
		ReleaseDevice
	End Sub
	
	Sub Canvas.AngleArc(x As Integer,y As Integer,Radius As Integer,StartAngle As Single,SweepAngle As Single)
		GetDevice
		#ifndef __USE_GTK__
			.AngleArc Handle,x,y,Radius,StartAngle,SweepAngle
		#endif
		ReleaseDevice
	End Sub
	
	Sub Canvas.Polyline(Points As Point Ptr,Count As Integer)
		GetDevice
		#ifndef __USE_GTK__
			.Polyline Handle,Points,Count
		#endif
		ReleaseDevice
	End Sub
	
	Sub Canvas.PolylineTo(Points As Point Ptr,Count As Integer)
		GetDevice
		#ifndef __USE_GTK__
			.PolylineTo Handle,Points,Count
		#endif
		ReleaseDevice
	End Sub
	
	Sub Canvas.PolyBeizer(Points As Point Ptr,Count As Integer)
		GetDevice
		#ifndef __USE_GTK__
			.PolyBezier Handle,Points,Count
		#endif
		ReleaseDevice
	End Sub
	
	Sub Canvas.PolyBeizerTo(Points As Point Ptr,Count As Integer)
		GetDevice
		#ifndef __USE_GTK__
			.PolyBezierTo Handle,Points,Count
		#endif
		ReleaseDevice
	End Sub
	
	Sub Canvas.SetPixel(x As Integer,y As Integer,PixelColor As Integer)
		GetDevice
		#ifdef __USE_GTK__
			cairo_set_source_rgb(Handle, GetRed(PixelColor) / 255.0, GetBlue(PixelColor) / 255.0, GetGreen(PixelColor) / 255.0)
			.cairo_rectangle(Handle, x, y, 1, 1)
			cairo_fill(Handle)
		#else
			.SetPixel Handle,x,y,PixelColor
		#endif
		ReleaseDevice
	End Sub
	
	Function Canvas.GetPixel(x As Integer,y As Integer) As Integer
		GetDevice
		#ifndef __USE_GTK__
			Return .GetPixel(Handle,x,y)
		#else
			Return 0
		#endif
		ReleaseDevice
	End Function
	
	Sub Canvas.TextOut(x As Integer,y As Integer,ByRef s As WString,FG As Integer,BK As Integer)
		GetDevice
		#ifdef __USE_GTK__
			Dim As PangoRectangle extend2
			Dim As Double iRed, iGreen, iBlue
			pango_layout_set_text(layout, ToUTF8(s), Len(ToUTF8(s)))
			pango_cairo_update_layout(Handle, layout)
			#ifdef PANGO_VERSION
				Dim As PangoLayoutLine Ptr pl = pango_layout_get_line_readonly(layout, 0)
			#else
				Dim As PangoLayoutLine Ptr pl = pango_layout_get_line(layout, 0)
			#endif
			If BK <> -1 Then
				pango_layout_line_get_pixel_extents(pl, NULL, @extend2)
				iRed = Abs(GetRed(BK) / 255.0): iGreen = Abs(GetGreen(BK) / 255.0): iBlue = Abs(GetBlue(BK) / 255.0)
				cairo_set_source_rgb(Handle, iRed, iGreen, iBlue)
				.cairo_rectangle (Handle, x, y, extend2.width, extend2.height)
				cairo_fill (Handle)
			End If
			cairo_move_to(Handle, x + 0.5, y + extend2.height + 0.5)
			iRed = Abs(GetRed(FG) / 255.0): iGreen = Abs(GetGreen(FG) / 255.0): iBlue = Abs(GetBlue(FG) / 255.0)
			cairo_set_source_rgb(Handle, iRed, iGreen, iBlue)
			pango_cairo_show_layout_line(Handle, pl)
		#else
			If BK = -1 Then
				SetBKMode(Handle,TRANSPARENT)
				SetTextColor(Handle,FG)
				.TextOut(Handle,X,Y,@s,Len(s))
				SetBKMode(Handle,OPAQUE)
			Else
				SetBKColor(Handle,BK)
				SetTextColor(Handle,FG)
				.TextOut(Handle,X,Y,@s,Len(s))
			End If
		#endif
		ReleaseDevice
	End Sub
	
	Sub Canvas.Draw(x As Integer, y As Integer, Image As Any Ptr)
		GetDevice
		#ifndef __USE_GTK__
			Dim As HDC MemDC
			Dim As HBITMAP OldBitmap
			Dim As BITMAP Bitmap01
			MemDC = CreateCompatibleDC(Handle)
			OldBitmap = SelectObject(MemDC, Cast(HBitmap, Image))
			GetObject(Cast(HBitmap, Image), SizeOf(Bitmap01), @Bitmap01)
			BitBlt(Handle, x, y, Bitmap01.bmWidth, Bitmap01.bmHeight, MemDC, 0, 0, SRCCOPY)
			SelectObject(MemDC, OldBitmap)
			DeleteDC(MemDC)
		#endif
		ReleaseDevice
	End Sub
	
	Sub Canvas.DrawTransparent(x As Integer, y As Integer, Image As Any Ptr, cTransparentColor As UInteger = 0)
		GetDevice
		#ifndef __USE_GTK__
			Dim As BITMAP     bm
			Dim As COLORREF   cColor
			Dim As HBITMAP    bmAndBack, bmAndObject, bmAndMem, bmSave
			Dim As HBITMAP    bmBackOld, bmObjectOld, bmMemOld, bmSaveOld
			Dim As HDC        hdcMem, hdcBack, hdcObject, hdcTemp, hdcSave
			Dim As Point      ptSize
			
			hdcTemp = CreateCompatibleDC(Handle)
			SelectObject(hdcTemp, Cast(HBitmap, Image))   ' Выбираем битмап
			
			GetObject(Cast(HBitmap, Image), SizeOf(BITMAP), Cast(LPSTR, @bm))
			ptSize.x = bm.bmWidth            ' Получаем ширину битмапа
			ptSize.y = bm.bmHeight           ' Получаем высоту битмапа
			DPtoLP(hdcTemp, @ptSize, 1)      ' Конвертируем из координат
			' устройства в логические
			' точки
			
			' Создаём несколько DC для хранения временных данных.
			hdcBack   = CreateCompatibleDC(Handle)
			hdcObject = CreateCompatibleDC(Handle)
			hdcMem    = CreateCompatibleDC(Handle)
			hdcSave   = CreateCompatibleDC(Handle)
			
			' Создаём битмап для каждого DC.
			
			' Монохромный DC
			bmAndBack   = CreateBitmap(ptSize.x, ptSize.y, 1, 1, NULL)
			
			' Монохромный DC
			bmAndObject = CreateBitmap(ptSize.x, ptSize.y, 1, 1, NULL)
			
			bmAndMem    = CreateCompatibleBitmap(Handle, ptSize.x, ptSize.y)
			bmSave      = CreateCompatibleBitmap(Handle, ptSize.x, ptSize.y)
			
			' В каждом DC должен быть выбран объект битмапа для хранения
			' пикселей.
			bmBackOld   = SelectObject(hdcBack, bmAndBack)
			bmObjectOld = SelectObject(hdcObject, bmAndObject)
			bmMemOld    = SelectObject(hdcMem, bmAndMem)
			bmSaveOld   = SelectObject(hdcSave, bmSave)
			
			' Устанавливаем режим маппинга.
			SetMapMode(hdcTemp, GetMapMode(Handle))
			
			' Сохраняем битмап, переданный в параметре функции, так как
			' он будет изменён.
			BitBlt(hdcSave, 0, 0, ptSize.x, ptSize.y, hdcTemp, 0, 0, SRCCOPY)
			
			' Устанавливаем фоновый цвет (в исходном DC) тех частей,
			' которые будут прозрачными.
			cColor = SetBkColor(hdcTemp, cTransparentColor)
			
			' Создаём маску для битмапа путём вызова BitBlt из исходного
			' битмапа на монохромный битмап.
			BitBlt(hdcObject, 0, 0, ptSize.x, ptSize.y, hdcTemp, 0, 0, SRCCOPY)
			
			' Устанавливаем фоновый цвет исходного DC обратно в
			' оригинальный цвет.
			SetBkColor(hdcTemp, cColor)
			
			' Создаём инверсию маски.
			BitBlt(hdcBack, 0, 0, ptSize.x, ptSize.y, hdcObject, 0, 0, NOTSRCCOPY)
			
			' Копируем фон главного DC в конечный.
			BitBlt(hdcMem, 0, 0, ptSize.x, ptSize.y, Handle, x, y, SRCCOPY)
			
			' Накладываем маску на те места, где будет помещён битмап.
			BitBlt(hdcMem, 0, 0, ptSize.x, ptSize.y, hdcObject, 0, 0, SRCAND)
			
			' Накладываем маску на прозрачные пиксели битмапа.
			BitBlt(hdcTemp, 0, 0, ptSize.x, ptSize.y, hdcBack, 0, 0, SRCAND)
			
			' Xor-им битмап с фоном на конечном DC.
			BitBlt(hdcMem, 0, 0, ptSize.x, ptSize.y, hdcTemp, 0, 0, SRCPAINT)
			
			' Копируем на экран.
			BitBlt(Handle, x, y, ptSize.x, ptSize.y, hdcMem, 0, 0, SRCCOPY)
			
			' Помещаем оригинальный битмап обратно в битмап, переданный в
			' параметре функции.
			BitBlt(hdcTemp, 0, 0, ptSize.x, ptSize.y, hdcSave, 0, 0, SRCCOPY)
			
			' Удаляем битмапы из памяти.
			DeleteObject(SelectObject(hdcBack, bmBackOld))
			DeleteObject(SelectObject(hdcObject, bmObjectOld))
			DeleteObject(SelectObject(hdcMem, bmMemOld))
			DeleteObject(SelectObject(hdcSave, bmSaveOld))
			
			' Удаляем DC из памяти.
			DeleteDC(hdcMem)
			DeleteDC(hdcBack)
			DeleteDC(hdcObject)
			DeleteDC(hdcSave)
			DeleteDC(hdcTemp)
		#endif
		ReleaseDevice
	End Sub
	
	Sub Canvas.StretchDraw(x As Integer,y As Integer,nWidth As Integer,nHeight As Integer,Image As Any Ptr)
		GetDevice
		#ifndef __USE_GTK__
			Dim As HDC MemDC
			Dim As HBITMAP OldBitmap
			Dim As BITMAP Bitmap01
			MemDC = CreateCompatibleDC(Handle)
			OldBitmap = SelectObject(MemDC, Cast(HBitmap, Image))
			GetObject(Cast(HBitmap, Image), SizeOf(Bitmap01), @Bitmap01)
			StretchBlt(Handle, x, y, Bitmap01.bmWidth, Bitmap01.bmHeight, MemDC, 0, 0, nWidth, nHeight, SRCCOPY)
			SelectObject(MemDC, OldBitmap)
			DeleteDC(MemDC)
		#endif
		ReleaseDevice
	End Sub
	
	Sub Canvas.CopyRect(Dest As Rect,Canvas As Canvas,Source As Rect)
		GetDevice
		ReleaseDevice
	End Sub
	
	Sub Canvas.FloodFill(x As Integer, y As Integer, FillColor As Integer, FillStyle As FillStyle)
		GetDevice
		#ifndef __USE_GTK__
			.ExtFloodFill Handle, x, y, FillColor, FillStyle
		#endif
		ReleaseDevice
	End Sub
	
	Sub Canvas.FillRect(R As Rect,FillColor As Integer = -1)
		#ifdef __USE_GTK__
			cairo_set_source_rgb(Handle, GetRed(FillColor), GetBlue(FillColor), GetGreen(FillColor))
			cairo_fill_preserve(Handle)
		#else
			Static As HBRUSH B
			GetDevice
			If B Then DeleteObject B
			If FillColor <> -1 Then
				B = CreateSolidBrush(FillColor)
				.FillRect Handle,@R,B
			Else
				.FillRect Handle,@R,Brush.Handle
			End If
		#endif
		ReleaseDevice
	End Sub
	
	Sub Canvas.DrawFocusRect(R As Rect)
		GetDevice
		#ifndef __USE_GTK__
			.DrawFocusRect Handle,@R
		#endif
		ReleaseDevice
	End Sub
	
	Function Canvas.TextWidth(ByRef FText As WString) As Integer
		#ifdef __USE_GTK__
			Dim As PangoRectangle extend
			Dim As PangoFontDescription Ptr desc
			desc = pango_font_description_from_string(Font.Name & " " & Font.Size)
			pango_layout_set_font_description (layout, desc)
			pango_layout_set_text(layout, ToUTF8(FText), Len(ToUTF8(FText)))
			pango_cairo_update_layout(Handle, layout)
			#ifdef PANGO_VERSION
				Dim As PangoLayoutLine Ptr pl = pango_layout_get_line_readonly(layout, 0)
			#else
				Dim As PangoLayoutLine Ptr pl = pango_layout_get_line(layout, 0)
			#endif
			pango_layout_line_get_pixel_extents(pl, NULL, @extend)
			pango_font_description_free (desc)
			Return extend.Width
		#else
			Dim Sz As SIZE
			GetDevice
			GetTextExtentPoint32(Handle,@FText,Len(FText),@Sz)
			ReleaseDevice
			Return Sz.cX
		#endif
	End Function
	
	Function Canvas.TextHeight(ByRef FText As WString) As Integer
		#ifdef __USE_GTK__
			Dim As PangoRectangle extend
			Dim As PangoFontDescription Ptr desc
			desc = pango_font_description_from_string(Font.Name & " " & Font.Size)
			pango_layout_set_font_description (layout, desc)
			pango_layout_set_text(layout, ToUTF8(FText), Len(ToUTF8(FText)))
			pango_cairo_update_layout(Handle, layout)
			#ifdef PANGO_VERSION
				Dim As PangoLayoutLine Ptr pl = pango_layout_get_line_readonly(layout, 0)
			#else
				Dim As PangoLayoutLine Ptr pl = pango_layout_get_line(layout, 0)
			#endif
			pango_layout_line_get_pixel_extents(pl, NULL, @extend)
			pango_font_description_free (desc)
			Return extend.Height
		#else
			Dim Sz As SIZE
			GetDevice
			GetTextExtentPoint32(Handle,@FText,Len(FText),@Sz)
			ReleaseDevice
			Return Sz.cY
		#endif
	End Function
	
	Operator Canvas.Cast As Any Ptr
		Return @This
	End Operator
	
	Constructor Canvas
		Clip = False
		WLet(FClassName, "Canvas")
	End Constructor
	
	Destructor Canvas
		#ifndef __USE_GTK__
			If Handle Then ReleaseDevice
		#endif
	End Destructor
End Namespace
