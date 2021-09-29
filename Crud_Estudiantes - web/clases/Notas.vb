Public Class Notas
    Inherits Connection

    Public Function obtenerNotaPorIdDeEstudiante(id_estudiante As String)

        Dim tabla As New DataTable()

        Try

            'Iniciar conexion'
            If (connectionStringDb.State.ToString() = "Closed") Then
                connectionStringDb.Open()
            End If

            'realizar la consulta sql'
            SqlCommand.Connection = connectionStringDb
            SqlCommand.CommandText = "OCGN_Proce_Obtener_Notas_Por_Id_De_Estudiantes"
            SqlCommand.CommandType = CommandType.StoredProcedure
            SqlCommand.Parameters.Add("@id", id_estudiante)
            Dim resultado = SqlCommand.ExecuteReader()
            SqlCommand.Parameters.Clear()
            tabla.Load(resultado)
            connectionStringDb.Close()

        Catch ex As Exception
            MsgBox("Error en la consulta, casusa: " + ex.ToString())
        End Try

        Return tabla

    End Function

End Class
