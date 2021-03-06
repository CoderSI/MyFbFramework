﻿'###############################################################################
'#  ToolBar.bi                                                                 #
'#  This file is part of MyFBFramework                                         #
'#  Authors: Nastase Eodor, Xusinboy Bekchanov                                 #
'#  Based on:                                                                  #
'#   TToolBar.bi                                                               #
'#   FreeBasic Windows GUI ToolKit                                             #
'#   Copyright (c) 2007-2008 Nastase Eodor                                     #
'#   Version 1.0.0                                                             #
'#  Updated and added cross-platform                                           #
'#  by Xusinboy Bekchanov (2018-2019)                                          #
'###############################################################################

#include once "ToolBar.bi"

Namespace My.Sys.Forms
	Function ToolButton.ReadProperty(ByRef PropertyName As String) As Any Ptr
		Select Case LCase(PropertyName)
		Case "caption": Return FCaption
		Case "checked": Return @FChecked
		Case "commandid": Return @FCommandID
		Case "dropdownmenu": Return @DropdownMenu
		Case "enabled": Return @FEnabled
		Case "hint": Return FHint
		Case "imageindex": Return @FImageIndex
		Case "imagekey": Return FImageKey
		Case "left": FButtonLeft = This.Left: Return @FButtonLeft
		Case "top": FButtonTop = This.Top: Return @FButtonTop
		Case "name": Return FName
		Case "showhint": Return @FShowHint
		Case "state": Return @FState
		Case "style": Return @FStyle
		Case "tag": Return This.Tag
		Case "visible": Return @FVisible
		Case "width": FButtonWidth = This.Width: Return @FButtonWidth
		Case "height": FButtonHeight = This.Height: Return @FButtonHeight
		Case "parent": Return Ctrl
		Case Else: Return Base.ReadProperty(PropertyName)
		End Select
		Return 0
	End Function

	Function ToolButton.WriteProperty(ByRef PropertyName As String, Value As Any Ptr) As Boolean
		If Value = 0 Then
			Select Case LCase(PropertyName)
			Case "parent": This.Parent = Value
			Case Else: Return Base.WriteProperty(PropertyName, Value)
			End Select
		Else
			Select Case LCase(PropertyName)
			Case "caption": This.Caption = QWString(Value)
			Case "checked": This.Checked = QBoolean(Value)
			Case "commandid": This.CommandID = QInteger(Value)
			Case "enabled": This.Enabled = QBoolean(Value)
			Case "hint": This.Hint = QWString(Value)
			Case "imageindex": This.ImageIndex = QInteger(Value)
			Case "imagekey": This.ImageKey = QWString(Value)
			Case "left": This.Left = QInteger(Value)
			Case "top": This.Top = QInteger(Value)
			Case "name": This.Name = QWString(Value)
			Case "showhint": This.ShowHint = QBoolean(Value)
			Case "state": This.State = QInteger(Value)
			Case "style": This.Style = QInteger(Value)
			Case "tag": This.Tag = Value
			Case "parent": This.Parent = Value
			Case "visible": This.Visible = QBoolean(Value)
			Case Else: Return Base.WriteProperty(PropertyName, Value)
			End Select
		End If
		Return True
	End Function
	
	Function ToolBar.ReadProperty(ByRef PropertyName As String) As Any Ptr
		Select Case LCase(PropertyName)
		Case "autosize": Return @FAutosize
		Case "caption": Return FText.vptr
		Case "flat": Return @FFlat
		Case "list": Return @FList
		Case "wrapable": Return @FWrapable
		Case "transparency": Return @FTransparent
		Case "disabledimageslist": Return DisabledImagesList
		Case "hotimageslist": Return HotImagesList
		Case "imageslist": Return ImagesList
		Case "divider": Return @FDivider
		Case "bitmapwidth": FBitmapWidth = This.BitmapWidth: Return @FBitmapWidth
		Case "bitmapheight": FBitmapHeight = This.BitmapHeight: Return @FBitmapHeight
		Case "buttonwidth": FButtonWidth = This.ButtonWidth: Return @FButtonWidth
		Case "buttonheight": FButtonHeight = This.ButtonHeight: Return @FButtonHeight
		Case "buttonscount": FButtonsCount = Buttons.Count: Return @FButtonsCount
		Case Else: Return Base.ReadProperty(PropertyName)
		End Select
		Return 0
	End Function
	
	Function ToolBar.WriteProperty(ByRef PropertyName As String, Value As Any Ptr) As Boolean
		If Value = 0 Then
			Select Case LCase(PropertyName)
			Case Else: Return Base.WriteProperty(PropertyName, Value)
			End Select
		Else
			Select Case LCase(PropertyName)
			Case "autosize": This.Autosize = QBoolean(Value)
			Case "bitmapwidth": This.BitmapWidth = QInteger(Value)
			Case "bitmapheight": This.BitmapHeight = QInteger(Value)
			Case "buttonwidth": This.ButtonWidth = QInteger(Value)
			Case "buttonheight": This.ButtonHeight = QInteger(Value)
			Case "caption": This.Caption = QWString(Value)
			Case "flat": This.Flat = QBoolean(Value)
			Case "list": This.List = QBoolean(Value)
			Case "disabledimageslist": This.DisabledImagesList = Value
			Case "hotimageslist": This.HotImagesList = Value
			Case "imageslist": This.ImagesList = Value
			Case "divider": This.Divider = QBoolean(Value)
			Case "transparency": This.Transparency = QBoolean(Value)
			Case "wrapable": This.Wrapable = QBoolean(Value)
			Case Else: Return Base.WriteProperty(PropertyName, Value)
			End Select
		End If
		Return True
	End Function
	
	Sub ToolBar.GetDropDownMenuItems
		FPopupMenuItems.Clear
		For j As Integer = 0 To Buttons.Count - 1
			For i As Integer = 0 To Buttons.Item(j)->DropDownMenu.Count -1
				EnumPopupMenuItems *Buttons.Item(j)->DropDownMenu.Item(i)
			Next i
		Next j
	End Sub
	
	Function ToolButton.ToString ByRef As WString
		Return This.Name
	End Function
	
	Property ToolButton.Caption ByRef As WString
		Return *FCaption
	End Property
	
	Property ToolButton.Caption(ByRef Value As WString)
		Dim As Integer i
		If Value <> *FCaption Then
			WLet(FCaption, Value)
			#ifndef __USE_GTK__
				Dim As TBBUTTON TB
				If Ctrl Then
					With QControl(Ctrl)
						i = .Perform(TB_COMMANDTOINDEX,FCommandID,0)
						.Perform(TB_GETBUTTON,i,CInt(@TB))
						If *FCaption <> "" Then
							TB.iString = CInt(FCaption)
						Else
							TB.iString = 0
						End If
						.Perform(TB_INSERTBUTTON, i, CInt(@TB))
						.Perform(TB_DELETEBUTTON, i + 1, 0)
					End With
				End If
			#endif
		End If
	End Property
	
	Property ToolButton.Name ByRef As WString
		Return WGet(FName)
	End Property
	
	Property ToolButton.Name(ByRef Value As WString)
		WLet(FName, Value)
		DropDownMenu.Name = *FName & ".DropDownMenu"
	End Property

	Property ToolButton.Parent As Control Ptr
		Return Ctrl
	End Property
	
	Property ToolButton.Parent(Value As Control Ptr)
		If Ctrl <> 0 AndAlso Ctrl <> Value Then
			Dim As Integer Index = Cast(ToolBar Ptr, Ctrl)->Buttons.IndexOf(@This)
			If Index > -1 Then Cast(ToolBar Ptr, Ctrl)->Buttons.Remove Index
		End If
		Ctrl = Value
		Cast(ToolBar Ptr, Ctrl)->Buttons.Add @This
	End Property

	Property ToolButton.Hint ByRef As WString
		Return *FHint
	End Property
	
	Property ToolButton.Hint(ByRef Value As WString)
		FHint = Reallocate_(FHint, (Len(Value) + 1) * SizeOf(WString))
		*FHint = Value
	End Property
	
	Property ToolButton.ShowHint As Boolean
		Return FShowHint
	End Property
	
	Property ToolButton.ShowHint(Value As Boolean)
		FShowHint = Value
	End Property
	
	Property ToolButton.ImageIndex As Integer
		Return FImageIndex
	End Property
	
	Property ToolButton.ImageIndex(Value As Integer)
		If Value <> FImageIndex Then
			FImageIndex = Value
			If Ctrl Then
				With QControl(Ctrl)
					#ifndef __USE_GTK__
						.Perform(TB_CHANGEBITMAP, FCommandID, MakeLong(FImageIndex, 0))
					#endif
				End With
			End If
		End If
	End Property
	
	Property ToolButton.ImageKey ByRef As WString
		Return WGet(FImageKey)
	End Property
	
	Property ToolButton.ImageKey(ByRef Value As WString)
		WLet(FImageKey, Value)
		#ifdef __USE_GTK__
			If GTK_IS_TOOL_BUTTON(Widget) Then gtk_tool_button_set_icon_name(GTK_TOOL_BUTTON(Widget), Value)
		#else
			If Ctrl AndAlso QToolBar(Ctrl).ImagesList Then
				ImageIndex = QToolBar(Ctrl).ImagesList->IndexOf(Value)
			End If
		#endif
	End Property
	
	Property ToolButton.Style As Integer
		Return FStyle
	End Property
	
	Property ToolButton.Style(Value As Integer)
		If Value <> FStyle Then
			FStyle = Value
			#ifndef __USE_GTK__
				If Ctrl AndAlso Ctrl->Handle Then
					Dim As TBBUTTONINFO info
					info.cbSize = SizeOf(info)
					info.dwMask = TBIF_STYLE
					info.idCommand = FCommandID
					info.fsStyle = Value
					Ctrl->Perform(TB_SETBUTTONINFO, FCommandID, Cast(LParam, @info))
				End If
			#endif
			'If Ctrl AndAlso Ctrl->Handle Then QControl(Ctrl).RecreateWnd
		End If
	End Property
	
	Property ToolButton.State As Integer
		Return FState
	End Property
	
	Property ToolButton.State(Value As Integer)
		If Value <> FState Then
			FState = Value
			If Ctrl Then QControl(Ctrl).RecreateWnd
		End If
	End Property
	
	Property ToolButton.CommandID As Integer
		Return FCommandID
	End Property
	
	Property ToolButton.CommandID(Value As Integer)
		Dim As Integer i
		If Value <> FCommandID Then
			FCommandID = Value
			If Ctrl Then
				With QControl(Ctrl)
					#ifndef __USE_GTK__
						i = .Perform(TB_COMMANDTOINDEX,FCommandID,0)
						.Perform(TB_SETCMDID,i,FCommandID)
					#endif
				End With
			End If
		End If
	End Property
	
	Property ToolButton.Left As Integer
		#ifndef __USE_GTK__
			Dim As Rect R
			Dim As Integer i
			If Ctrl Then
				With QControl(Ctrl)
					If .Handle Then
						i = .Perform(TB_COMMANDTOINDEX,FCommandID,0)
						.Perform(TB_GETITEMRECT,I,CInt(@R))
						FButtonLeft = R.Left
					End If
				End With
			End If
		#endif
		Return FButtonLeft
	End Property
	
	Property ToolButton.Left(Value As Integer)
	End Property
	
	Property ToolButton.Top As Integer
		Dim As Integer i
		If Ctrl Then
			With QControl(Ctrl)
				#ifndef __USE_GTK__
					Dim As Rect R
					If .Handle Then
						i = .Perform(TB_COMMANDTOINDEX,FCommandID,0)
						.Perform(TB_GETITEMRECT,I,CInt(@R))
						FButtonTop = R.Top
					End If
				#endif
			End With
		End If
		Return FButtonTop
	End Property
	
	Property ToolButton.Top(Value As Integer)
	End Property
	
	Property ToolButton.Width As Integer
		Dim As Integer i
		If Ctrl Then
			With QControl(Ctrl)
				#ifndef __USE_GTK__
					Dim As Rect R
					If .Handle Then
						i = .Perform(TB_COMMANDTOINDEX,FCommandID,0)
						.Perform(TB_GETITEMRECT,I,CInt(@R))
						FButtonWidth = R.Right - R.Left
					End If
				#endif
			End With
		End If
		Return FButtonWidth
	End Property
	
	Property ToolButton.Width(Value As Integer)
		FButtonWidth = Value
	End Property
	
	Property ToolButton.Height As Integer
		#ifndef __USE_GTK__
			Dim As Rect R
			Dim As Integer i
			If Ctrl Then
				With QControl(Ctrl)
					If .Handle Then
						i = .Perform(TB_COMMANDTOINDEX,FCommandID,0)
						.Perform(TB_GETITEMRECT,I,CInt(@R))
						FButtonHeight = R.Bottom - R.Top
					End If
				End With
			End If
		#endif
		Return FButtonHeight
	End Property
	
	Property ToolButton.Height(Value As Integer)
	End Property
	
	Property ToolButton.Visible As Boolean
		Return FVisible
	End Property
	
	Property ToolButton.Visible(Value As Boolean)
		If Value <> FVisible Then
			FVisible = Value
			If Ctrl Then
				With QControl(Ctrl)
					#ifdef __USE_GTK__
						If FVisible Then
							gtk_widget_show(Widget)
						Else
							gtk_widget_hide(Widget)
						End If
					#else
						.Perform(TB_HIDEBUTTON, FCommandID, MakeLong(Not FVisible, 0))
					#endif
				End With
			End If
		End If
	End Property
	
	Property ToolButton.Enabled As Boolean
		Return FEnabled
	End Property
	
	Property ToolButton.Enabled(Value As Boolean)
		If Value <> FEnabled Then
			FEnabled = Value
			If Ctrl Then
				With QControl(Ctrl)
					#ifdef __USE_GTK__
						gtk_widget_set_sensitive(widget, FEnabled)
					#else
						.Perform(TB_ENABLEBUTTON, FCommandID, MakeLong(FEnabled, 0))
						.Perform(TB_CHANGEBITMAP, FCommandID, MakeLong(FImageIndex,0))
					#endif
				End With
			End If
		End If
	End Property
	
	Property ToolButton.Checked As Boolean
		If Ctrl Then
			With QControl(Ctrl)
				#ifdef __USE_GTK__
					If gtk_is_toggle_tool_button(widget) Then
						FChecked = gtk_toggle_tool_button_get_active(gtk_toggle_tool_button(widget))
					Else
						FChecked = False
					End If
				#else
					FChecked = .Perform(TB_ISBUTTONCHECKED, FCommandID, 0)
				#endif
			End With
		End If
		Return FChecked
	End Property
	
	Property ToolButton.Checked(Value As Boolean)
		'If Value <> Checked Then
		FChecked = Value
		If Ctrl Then
			With QControl(Ctrl)
				#ifdef __USE_GTK__
					If gtk_is_toggle_tool_button(widget) Then
						gtk_toggle_tool_button_set_active(gtk_toggle_tool_button(widget), Value)
					End If
				#else
					.Perform(TB_CHECKBUTTON, FCommandID, MakeLong(FChecked, 0))
				#endif
				If OnClick Then OnClick(This)
			End With
		End If
		If CInt(Value) AndAlso CInt((FState And tstChecked) <> tstChecked) Then
			FState = FState Or tstChecked
		End If
		'End If
	End Property
	
	Operator ToolButton.Cast As Any Ptr
		Return @This
	End Operator
	
	Constructor ToolButton
		FHint = 0 'CAllocate_(0)
		FCaption = 0 'CAllocate_(0)
		WLet(FClassName, "ToolButton")
		FStyle      = tbsButton
		FEnabled    = 1
		FVisible    = 1
		FState      = tstEnabled
		Caption    = ""
		Hint       = ""
		FShowHint   = 0
		FImageIndex = -1
	End Constructor
	
	Destructor ToolButton
		#ifdef __USE_GTK__
			#ifdef __USE_GTK3__
				If gtk_is_widget(widget) Then gtk_widget_destroy(Widget)
			#endif
		#else
			If DropDownMenu.Handle Then DestroyMenu DropDownMenu.Handle
		#endif
		WDeallocate FHint
		WDeallocate FCaption
		WDeallocate FImageKey
		WDeallocate FName
	End Destructor
	
	Property ToolButtons.Count As Integer
		Return FButtons.Count
	End Property
	
	Property ToolButtons.Count(Value As Integer)
	End Property
	
	Property ToolButtons.Item(Index As Integer) As ToolButton Ptr
		Return Cast(ToolButton Ptr, FButtons.Items[Index])
	End Property
	
	Property ToolButtons.Item(ByRef Key As WString) As ToolButton Ptr
		If IndexOf(Key) <> -1 Then Return Cast(ToolButton Ptr, FButtons.Items[IndexOf(Key)])
		Return 0
	End Property
	
	Property ToolButtons.Item(Index As Integer, Value As ToolButton Ptr)
		'QToolButton(FButtons.Items[Index]) = Value
	End Property
	
	#ifdef __USE_GTK__
		Sub ToolButtonClicked(gtoolbutton As GtkToolButton Ptr, user_data As Any Ptr)
			Dim As ToolButton Ptr tbut = user_data
			If tbut Then
				If tbut->OnClick Then tbut->OnClick(*tbut)
				If tbut->Ctrl AndAlso *tbut->Ctrl Is ToolBar Then
					Dim As ToolBar Ptr tb = Cast(ToolBar Ptr, tbut->Ctrl)
					If tb->OnButtonClick Then tb->OnButtonClick(*tb, *tbut)
				End If
			End If
		End Sub
	#endif
	
	Function ToolButtons.Add(FStyle As Integer = tbsAutosize, FImageIndex As Integer = -1, Index As Integer = -1, FClick As Any Ptr = NULL, ByRef FKey As WString = "", ByRef FCaption As WString = "", ByRef FHint As WString = "", FShowHint As Boolean = False, FState As Integer = tstEnabled) As ToolButton Ptr
		Dim As ToolButton Ptr PButton
		PButton = New_( ToolButton)
		PButton->FDynamic = True
		FButtons.Add PButton
		With *PButton
			.Style          = FStyle
			#ifdef __USE_GTK__
				Select Case FStyle
				Case tbsSeparator
					.widget = gtk_widget(gtk_separator_tool_item_new())
				Case Else
					Select Case FStyle
					Case tbsButton, tbsButton Or tbsAutosize
						.widget = gtk_widget(gtk_tool_button_new(NULL, ToUTF8(FCaption)))
					Case tbsAutosize
						.widget = gtk_widget(gtk_tool_button_new(NULL, ToUTF8(FCaption)))
					Case tbsCheck, tbsCheck Or tbsAutosize
						.widget = gtk_widget(gtk_toggle_tool_button_new())
					Case tbsCheckGroup, tbsCheckGroup Or tbsAutosize
						If FButtons.Count > 1 AndAlso gtk_is_radio_tool_button(QToolButton(FButtons.Item(FButtons.Count - 2)).widget) Then
							.widget = gtk_widget(gtk_radio_tool_button_new_from_widget(gtk_radio_tool_button(QToolButton(FButtons.Item(FButtons.Count - 2)).widget)))
						Else
							.widget = gtk_widget(gtk_radio_tool_button_new(NULL))
						End If
					Case tbsGroup, tbsGroup Or tbsAutosize
						If FButtons.Count > 1 AndAlso gtk_is_radio_tool_button(QToolButton(FButtons.Item(FButtons.Count - 2)).widget) Then
							.widget = gtk_widget(gtk_radio_tool_button_new_from_widget(gtk_radio_tool_button(QToolButton(FButtons.Item(FButtons.Count - 2)).widget)))
						Else
							.widget = gtk_widget(gtk_radio_tool_button_new(NULL))
						End If
					Case tbsDropDown, tbsDropDown Or tbsAutosize
						.widget = gtk_widget(gtk_menu_tool_button_new(NULL, ToUTF8(FCaption)))
						gtk_menu_tool_button_set_menu(gtk_menu_tool_button(.widget), .DropDownMenu.widget)
					Case tbsNoPrefix
						.widget = gtk_widget(gtk_tool_button_new(NULL, ToUTF8(FCaption)))
					Case tbsShowText, tbsShowText Or tbsAutosize
						.widget = gtk_widget(gtk_tool_button_new(NULL, ToUTF8(FCaption)))
					Case tbsWholeDropdown, tbsWholeDropdown Or tbsAutoSize
						.widget = gtk_widget(gtk_menu_tool_button_new(NULL, ToUTF8(FCaption)))
						gtk_menu_tool_button_set_menu(gtk_menu_tool_button(.widget), .DropDownMenu.widget)
					Case Else
						.widget = gtk_widget(gtk_tool_button_new(NULL, ToUTF8(FCaption)))
					End Select
					If gtk_is_tool_button(.widget) Then gtk_tool_button_set_label(gtk_tool_button(.widget), TOUTF8(FHint))
					gtk_tool_item_set_tooltip_text(gtk_tool_item(.widget), ToUTF8(FHint))
					g_signal_connect(.widget, "clicked", G_CALLBACK(@ToolButtonClicked), PButton)
				End Select
				
				gtk_widget_show_all(.widget)
			#endif
			.State        = FState
			.ImageIndex     = FImageIndex
			.Hint           = FHint
			.ShowHint       = FShowHint
			.Name         = FKey
			.Caption        = FCaption
			.CommandID      = 10 + FButtons.Count
			.OnClick        = FClick
		End With
		PButton->Ctrl = Parent
		#ifdef __USE_GTK__
			If Parent Then
				gtk_toolbar_insert(gtk_toolbar(Parent->widget), gtk_tool_item(PButton->widget), Index)
			End If
		#else
			Dim As TBBUTTON TB
			TB.fsState   = FState
			TB.fsStyle   = FStyle
			TB.iBitmap   = PButton->ImageIndex
			TB.idCommand = PButton->CommandID
			If FCaption <> "" Then
				TB.iString = CInt(@FCaption)
			Else
				TB.iString = 0
			End If
			TB.dwData = Cast(DWord_Ptr,@PButton->DropDownMenu)
			If Parent Then
				If Index <> -1 Then
					Parent->Perform(TB_INSERTBUTTON,Index,CInt(@TB))
				Else
					Parent->Perform(TB_ADDBUTTONS,1,CInt(@TB))
				End If
			End If
		#endif
		Return PButton
	End Function
	
	Function ToolButtons.Add(FStyle As Integer = tbsAutosize, ByRef ImageKey As WString, Index As Integer = -1, FClick As Any Ptr = NULL, ByRef FKey As WString = "", ByRef FCaption As WString = "", ByRef FHint As WString = "", FShowHint As Boolean = False, FState As Integer = tstEnabled) As ToolButton Ptr
		Dim As ToolButton Ptr PButton
		If Parent AndAlso Cast(ToolBar Ptr, Parent)->ImagesList Then
			With *Cast(ToolBar Ptr, Parent)->ImagesList
				PButton = Add(FStyle, .IndexOf(ImageKey), Index, FClick, FKey, FCaption, FHint, FShowHint, FState)
			End With
		Else
			PButton = Add(FStyle, -1, Index, FClick, FKey, FCaption, FHint, FShowHint, FState)
		End If
		If PButton Then PButton->ImageKey         = ImageKey
		Return PButton
	End Function

	Sub ToolButtons.Add(PButton As ToolButton Ptr, Index As Integer = -1)
		FButtons.Add PButton
		With *PButton
			.CommandID      = 10 + FButtons.Count
		End With
		PButton->Ctrl = Parent
		#ifdef __USE_GTK__
			If Parent Then
				gtk_toolbar_insert(gtk_toolbar(Parent->widget), gtk_tool_item(PButton->widget), Index)
			End If
		#else
			Dim As TBBUTTON TB
			TB.fsState   = PButton->State
			TB.fsStyle   = PButton->Style
			TB.iBitmap   = PButton->ImageIndex
			TB.idCommand = PButton->CommandID
			If PButton->Caption <> "" Then
				TB.iString = CInt(@PButton->Caption)
			Else
				TB.iString = 0
			End If
			TB.dwData = Cast(DWord_Ptr, @PButton->DropDownMenu)
			If Parent Then
				If Index <> -1 Then
					Parent->Perform(TB_INSERTBUTTON,Index,CInt(@TB))
				Else
					Parent->Perform(TB_ADDBUTTONS, 1, CInt(@TB))
				End If
			End If
		#endif
	End Sub
	
	Sub ToolButtons.Remove(Index As Integer)
		FButtons.Remove Index
		If Parent Then
			#ifndef __USE_GTK__
				Parent->Perform(TB_DELETEBUTTON,Index,0)
			#endif
		End If
	End Sub
	
	Function ToolButtons.IndexOf(ByRef FButton As ToolButton Ptr) As Integer
		Return FButtons.IndexOF(FButton)
	End Function
	
	Function ToolButtons.IndexOf(ByRef Key As WString) As Integer
		For i As Integer = 0 To Count - 1
			If QToolButton(FButtons.Items[i]).Name = Key Then Return i
		Next i
		Return -1
	End Function
	
	Sub ToolButtons.Clear
		For i As Integer = Count - 1 To 0 Step -1
			If QToolButton(FButtons.Items[i]).FDynamic Then Delete_( @QToolButton(FButtons.Items[i]))
		Next i
		FButtons.Clear
	End Sub
	
	Operator ToolButtons.Cast As Any Ptr
		Return @This
	End Operator
	
	Constructor ToolButtons
		This.Clear
	End Constructor
	
	Destructor ToolButtons
		This.Clear
	End Destructor
	
	Property ToolBar.AutoSize As Boolean
		#ifndef __USE_GTK__
			FAutoSize = StyleExists(TBSTYLE_AUTOSIZE)
		#endif
		Return FAutoSize
	End Property
	
	Property ToolBar.AutoSize(Value As Boolean)
		FAutoSize = Value
		#ifndef __USE_GTK__
			ChangeStyle TBSTYLE_AUTOSIZE, Value
			If FHandle Then If FAutosize Then Perform(TB_AUTOSIZE, 0, 0)
		#endif
	End Property
	
	Property ToolBar.Flat As Boolean
		#ifndef __USE_GTK__
			FFlat = StyleExists(TBSTYLE_FLAT)
		#endif
		Return FFlat
	End Property
	
	Property ToolBar.Flat(Value As Boolean)
		FFlat = Value
		#ifndef __USE_GTK__
			ChangeStyle TBSTYLE_FLAT, Value
		#endif
	End Property
	
	Property ToolBar.List As Boolean
		#ifndef __USE_GTK__
			FList = StyleExists(TBSTYLE_LIST)
		#endif
		Return FList
	End Property
	
	Property ToolBar.List(Value As Boolean)
		FList = Value
		#ifdef __USE_GTK__
			gtk_toolbar_set_style(gtk_toolbar(widget), IIf(Value, GTK_TOOLBAR_BOTH_HORIZ, GTK_TOOLBAR_BOTH))
		#else
			ChangeStyle TBSTYLE_LIST, Value
		#endif
	End Property
	
	
	Property ToolBar.Divider As Boolean
		#ifndef __USE_GTK__
			FDivider = Not StyleExists(CCS_NODIVIDER)
		#endif
		Return FDivider
	End Property
	
	Property ToolBar.Divider(Value As Boolean)
		FDivider = Value
		#ifndef __USE_GTK__
			ChangeStyle CCS_NODIVIDER, Not Value
		#endif
	End Property
	
	Property ToolBar.Transparency As Boolean
		#ifndef __USE_GTK__
			FTransparent = StyleExists(TBSTYLE_TRANSPARENT)
		#endif
		Return FTransparent
	End Property
	
	Property ToolBar.Transparency(Value As Boolean)
		FTransparent = Value
		#ifndef __USE_GTK__
			ChangeStyle TBSTYLE_TRANSPARENT, Value
		#endif
	End Property
	
	Property ToolBar.BitmapWidth As Integer
		Return FBitmapWidth
	End Property
	
	Property ToolBar.BitmapWidth(Value As Integer)
		FBitmapWidth = Value
		#ifndef __USE_GTK__
			If Handle Then Perform(TB_SETBITMAPSIZE, 0, MakeLong(FBitmapWidth, FBitmapHeight))
		#endif
	End Property
	
	Property ToolBar.BitmapHeight As Integer
		Return FBitmapHeight
	End Property
	
	Property ToolBar.BitmapHeight(Value As Integer)
		FBitmapHeight = Value
		#ifndef __USE_GTK__
			If Handle Then Perform(TB_SETBITMAPSIZE, 0, MakeLong(FBitmapWidth, FBitmapHeight))
		#endif
	End Property
	
	Property ToolBar.ButtonWidth As Integer
		#ifndef __USE_GTK__
			If Handle Then
				Var Size = Perform(TB_GETBUTTONSIZE, 0, 0)
				FButtonWidth = LoWord(Size)
			End If
		#endif
		Return FButtonWidth
	End Property
	
	Property ToolBar.ButtonWidth(Value As Integer)
		FButtonWidth = Value
		#ifndef __USE_GTK__
			If Handle Then Perform(TB_SETBUTTONSIZE,0,MakeLong(FButtonWidth,FButtonHeight))
		#endif
	End Property
	
	Property ToolBar.ButtonHeight As Integer
		#ifndef __USE_GTK__
			If Handle Then
				Var Size = Perform(TB_GETBUTTONSIZE, 0, 0)
				FButtonHeight = HiWord(Size)
			End If
		#endif
		Return FButtonHeight
	End Property
	
	Property ToolBar.ButtonHeight(Value As Integer)
		FButtonHeight = Value
		#ifndef __USE_GTK__
			If Handle Then Perform(TB_SETBUTTONSIZE,0,MakeLong(FButtonWidth,FButtonHeight))
		#endif
	End Property
	
	Property ToolBar.Wrapable As Boolean
		#ifndef __USE_GTK__
			FWrapable = StyleExists(TBSTYLE_WRAPABLE)
		#endif
		Return FWrapable
	End Property
	
	Property ToolBar.Wrapable(Value As Boolean)
		FWrapable = Value
		#ifndef __USE_GTK__
			ChangeStyle TBSTYLE_WRAPABLE, Value
		#endif
	End Property
	
	Property ToolBar.Caption ByRef As WString
		Return Text
	End Property
	
	Property ToolBar.Caption(ByRef Value As WString)
		Text = Value
	End Property
	
	Sub ToolBar.WndProc(ByRef Message As Message)
	End Sub
	
	Sub ToolBar.ProcessMessage(ByRef Message As Message)
		#ifndef __USE_GTK__
			Select Case Message.Msg
			Case WM_PAINT
				Message.Result = 0
			Case WM_SIZE
				If AutoSize Then
					Dim As Rect R
					GetWindowRect Handle,@R
					FHeight = R.Bottom - R.Top
				End If
			Case WM_COMMAND
				GetDropDownMenuItems
				For i As Integer = 0 To FPopupMenuItems.Count -1
					If QMenuItem(FPopupMenuItems.Items[i]).Command = Message.wParamLo Then
						If QMenuItem(FPopupMenuItems.Items[i]).OnClick Then QMenuItem(FPopupMenuItems.Items[i]).OnClick(QMenuItem(FPopupMenuItems.Items[i]))
						Exit For
					End If
				Next i
			Case CM_COMMAND
				Dim As Integer Index
				Dim As TBBUTTON TB
				If Message.wParam <> 0 Then
					Index = Perform(TB_COMMANDTOINDEX, Message.wParam, 0)
					If Perform(TB_GETBUTTON, Index, CInt(@TB)) Then
						If Buttons.Item(Index)->OnClick Then (Buttons.Item(Index))->OnClick(*Buttons.Item(Index))
						If OnButtonClick Then OnButtonClick(This, *Buttons.Item(Index))
					End If
				End If
			Case CM_NOTIFY
				Dim As TBNOTIFY Ptr Tbn
				Dim As TBBUTTON TB
				Dim As RECT R
				Dim As Integer i
				Tbn = Cast(TBNOTIFY Ptr,Message.lParam)
				Select Case Tbn->hdr.Code
				Case TBN_DROPDOWN
					If Tbn->iItem <> -1 Then
						SendMessage(Tbn->hdr.hwndFrom,TB_GETRECT,Tbn->iItem,CInt(@R))
						MapWindowPoints(Tbn->hdr.hwndFrom,0,Cast(Point Ptr,@R),2)
						i = SendMessage(Tbn->hdr.hwndFrom,TB_COMMANDTOINDEX,Tbn->iItem,0)
						If SendMessage(Tbn->hdr.hwndFrom,TB_GETBUTTON,i,CInt(@TB)) Then
							TrackPopupMenu(Buttons.Item(i)->DropDownMenu.Handle,0,R.Left,R.Bottom,0,Tbn->hdr.hwndFrom,NULL)
						End If
					End If
				End Select
			Case CM_NEEDTEXT
				Dim As LPTOOLTIPTEXT TTX
				TTX = Cast(LPTOOLTIPTEXT,Message.lParam)
				TTX->hInst = GetModuleHandle(NULL)
				If TTX->hdr.idFrom Then
					Dim As TBButton TB
					Dim As Integer Index
					Index = Perform(TB_COMMANDTOINDEX,TTX->hdr.idFrom,0)
					If Perform(TB_GETBUTTON,Index,CInt(@TB)) Then
						If Buttons.Item(Index)->ShowHint Then
							If Buttons.Item(Index)->Hint <> "" Then
								'Dim As UString s
								's = Buttons.Button(Index).Hint
								TTX->lpszText = @(Buttons.Item(Index)->Hint)
							End If
						End If
					End If
				End If
			End Select
		#endif
		Base.ProcessMessage(message)
	End Sub
	
	Sub ToolBar.HandleIsDestroyed(ByRef Sender As Control)
	End Sub
	
	Sub ToolBar.HandleIsAllocated(ByRef Sender As Control)
		If Sender.Child Then
			With QToolBar(Sender.Child)
				#ifndef __USE_GTK__
					If .ImagesList Then .ImagesList->ParentWindow = @Sender: If .ImagesList->Handle Then .Perform(TB_SETIMAGELIST,0,CInt(.ImagesList->Handle))
					If .HotImagesList Then .HotImagesList->ParentWindow = @Sender: If .HotImagesList->Handle Then .Perform(TB_SETHOTIMAGELIST,0,CInt(.HotImagesList->Handle))
					If .DisabledImagesList Then .DisabledImagesList->ParentWindow = @Sender: If .DisabledImagesList->Handle Then .Perform(TB_SETDISABLEDIMAGELIST,0,CInt(.DisabledImagesList->Handle))
					.Perform(TB_BUTTONSTRUCTSIZE,SizeOf(TBBUTTON),0)
					.Perform(TB_SETEXTENDEDSTYLE, 0, .Perform(TB_GETEXTENDEDSTYLE, 0, 0) Or TBSTYLE_EX_DRAWDDARROWS)
					.Perform(TB_SETBUTTONSIZE, 0, MakeLong(.FButtonWidth, .FButtonHeight))
					If .FBitmapWidth <> 16 AndAlso .FBitmapHeight <> 16 Then .Perform(TB_SETBITMAPSIZE, 0, MakeLong(.FBitmapWidth, .FBitmapHeight))
					For i As Integer = 0 To .Buttons.Count - 1
						Dim As TBBUTTON TB
						'Dim As WString Ptr s = .Buttons.Button(i)->Caption
						TB.fsState   = .Buttons.Item(i)->State
						TB.fsStyle   = .Buttons.Item(i)->Style
						If .Buttons.Item(i)->ImageIndex = -1 AndAlso .ImagesList <> 0 AndAlso .Buttons.Item(i)->ImageKey <> "" Then
							.Buttons.Item(i)->ImageIndex = .ImagesList->IndexOf(.Buttons.Item(i)->ImageKey)
						End If
						TB.iBitmap   = .Buttons.Item(i)->ImageIndex
						TB.idCommand = .Buttons.Item(i)->CommandID
						If .Buttons.Item(i)->Caption <> "" Then
							TB.iString   = CInt(@.Buttons.Item(i)->Caption)
						Else
							TB.iString   = 0
						End If
						TB.dwData    = Cast(DWord_Ptr,@.Buttons.Item(i)->DropDownMenu)
						.Perform(TB_ADDBUTTONS,1,CInt(@TB))
						If Not .Buttons.Item(i)->Visible Then .Perform(TB_HIDEBUTTON, .Buttons.Item(i)->CommandID, MakeLong(True, 0))
					Next i
					If .AutoSize Then .Perform(TB_AUTOSIZE,0,0)
				#endif
