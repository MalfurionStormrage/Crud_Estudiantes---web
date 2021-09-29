Public Class Estudiantes
    Inherits Connection

    Public Function GetEstudiantes()
        Dim dataTable As New DataTable()
        Try
            If connectionStringDb.State.ToString() = "Closed" Then
                connectionStringDb.Open()
            End If

            SqlCommand.Connection = connectionStringDb
            SqlCommand.CommandText = "OCGN_Porce_ObtenerEstudaintesConCarreras"
            SqlCommand.CommandType = CommandType.StoredProcedure
            Dim result = SqlCommand.ExecuteReader()
            dataTable.Load(result)
            connectionStringDb.Close()

        Catch ex As Exception
            MsgBox("Error en la consulta sql, causa:" + ex.ToString)
        End Try
        Return dataTable
    End Function
End Class
