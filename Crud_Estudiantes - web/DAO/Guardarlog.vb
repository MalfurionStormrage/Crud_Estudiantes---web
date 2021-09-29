Imports System.IO
Imports System
Imports System.Collections
Imports System.Data
Imports IBM.Data.Informix
Imports System.Text
Public Class Guardarlog
    Public Property gestorBaseDatos As DataManager
    Sub Guardar_logapli(ByVal data As log, ByVal conex As String)
        Dim querys As New List(Of String)
        For Each lstitm In data.dt_guardar_logapli.Rows
            querys.Add(" INSERT INTO logapli " &
" ( " &
  " logaplicod, " &
  " logapliopc, " &
  " logapliuad, " &
  " logaplifad, " &
  " logaplised " &
" ) " &
" VALUES " &
" ( " &
  " '" & lstitm("aplicaion").ToString.Trim & "', " &
    " 6, " &
  " '" & lstitm("usuario").ToString.Trim & "', " &
   " TO_CHAR(sysdate,'%Y-%m-%d  %H:%M:%S'), " &
   " '" & lstitm("cod_sede").ToString.Trim & "' " &
" ); ")
        Next

        gestorBaseDatos.ejecutarTransaccion(querys)
    End Sub

    Sub Guardar_logerror(ByVal variable As log, ByVal conex As String)
        Dim querys As New List(Of String)

        querys.Add(" INSERT INTO logerror " &
" ( " &
  " logerrorcod, " &
  " logerroropc, " &
  " logerrorpar, " &
  " logerrorext, " &
  " logerroruad, " &
  " logerrorfad, " &
  " logerrorsed " &
  " ) " &
" VALUES " &
" ( " &
  " '" & variable.aplicaion & "', " &
    " " & variable.opcion & ", " &
    " '" & variable.texto_error & "', " &
    " '1', " &
      " '" & variable.usuario & "', " &
   " TO_CHAR(sysdate,'%Y-%m-%d  %H:%M:%S'), " &
   " '" & variable.sede & "' " &
" ); ")


        gestorBaseDatos.ejecutarTransaccion(querys)
    End Sub

    Sub Actualizar_datos(ByVal variable As log, ByVal conex As String)


        Dim Querys As New StringBuilder()

        Querys.AppendLine("UPDATE Usuario")
        Querys.AppendLine("SET usuario.nom_usuario = '" & variable.nombre_usaurio & "'")
        Querys.AppendLine("WHERE Usuario.usuario = '" & variable.usuario & "'")


        gestorBaseDatos.ejecutarQuery_SQL(Querys.ToString)
    End Sub

End Class
