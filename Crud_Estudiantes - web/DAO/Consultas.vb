Imports System.IO
Imports System
Imports System.Collections
Imports System.Data
Imports IBM.Data.Informix
Imports System.Text
Public Class Consultas
    Public Property gestorBaseDatos As DataManager

    Function Consultar_Permisos_hosvital(ByVal Usuario As Usuario, ByVal conex As String) As DataTable

        Dim Querys As New StringBuilder()

        Querys.AppendLine("EXEC OCGN_proce_Permiso_hosvital '" & Usuario.usuario & "','" & Usuario.cod_sede & "','" & Usuario.aplicacion & "','A'")

        Return gestorBaseDatos.ejecutarQuery_SQL(Querys.ToString())
    End Function


    Function Consultar_Permisos_seven(ByVal Usuario As Usuario, ByVal conex As String) As DataTable

        Dim Querys As New StringBuilder()

        Querys.AppendLine("EXEC OCGN_proce_Permiso_seven '" & Usuario.usuario & "','" & Usuario.cod_sede & "','" & Usuario.aplicacion & "'")

        Return gestorBaseDatos.ejecutarQuery_SQL(Querys.ToString())
    End Function
    Function Consultar_Permisos_Davinci(ByVal Usuario As Usuario, ByVal conex As String) As DataTable

        Dim Querys As New StringBuilder()

        'Querys.AppendLine("EXEC OCGN_proce_Permiso_hosvital '" & Usuario.usuario & "','" & Usuario.cod_sede & "','" & Usuario.aplicacion & "'")

        Return gestorBaseDatos.ejecutarQuery_SQL(Querys.ToString())
    End Function



    Function Consultar_usurio(ByVal variable As Datos, ByVal conex As String) As DataTable

        Dim Querys As New StringBuilder()

        Querys.AppendLine("exec OCGN_proc_siaorg_login '" & variable.usuario & "'")


        Return gestorBaseDatos.ejecutarQuery_SQL(Querys.ToString())

    End Function
    Function Consulytar_permiso_apl(ByVal variable As Datos, ByVal conex As String) As DataTable

        Dim Querys As New StringBuilder()

        Querys.AppendLine("SELECT sisper.perapl AS cod_apl,")
        Querys.AppendLine("sipro.pronom AS desc_apl,")
        Querys.AppendLine("siprotip.protipcod cod_ind,")
        Querys.AppendLine("siprotip.protipnom desc_ind,")
        Querys.AppendLine("siproind.proindcod AS cod_tip,")
        Querys.AppendLine("siproind.proindnom AS desc_tip,")
        Querys.AppendLine("CASE")
        Querys.AppendLine("WHEN sisper.peranu = '0' THEN 'Activo'")
        Querys.AppendLine("ELSE 'Inactivo'")
        Querys.AppendLine("END AS estado,")
        Querys.AppendLine("sisper.persed AS sede, '0' AS nuevo,'0' AS actualizar, ROW_NUMBER() OVER (ORDER BY sisper.perapl) AS fila")
        Querys.AppendLine("FROM sisper")
        Querys.AppendLine("INNER JOIN sipro ON sipro.procod = sisper.perapl")
        Querys.AppendLine("INNER JOIN siprotip ON siprotip.protipcod = sipro.protip")
        Querys.AppendLine("INNER JOIN siproind ON siproind.proindcod = sipro.proind")
        Querys.AppendLine("WHERE sisper.perid = '" & variable.usuario & "'")
        Querys.AppendLine("AND  sipro.protip='P'" & variable.cadena)


        Return gestorBaseDatos.ejecutarQuery_SQL(Querys.ToString())
    End Function

    Function Consultar_aplicativos_sin_permisos(ByVal variable As Datos, ByVal conex As String) As DataTable

        Dim Querys As New StringBuilder()

        Querys.AppendLine("SELECT pro.procod AS cod_apl,")
        Querys.AppendLine("pro.pronom AS desc_apl,")
        Querys.AppendLine("siprotip.protipcod cod_ind,")
        Querys.AppendLine("siprotip.protipnom desc_ind,")
        Querys.AppendLine("siproind.proindcod AS cod_tip,")
        Querys.AppendLine("siproind.proindnom AS desc_tip")
        Querys.AppendLine("FROM sipro AS pro")
        Querys.AppendLine("INNER JOIN siprotip ON siprotip.protipcod = pro.protip")
        Querys.AppendLine("INNER JOIN siproind ON siproind.proindcod = pro.proind")
        Querys.AppendLine("WHERE  pro.protip='P' AND  pro.procod  NOT in  (SELECT sisper.perapl AS cod_apl")
        Querys.AppendLine("FROM sisper")
        Querys.AppendLine("WHERE sisper.perid = '" & variable.usuario & "'")
        Querys.AppendLine("AND   sisper.persed = '" & variable.cod_sede & "')")
        'Querys.AppendLine("AND   sisper.peranu = '0')")


        Return gestorBaseDatos.ejecutarQuery(Querys.ToString())
    End Function
End Class
