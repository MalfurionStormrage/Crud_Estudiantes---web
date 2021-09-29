<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site1.Master" CodeBehind="index.aspx.vb" Inherits="Crud_Estudiantes___web.index" %>

<%@ Register Assembly="DevExpress.Web.v18.1, Version=18.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Scripts -->
    <script type="text/javascript">
        /* ECMAScript 2015 -> ES6 */
        //iniciar callback de consultar de gridview table_estudiante
        const consultar = () => table_estudiante.PerformCallback("consultar");
        const guardar = () => table_estudiante.PerformCallback("guardar");
        const limpiar = () => table_estudiante.PerformCallback("limpiar");
        //end callback de gridview table_estudiante
        function End_table_estudiante(s, e) {
            const msg = table_estudiante.cpMsg;
            const msgSplit = msg.split("§");

            if (msgSplit[0] == 1) {
                Swal.fire({
                    title: `Error en la consulta , causa: ${msgSplit[1]}`,
                    icon: "error",
                    toast: true,
                    timerProgressBar: true,
                    position: 'bottom-end',
                    showConfirmButton: false,
                    timer: 2500,
                });
            }
        };
        //evento selecionar una fila con el check en gridview table_estudiante
        function grid_SelectionChanged(s, e) {
            s.GetSelectedFieldValues("ID_E", GetSelectedFieldValuesCallback_estudiante);//obtener id del estudiante en la gridview table_estudiante
        };
        //enviar id del estudiante para consultar las notas y cargar en gridview tabla_notas_estudiantes
        function GetSelectedFieldValuesCallback_estudiante(values) {
            var va = [];

            for (var i = 0; i < values.length; i++) {
                va.push(values[i]);
            }
            tabla_notas_estudiantes.PerformCallback("Consultar," + va)
        };
        //endcallback table_notas_estudiantes
        function End_table_notas(s, e) {
            End_table_estudiante(s, e);
        }
        //========================================== VALIDADOR TEXTO =======================================================
        // Validar solo numeros
        function Validador_solo_numero(e) {
            key = e.keyCode || e.which;
            tecla = String.fromCharCode(key).toLowerCase();
            //letras = "qwertyuiopñlkjhgfdsazxcvbnmQWERTYUIOPÑLKJHGFDSAZXCVBNM0123456789 ";
            letras = "0123456789 ";
            especiales = "37-39-46";

            tecla_especial = false
            for (var i in especiales) {
                if (key == especiales[i]) {
                    tecla_especial = true;
                    break;
                }
            }

            if (letras.indexOf(tecla) == -1 && !tecla_especial) {
                return false;
            }
        }
        //Validar solo letras 
        function Validador_solo_lestras(e) {
            key = e.keyCode || e.which;
            tecla = String.fromCharCode(key).toLowerCase();
            letras = "qwertyuiopñlkjhgfdsazxcvbnmQWERTYUIOPÑLKJHGFDSAZXCVBNM0123456789 ";
            //letras = "0123456789 ";
            especiales = "37-39-46";

            tecla_especial = false
            for (var i in especiales) {
                if (key == especiales[i]) {
                    tecla_especial = true;
                    break;
                }
            }

            if (letras.indexOf(tecla) == -1 && !tecla_especial) {
                return false;
            }
        }
    </script>
    <!-- Scripts -->
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Contenido -->
    <main class="container">
        <section>
            <form runat="server">

                <div style="margin-left: 30px;">
                    <!-- botones de control -->
                    <div class="row" style="margin-left: 10px;">
                        <div class="col-md-12">
                            <dx:ASPxButton ID="btn_consultar" AutoPostBack="false" runat="server" Text="Consultar" Theme="MaterialCompact" Style="margin-top: 1rem;" Class="shadow m-1" ClientInstanceName="btn_consultar" Height="40px" Width="120px" Font-Bold="true" Font-Size="Small">
                                <ClientSideEvents Click="function(){consultar();}" />
                                <Image IconID="zoom_zoom_16x16" Height="16px" Width="16px">
                                </Image>
                            </dx:ASPxButton>
                            <dx:ASPxButton ID="btn_guardar" AutoPostBack="false" runat="server" Text="Guardar" Theme="MaterialCompact" CssClass="shadow" Style="margin-top: 1rem;" ClientInstanceName="btn_guardar" Height="40px" Width="120px" Font-Bold="true" Font-Size="Small">
                                <ClientSideEvents Click="function(){guardar();}" />
                                <Image IconID="save_save_16x16" Height="16px" Width="16px">
                                </Image>
                            </dx:ASPxButton>
                            <dx:ASPxButton ID="btn_limpiar" runat="server" AutoPostBack="false" Text="Limpiar" Theme="MaterialCompact" CssClass="shadow" Style="margin-top: 1rem;" ClientInstanceName="btn_limpiar" Height="40px" Width="120px" Font-Bold="true" Font-Size="Small">
                                <ClientSideEvents Click="function(){limpiar();}" />
                                <Image IconID="actions_clear_16x16" Height="16px" Width="16px">
                                </Image>
                            </dx:ASPxButton>
                            <dx:ASPxButton ID="btn_exportar" runat="server" Text="Exportar" Theme="MaterialCompact" CssClass="shadow" Style="margin-top: 1rem;" ClientInstanceName="btn_exportar" Height="40px" Width="120px" Font-Bold="true" Font-Size="Small">
                                <Image IconID="mail_sendxls_16x16" Height="16px" Width="16px"></Image>
                            </dx:ASPxButton>
                            <dx:ASPxButton ID="btn_imprimir" runat="server" Text="Imprimir" Theme="MaterialCompact" CssClass="shadow" Style="margin-top: 1rem;" ClientInstanceName="btn_imprimir" Height="40px" Width="120px" Font-Bold="true" Font-Size="Small">
                                <Image IconID="print_print_16x16" Height="16px" Width="16px"></Image>
                            </dx:ASPxButton>
                        </div>
                    </div>
                    <!-- botones de control -->
                    <br />
                    <dx:ASPxRoundPanel ID="panel_sede" runat="server" HeaderText="Gestion De Estudiantes" ClientVisible="True" ClientIDMode="Static" ClientInstanceName="panel_sede" Width="100%"
                        Theme="MaterialCompact" View="GroupBox" Visible="true">
                        <PanelCollection>
                            <dx:PanelContent>
                                <div class="container" style="padding: 2rem;">
                                    <div class="row">
                                        <div class="col-sm-6">
                                            <label for="txt_iden_estudiante">Identificacion: &nbsp;</label>
                                            <dx:ASPxTextBox ID="ASPxTextBox1" ClientInstanceName="txt_iden_estudiante" CssClass="form-control no-rad w-100" ClientIDMode="Static"
                                                ReadOnly="false" onkeypress="return Validador_solo_numero(event)" BackColor="LightYellow" Font-Size="8.5pt"
                                                NullText="Identificacion Del Estudiante" ToolTip="Identificacion Del Estudiante" runat="server" Width="100%">
                                            </dx:ASPxTextBox>
                                        </div>
                                        <div class="col-sm-6">
                                            <label for="txt_nom_estudiante">Nombre: &nbsp;</label>
                                            <dx:ASPxTextBox ID="txt_nom_estudiante" ClientInstanceName="txt_nom_estudiante" CssClass="form-control no-rad" ClientIDMode="Static"
                                                ReadOnly="false" onkeypress="return Validador_solo_lestras(event)" BackColor="LightYellow" Font-Size="8.5pt"
                                                NullText="Nombre Del Estudiante" ToolTip="Nombre Del Estudiante" runat="server" Width="100%">
                                            </dx:ASPxTextBox>
                                        </div>
                                        <div class="col-sm-2">
                                            <label for="txt_edad_estudiante">Edad: &nbsp;</label>
                                            <dx:ASPxTextBox ID="txt_edad_estudiante" ClientInstanceName="txt_edad_estudiante" CssClass="form-control no-rad" ClientIDMode="Static"
                                                ReadOnly="true" BackColor="LightYellow" Font-Size="8.5pt"
                                                NullText="Edad Del Estudiante" ToolTip="Edad Del Estudiante" runat="server" Width="100%">
                                            </dx:ASPxTextBox>
                                        </div>
                                        <div class="col-sm-2">
                                            <label for="txt_carrera_estudiante">Carrera : &nbsp;</label>
                                            <dx:ASPxTextBox ID="txt_carrera_estudiante" ClientInstanceName="txt_carrera_estudiante" CssClass="form-control no-rad" ClientIDMode="Static"
                                                ReadOnly="true" BackColor="LightYellow" Font-Size="8.5pt"
                                                NullText="Carrera Del Estudiante" ToolTip="Carrera Del Estudiante" runat="server" Width="100%">
                                            </dx:ASPxTextBox>
                                        </div>
                                        <div class="col-sm-8">
                                            <label for="txt_usuario_estudiante">usuario: &nbsp;</label>
                                            <dx:ASPxTextBox ID="txt_usuario_estudiante" ClientInstanceName="txt_usuario_estudiante" CssClass="form-control no-rad" ClientIDMode="Static"
                                                ReadOnly="true" BackColor="LightYellow" Font-Size="8.5pt"
                                                NullText="Usuario Que Adiciona" ToolTip="Usuario Que Adiciona" runat="server" Width="100%">
                                            </dx:ASPxTextBox>
                                        </div>
                                    </div>
                                </div>

                                <div class="row" style="margin-left: 5px;">
                                    <div class="col-md-7">
                                        <dx:ASPxRoundPanel ID="panel_estudiantes" runat="server" HeaderText="Tabla Estudiantes"
                                            ClientVisible="True" ClientIDMode="Static" ClientInstanceName="panel_estudiantes" Width="100%"
                                            Theme="MaterialCompact" View="GroupBox" Visible="true">
                                            <PanelCollection>
                                                <dx:PanelContent>

                                                    <dx:ASPxGridView ID="table_estudiante" runat="server" AutoGenerateColumns="true" Theme="MaterialCompact"
                                                        ClientIDMode="Static" ClientInstanceName="table_estudiante" KeyFieldName="ID_E"
                                                        PreviewFieldName="ID_E" Width="100%" Font-Size="Small" ClientVisible="true">
                                                        <ClientSideEvents EndCallback="function (s,e) { End_table_estudiante(); }" SelectionChanged="grid_SelectionChanged"></ClientSideEvents>
                                                        <SettingsSearchPanel Visible="true" />
                                                        <SettingsLoadingPanel Mode="ShowAsPopup" />
                                                        <SettingsBehavior AllowFocusedRow="true" AllowSort="true" EnableRowHotTrack="True" />

                                                        <SettingsText SearchPanelEditorNullText="Filtro de busqueda" />
                                                        <Columns>
                                                            <dx:GridViewCommandColumn ShowSelectCheckbox="True" ShowClearFilterButton="true" Width="50px" SelectAllCheckboxMode="Page" />
                                                            <dx:GridViewDataTextColumn Caption="ID_E" VisibleIndex="1" Width="90px" FieldName="ID_E">
                                                                <HeaderStyle HorizontalAlign="Center" Font-Bold="False" Font-Size="Small" />
                                                                <CellStyle HorizontalAlign="Center" Font-Size="Small">
                                                                </CellStyle>
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn Caption="Nombre" VisibleIndex="2" Width="320px" FieldName="Nombre">
                                                                <HeaderStyle HorizontalAlign="Center" Font-Bold="False" Font-Size="Small" />
                                                                <CellStyle HorizontalAlign="Left" Font-Size="Small">
                                                                </CellStyle>
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn Caption="Edad" VisibleIndex="3" Width="110px" FieldName="Edad">
                                                                <HeaderStyle HorizontalAlign="Center" Font-Bold="False" Font-Size="Small" />
                                                                <CellStyle HorizontalAlign="Center" Font-Size="Small">
                                                                </CellStyle>
                                                            </dx:GridViewDataTextColumn>

                                                            <dx:GridViewDataTextColumn Caption="carrera" VisibleIndex="4" Width="100px" FieldName="carrera">
                                                                <HeaderStyle HorizontalAlign="Center" Font-Bold="False" Font-Size="Small" />
                                                                <CellStyle HorizontalAlign="Center" Font-Size="Small">
                                                                </CellStyle>
                                                            </dx:GridViewDataTextColumn>
                                                        </Columns>

                                                    </dx:ASPxGridView>
                                                </dx:PanelContent>
                                            </PanelCollection>
                                        </dx:ASPxRoundPanel>
                                    </div>

                                    <div class="col-md-5">
                                        <dx:ASPxRoundPanel ID="panel_notas_estudiantes" runat="server" HeaderText="Tabla Notas De Estudiantes"
                                            ClientVisible="True" ClientIDMode="Static" ClientInstanceName="panel_notas_estudiantes" Width="100%"
                                            Theme="MaterialCompact" View="GroupBox" Visible="true">
                                            <PanelCollection>
                                                <dx:PanelContent>

                                                    <dx:ASPxGridView ID="tabla_notas_estudiantes" runat="server" AutoGenerateColumns="true" Theme="MaterialCompact"
                                                        ClientIDMode="Static" ClientInstanceName="tabla_notas_estudiantes" KeyFieldName="ID_Estudiante"
                                                        PreviewFieldName="ID_Estudiantes" Width="100%" Font-Size="Small" ClientVisible="true">
                                                        <ClientSideEvents EndCallback="function (s,e) { End_table_notas(); }"></ClientSideEvents>
                                                        <SettingsSearchPanel Visible="true" />
                                                        <SettingsLoadingPanel Mode="ShowAsPopup" />
                                                        <SettingsBehavior AllowFocusedRow="true" AllowSort="true" EnableRowHotTrack="True" />

                                                        <SettingsText SearchPanelEditorNullText="Filtro de busqueda" />
                                                        <Columns>
                                                            <dx:GridViewDataTextColumn Caption="ID_Estudiante" VisibleIndex="1" Width="40px" FieldName="ID_Estudiante">
                                                                <HeaderStyle HorizontalAlign="Center" Font-Bold="False" Font-Size="Small" />
                                                                <CellStyle HorizontalAlign="Center" Font-Size="Small">
                                                                </CellStyle>
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn Caption="Materia" VisibleIndex="2" Width="450px" FieldName="Materia">
                                                                <HeaderStyle HorizontalAlign="Center" Font-Bold="False" Font-Size="Small" />
                                                                <CellStyle HorizontalAlign="Left" Font-Size="Small">
                                                                </CellStyle>
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn Caption="Nota_1" VisibleIndex="3" Width="40px" FieldName="Nota_1">
                                                                <HeaderStyle HorizontalAlign="Center" Font-Bold="False" Font-Size="Small" />
                                                                <CellStyle HorizontalAlign="Center" Font-Size="Small">
                                                                </CellStyle>
                                                            </dx:GridViewDataTextColumn>

                                                            <dx:GridViewDataTextColumn Caption="Nota_2" VisibleIndex="4" Width="40px" FieldName="Nota_2">
                                                                <HeaderStyle HorizontalAlign="Center" Font-Bold="False" Font-Size="Small" />
                                                                <CellStyle HorizontalAlign="Center" Font-Size="Small">
                                                                </CellStyle>
                                                            </dx:GridViewDataTextColumn>

                                                            <dx:GridViewDataTextColumn Caption="Nota_3" VisibleIndex="5" Width="40px" FieldName="Nota_3">
                                                                <HeaderStyle HorizontalAlign="Center" Font-Bold="False" Font-Size="Small" />
                                                                <CellStyle HorizontalAlign="Center" Font-Size="Small">
                                                                </CellStyle>
                                                            </dx:GridViewDataTextColumn>
                                                        </Columns>

                                                    </dx:ASPxGridView>
                                                </dx:PanelContent>
                                            </PanelCollection>
                                        </dx:ASPxRoundPanel>
                                    </div>
                                </div>



                            </dx:PanelContent>
                        </PanelCollection>
                    </dx:ASPxRoundPanel>
                </div>
                <br />
            </form>
        </section>
    </main>
    <br />
    <br />
    <!-- Contenido -->
</asp:Content>
