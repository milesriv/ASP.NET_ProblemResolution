<%@ Page Title="Report Selection" Language="C#" MasterPageFile="~/Report.Master" AutoEventWireup="true" CodeBehind="ReportSelection.aspx.cs" Inherits="Project1.ReportSelection1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="cssReport.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <asp:Label ID="lblTitle" runat="server" Font-Bold="True" style="z-index: 1; left: 57px; top: 150px; position: absolute" Text="Report Selection" Font-Size="X-Large"></asp:Label>
        <asp:Button ID="btnReturn" runat="server" style="z-index: 1; left: 57px; top: 250px; position: absolute; width: 200px" Text="Return to Main Menu" OnClick="btnReturn_Click" />
        <asp:DropDownList ID="ddlReports" runat="server" style="z-index: 1; left: 57px; top: 300px; position: absolute" OnSelectedIndexChanged="ddlReports_SelectedIndexChanged">
            <asp:ListItem Value="SELECT">-- SELECT REPORT --</asp:ListItem>
            <asp:ListItem Value="Institution">Problems By Institution</asp:ListItem>
            <asp:ListItem Value="Client">Problems By Client</asp:ListItem>
            <asp:ListItem Value="Product">Problems By Product</asp:ListItem>
            <asp:ListItem Value="Technician">Problems By Technician</asp:ListItem>
        </asp:DropDownList>
        <asp:Button ID="btnDisplayReport" runat="server" style="z-index: 1; left: 57px; top: 350px; position: absolute" Text="Display Report" OnClick="btnDisplayReport_Click" />
        <asp:Label ID="lblError" runat="server" style="z-index: 1; left: 57px; top: 400px; position: absolute" Text="Error" ForeColor="Red"></asp:Label>

</asp:Content>
