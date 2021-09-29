Imports System.Configuration
Imports System.Data.SqlClient

Public MustInherit Class Connection

    Protected SqlCommand As New SqlCommand()
    Protected ReadOnly connectionStringDb As New SqlConnection(ConfigurationManager.ConnectionStrings("StringConnectionDB").ToString())

End Class
