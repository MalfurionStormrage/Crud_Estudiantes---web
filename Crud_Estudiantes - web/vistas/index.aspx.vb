Imports DevExpress.Web

Public Class index
    Inherits System.Web.UI.Page

    Private Sub table_estudiante_CustomCallback(sender As Object, e As ASPxGridViewCustomCallbackEventArgs) Handles table_estudiante.CustomCallback
        Try
            If e.Parameters = "consultar" Then

                Session("estudiantes") = Nothing
                Dim estudiantes As New Estudiantes()
                Dim result = estudiantes.GetEstudiantes()

                If result.rows.count > 0 Then
                    Session("estudiantes") = result
                    table_estudiante.DataSource = result
                    table_estudiante.DataBind()

                End If
                table_estudiante.JSProperties("cpMsg") = "0§"

            End If

            If e.Parameters = "guardar" Then
                Dim identificacion = txt_iden_estudiante.Text
                Dim nombre = txt_iden_estudiante.Text
                Dim edad = txt_iden_estudiante.Text
            End If

            If e.Parameters = "limpiar" Then
                Session("estudiantes") = Nothing
                table_estudiante.DataSource = ""
                table_estudiante.DataBind()
                table_estudiante.JSProperties("cpMsg") = "0§"
            End If

        Catch ex As Exception

            table_estudiante.JSProperties("cpMsg") = "1§" + Auxiliar.mensajeError(ex)

        End Try
    End Sub

    Private Sub index_Load(sender As Object, e As EventArgs) Handles Me.Load
        If IsPostBack Then

            If Not IsNothing(Session("estudiantes")) Then

                table_estudiante.DataSource = Session("estudiantes")
                table_estudiante.DataBind()
                table_estudiante.JSProperties("cpMsg") = "0§"

            End If

            If Not IsNothing(Session("notas")) Then

                tabla_notas_estudiantes.DataSource = Session("notas")
                tabla_notas_estudiantes.DataBind()
                tabla_notas_estudiantes.JSProperties("cpmsg") = "0§"

            End If

        End If
    End Sub

    Private Sub tabla_notas_estudiantes_CustomCallback(sender As Object, e As ASPxGridViewCustomCallbackEventArgs) Handles tabla_notas_estudiantes.CustomCallback
        Try
            Dim para = e.Parameters
            Dim sp() = para.Split(",")
            Dim notas As New Notas()
            Dim materias As New Materias()
            Session("notas") = Nothing

            If sp(0) = "Consultar" Then

                If sp.Length > 1 And sp(1).ToString <> "" Then

                    Dim tabla As New DataTable()
                    tabla.Columns.Add("ID_Estudiante")
                    tabla.Columns.Add("Materia")
                    tabla.Columns.Add("Nota_1")
                    tabla.Columns.Add("Nota_2")
                    tabla.Columns.Add("Nota_3")

                    Dim x As Double

                    For x = 1 To sp.Length - 1 Step 1
                        Dim fila = tabla.NewRow()
                        Dim result = notas.obtenerNotaPorIdDeEstudiante(sp(x))
                        fila("ID_Estudiante") = result.rows(0).item(0)
                        Dim result2 = materias.GetDescripcionMateriasPorId(result.Rows(0).Item(1).ToString())
                        fila("Materia") = result2.Rows(0).Item(0).ToString
                        fila("Nota_1") = result.rows(0).item(2)
                        fila("Nota_2") = result.rows(0).item(3)
                        fila("Nota_3") = result.rows(0).item(4)
                        tabla.Rows.InsertAt(fila, x - 1)
                    Next

                    Session("notas") = tabla
                    tabla_notas_estudiantes.DataSource = tabla
                    tabla_notas_estudiantes.DataBind()
                    tabla_notas_estudiantes.JSProperties("cpMsg") = "0§"

                Else

                    Session("notas") = Nothing
                    tabla_notas_estudiantes.DataSource = ""
                    tabla_notas_estudiantes.DataBind()
                    tabla_notas_estudiantes.JSProperties("cpMsg") = "0§"
                End If

            End If
        Catch ex As Exception

            tabla_notas_estudiantes.JSProperties("cpMsg") = "1§" + Auxiliar.mensajeError(ex)

        End Try
    End Sub
End Class