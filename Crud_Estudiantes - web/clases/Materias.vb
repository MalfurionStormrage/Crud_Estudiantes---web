Public Class Materias
    Inherits Connection

    Public Function GetDescripcionMateriasPorId(id As String)
        Dim tabla As New DataTable()
        Try
            'iniciar conexion db'
            If (connectionStringDb.State.ToString() = "Closed") Then
                connectionStringDb.Open()
            End If

            'consulta sql'
            SqlCommand.Connection = connectionStringDb
            SqlCommand.CommandText = "SELECT Descripcion FROM materias where ID_M = '" & id & "'"
            SqlCommand.CommandType = CommandType.Text
            SqlCommand.Parameters.Clear()
            Dim resultado = SqlCommand.ExecuteReader()
            tabla.Load(resultado)
            connectionStringDb.Close()

            'se retorna la tabla con datos'

        Catch ex As Exception
            MsgBox("Error en la consulta, casusa: " + ex.ToString())
        End Try

        Return tabla

    End Function
End Class
