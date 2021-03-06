﻿'###############################################################################
'#  PointerList.bi                                                             #
'#  This file is part of MyFBFramework                                     #
'#  Version 1.0.0                                                              #
'###############################################################################

#include once "List.bi"

#define QPointerListItem(__Ptr__) *Cast(PointerListItem Ptr,__Ptr__)
#define QPointerList(__Ptr__) *Cast(PointerList Ptr,__Ptr__)

Type PointerListItem Extends Object
    Value As Any Ptr
    Object As Any Ptr
End Type

Type PointerList Extends Object
    Private:
        FCount   As Integer
        FItems   As List
    Public:
        Declare Function Count As Integer
        Declare Property Item(Index As Integer) As Any Ptr
        Declare Property Item(Index As Integer, Value As Any Ptr)
        Declare Property Object(Index As Integer) As Any Ptr
        Declare Property Object(Index As Integer, Value As Any Ptr)
        Declare Sub Add(_Item As Any Ptr, Obj As Any Ptr = 0)
        Declare Sub Insert(Index As Integer, _Item As Any Ptr, Obj As Any Ptr = 0)
        Declare Sub Exchange(Index1 As Integer, Index2 As Integer)
        Declare Sub Remove(Index As Integer)
        Declare Sub Clear
        Declare Function IndexOf(Item As Any Ptr) As Integer
        Declare Function IndexOfObject(Obj As Any Ptr) As Integer
        Declare Function Contains(Item As Any Ptr) As Boolean
        Declare Function ContainsObject(Obj As Any Ptr) As Boolean
        Declare Operator Cast As Any Ptr
        Declare Constructor
        Declare Destructor
End Type

Operator PointerList.Cast As Any Ptr 
    Return @This
End Operator

Function PointerList.Count As Integer
    Return FItems.Count
End Function

Property PointerList.Item(Index As Integer) As Any Ptr
    If Index >= 0 AND Index <= Count -1 Then
       Return QPointerListItem(FItems.Items[Index]).Value
    End If
    Return 0
End Property

Property PointerList.Item(Index As Integer, Value As Any Ptr)
    If Index >= 0 AND Index <= Count - 1 Then
       QPointerListItem(FItems.Items[Index]).Value = Value
    End If 
End Property

Property PointerList.Object(Index As Integer) As Any Ptr
    If Index >= 0 AND Index <= Count -1 Then
       Return QPointerListItem(FItems.Items[Index]).Object
    End If
    Return 0
End Property

Property PointerList.Object(Index As Integer, Value As Any Ptr)
    If Index >= 0 AND Index <= Count -1 Then
       QPointerListItem(FItems.Items[Index]).Object = Value
    End If 
End Property

Sub PointerList.Add(_Item As Any Ptr, Obj As Any Ptr = 0)
    Dim As PointerListItem Ptr nItem = New PointerListItem
    with *nItem
        .Value  = _Item
        .Object = Obj
    End With
    FItems.Add nItem
End Sub

Sub PointerList.Insert(Index As Integer, _Item As Any Ptr, Obj As Any Ptr = 0)
    Dim As PointerListItem Ptr nItem = New PointerListItem
    with *nItem
        .Value  = _Item
        .Object = Obj
    End With
    FItems.Insert Index, nItem
End Sub

Sub PointerList.Exchange(Index1 As Integer, Index2 As Integer)
    FItems.Exchange(Index1, Index2)
End Sub

Sub PointerList.Remove(Index As Integer)
    If Index = -1 Then Exit Sub
    Delete Cast(PointerListItem Ptr, FItems.Items[Index])
    FItems.Remove Index
End Sub

Sub PointerList.Clear
    For i As Integer = Count -1 To 0 Step -1
        Delete Cast(PointerListItem Ptr, FItems.Items[i])
    Next i
    FItems.Clear
End Sub

Function PointerList.IndexOf(_Item As Any Ptr) As Integer
    For i As Integer = 0 To Count - 1
        If QPointerListItem(FItems.Items[i]).Value = _Item Then Return i
    Next i
    Return -1
End Function

Function PointerList.IndexOfObject(Obj As Any Ptr) As Integer
    For i As Integer = 0 To Count -1
        If QPointerListItem(FItems.Items[i]).Object = Obj Then Return i
    Next i
    Return -1
End Function

Function PointerList.Contains(_Item As Any Ptr) As Boolean
    Return IndexOf(_Item) <> -1
End Function

Function PointerList.ContainsObject(Obj As Any Ptr) As Boolean
    Return IndexOfObject(Obj) <> -1
End Function

Constructor PointerList
    FItems.Clear
End Constructor

Destructor PointerList
    For i As Integer = Count - 1 To 0 Step -1
        Delete Cast(PointerListItem Ptr, FItems.Items[i])
    Next i
End Destructor
