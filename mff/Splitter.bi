﻿'###############################################################################
'#  Splitter.bi                                                                #
'#  This file is part of MyFBFramework                                         #
'#  Authors: Nastase Eodor, Xusinboy Bekchanov, Liu XiaLin                     #
'#  Based on:                                                                  #
'#   TSplitter.bi                                                              #
'#   FreeBasic Windows GUI ToolKit                                             #
'#   Copyright (c) 2007-2008 Nastase Eodor                                     #
'#   Version 1.0.0                                                             #
'#  Updated and added cross-platform                                           #
'#  by Xusinboy Bekchanov(2018-2019)  Liu XiaLin                               #
'###############################################################################

#include once "Control.bi"

Namespace My.Sys.Forms
	#define QSplitter(__Ptr__) *Cast(Splitter Ptr, __Ptr__)
	
	Type Splitter Extends Control
	Private:
		FOldParentProc  As Any Ptr
		#ifndef __USE_GTK__
			Declare Static Sub ParentWndProc(ByRef Message As Message)
			Declare Static Sub WndProc(ByRef Message As Message)
		#endif
	Protected:
		Declare Sub DrawTrackSplit(x As Integer, y As Integer)
		Declare Virtual Sub ProcessMessage(ByRef Message As Message)
	Public:
		#ifdef __USE_GTK__
			Dim As Boolean bCursor
		#endif
		Declare Operator Cast As Control Ptr
		Declare Property Align As Integer
		Declare Property Align(Value As Integer)
		OnPaint As Sub(ByRef Sender As Splitter)
		OnMoved As Sub(ByRef Sender As Splitter)
		Declare Constructor
		Declare Destructor
	End Type
End Namespace

#ifndef __USE_MAKE__
	#Include Once "Splitter.bas"
#EndIf
