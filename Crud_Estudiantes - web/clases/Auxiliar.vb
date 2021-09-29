Imports DevExpress.Web
Public Class Auxiliar
    Shared Function mensajeError(ByVal ex As Exception)
        'Funcion para desplegar mensaje de error incluyendo el nombre del archivo y la línea donde se genera el error
        Dim st = New StackTrace(ex, True)
        Dim fr = st.GetFrame(st.FrameCount - 1)
        Dim NombreArchivoPart
        NombreArchivoPart = fr.GetFileName

        Return " " & ex.Message & " <br/>Archivo: " & NombreArchivoPart.ToString & " <br/>Linea: " & fr.GetFileLineNumber
    End Function
End Class
