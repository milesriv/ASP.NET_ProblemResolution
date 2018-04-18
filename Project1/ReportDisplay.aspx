<%@ Page Title="" Language="C#" MasterPageFile="~/Report.Master" AutoEventWireup="true" CodeBehind="ReportDisplay.aspx.cs" Inherits="Project1.ReportDisplay1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="cssReport.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <asp:Label ID="lblTitle" runat="server" Font-Bold="True" style="z-index: 1; left: 57px; top: 152px; position: absolute" Text="Problems by" Font-Size="X-Large"></asp:Label>
        <asp:Button ID="btnReturn" runat="server" style="z-index: 1; left: 57px; top: 226px; position: absolute; width: 200px" Text="Return to Report Selection" OnClick="btnReturn_Click" />
        <asp:GridView ID="gvReport" cssClass="gvCSS"  AlternatingRowStyle-CssClass="gvCSSAlt" runat="server" style="z-index: 1; left: 57px; top: 313px; position: absolute; ">
    </asp:GridView>
        <asp:Label ID="lblError" runat="server" Font-Bold="False" ForeColor="Red" style="z-index: 1; left: 64px; top: 528px; position: absolute" Text="Error"></asp:Label>

</asp:Content>