'				If .DesignMode Then
'					.Buttons.Add
'				End If
			End With
		End If
	End Sub
	
	Operator ToolBar.Cast As Control Ptr
		Return @This
	End Operator
	
	Constructor ToolBar
		With This
			FButtonWidth    = 16
			FButtonHeight   = 16
			#ifdef __USE_GTK__
				widget = gtk_toolbar_new()
				gtk_toolbar_set_style(GTK_TOOLBAR(widget), GTK_TOOLBAR_BOTH_HORIZ)
				.RegisterClass "ToolBar", @This
			#else
				AFlat(0)        = 0
				AFlat(1)        = TBSTYLE_FLAT
				ADivider(0)     = CCS_NODIVIDER
				ADivider(1)     = 0
				AAutosize(0)    = 0
				AAutosize(1)    = TBSTYLE_AUTOSIZE
				AList(0)        = 0
				AList(1)        = TBSTYLE_LIST
				AState(0)       = TBSTATE_INDETERMINATE
				AState(1)       = TBSTATE_ENABLED
				AState(2)       = TBSTATE_HIDDEN
				AState(3)       = TBSTATE_CHECKED
				AState(4)       = TBSTATE_PRESSED
				AState(5)       = TBSTATE_WRAP
				AWrap(0)        = 0
				AWrap(1)        = TBSTYLE_WRAPABLE
				ATransparent(0) = 0
				ATransparent(1) = TBSTYLE_TRANSPARENT
			#endif
			FTransparent    = 1
			FAutosize       = 1
			FButtonWidth    = 16
			FButtonHeight   = 16
			FBitmapWidth    = 16
			FBitmapHeight   = 16
			Buttons.Parent  = This
			FEnabled = True
			#ifndef __USE_GTK__
				.OnHandleIsAllocated = @HandleIsAllocated
				.OnHandleIsDestroyed = @HandleIsDestroyed
				.ChildProc         = @WndProc
				.ExStyle           = 0
				.Style             = WS_CHILD Or TBSTYLE_TOOLTIPS Or CCS_NOPARENTALIGN Or CCS_NOMOVEY Or AList(FList) Or AAutosize(_Abs(FAutosize)) Or AFlat(_Abs(FFlat)) Or ADivider(_Abs(FDivider)) Or AWrap(_Abs(FWrapable)) Or ATransparent(_Abs(FTransparent))
				.RegisterClass "ToolBar", "ToolBarWindow32"
			#endif
			.Child             = @This
			WLet(FClassName, "ToolBar")
			WLet(FClassAncestor, "ToolBarWindow32")
			.Width             = 121
			#ifdef __USE_GTK__
				.Height            = 30
			#else
				.Height            = 26
			#endif
			'.Font              = @Font
			'.Cursor            = @Cursor
		End With
	End Constructor
	
	Destructor ToolBar
		Buttons.Clear
		#ifndef __USE_GTK__
			'UnregisterClass "ToolBar", GetmoduleHandle(NULL)
		#endif
	End Destructor
