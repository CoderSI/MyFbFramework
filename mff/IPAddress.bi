﻿'################################################################################
'#  IPAddress.bi                                                                  #
'#  This file is part of MyFBFramework                                            #
'#  Version 1.0.0                                                                  #
'################################################################################

#Include Once "Control.bi"

Namespace My.Sys.Forms
    #DEFINE QIPAddress(__Ptr__) *Cast(IPAddress Ptr, __Ptr__)
    
    Type IPAddress Extends Control
        Private:
            Declare Static Sub WndProc(ByRef Message As Message)
            Declare Sub ProcessMessage(ByRef Message As Message)
            Declare Static Sub HandleIsAllocated(ByRef Sender As My.Sys.Forms.Control)
        Public:
            Declare Operator Cast As My.Sys.Forms.Control Ptr
            Declare Constructor
            Declare Destructor
    End Type
    
    Sub IPAddress.HandleIsAllocated(ByRef Sender As My.Sys.Forms.Control)
        If Sender.Child Then
            With QIPAddress(Sender.Child)
                 
            End With
        End If
    End Sub

    Sub IPAddress.WndProc(ByRef Message As Message)
    End Sub

    Sub IPAddress.ProcessMessage(ByRef Message As Message)
        'Base.ProcessMessage Message
    End Sub

    Operator IPAddress.Cast As My.Sys.Forms.Control Ptr
         Return Cast(My.Sys.Forms.Control Ptr, @This)
    End Operator

    Constructor IPAddress
        Dim As INITCOMMONCONTROLSEX icex

        icex.dwSize = sizeof(INITCOMMONCONTROLSEX)
        icex.dwICC =  ICC_INTERNET_CLASSES

        InitCommonControlsEx(@icex)

        With This
            .RegisterClass "IPAddress", WC_IPADDRESS
            .ClassName = "IPAddress"
            .ClassAncestor = WC_IPADDRESS
            .ExStyle      = 0
            .Style        = WS_CHILD
            .Width        = 100
            .Height       = 32
            .Child        = @This
            .ChildProc    = @WndProc
            .OnHandleIsAllocated = @HandleIsAllocated
        End With
    End Constructor

    Destructor IPAddress
        UnregisterClass "IPAddress",GetModuleHandle(NULL)
    End Destructor
End Namespace