End Namespace

#ifdef __EXPORT_PROCS__
	Function ToolBarAddButtonWithImageIndex Alias "ToolBarAddButtonWithImageIndex"(tb As My.Sys.Forms.ToolBar Ptr, FStyle As Integer = My.Sys.Forms.tbsAutosize, FImageIndex As Integer = -1, Index As Integer = -1, FClick As Any Ptr = NULL, ByRef FKey As WString = "", ByRef FCaption As WString = "", ByRef FHint As WString = "", FShowHint As Boolean = False, FState As Integer = My.Sys.Forms.tstEnabled) As My.Sys.Forms.ToolButton Ptr Export
		Return tb->Buttons.Add(FStyle, FImageIndex, Index, FClick, FKey, FCaption, FHint, FShowHint, FState)
	End Function
	
	Function ToolBarAddButtonWithImageKey Alias "ToolBarAddButtonWithImageKey"(tb As My.Sys.Forms.ToolBar Ptr, FStyle As Integer = My.Sys.Forms.tbsAutosize, ByRef ImageKey As WString, Index As Integer = -1, FClick As Any Ptr = NULL, ByRef FKey As WString = "", ByRef FCaption As WString = "", ByRef FHint As WString = "", FShowHint As Boolean = False, FState As Integer = My.Sys.Forms.tstEnabled) As My.Sys.Forms.ToolButton Ptr Export
		Return tb->Buttons.Add(FStyle, ImageKey, Index, FClick, FKey, FCaption, FHint, FShowHint, FState)
	End Function
	
	Sub ToolBarRemoveButton Alias "ToolBarRemoveButton" (tb As My.Sys.Forms.ToolBar Ptr, Index As Integer) Export
		tb->Buttons.Remove Index
	End Sub

	Function ToolBarButtonByIndex Alias "ToolBarButtonByIndex" (tb As My.Sys.Forms.ToolBar Ptr, Index As Integer) As My.Sys.Forms.ToolButton Ptr Export
		Return tb->Buttons.Item(Index)
	End Function

	Function ToolBarIndexOfButton Alias "ToolBarIndexOfButton"(tb As My.Sys.Forms.ToolBar Ptr, Btn As My.Sys.Forms.ToolButton Ptr) As Integer Export
		Return tb->Buttons.IndexOf(Btn)
	End Function
#endif
