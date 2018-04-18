<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProblemEntry.aspx.cs" Inherits="Project1.ProblemEntry" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Problem Entry</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="lblTitle" runat="server" Font-Bold="True" Font-Size="X-Large" style="z-index: 1; left: 400px; top: 50px; position: absolute" Text="Problem Entry"></asp:Label>
        </div>
        <asp:Button ID="btnReturnService" runat="server" OnClick="btnReturnService_Click" style="z-index: 1; left: 88px; top: 117px; position: absolute; width: 156px" Text="Return to Service" />
        <asp:Label ID="lblTicket" runat="server" style="z-index: 1; left: 94px; top: 170px; position: absolute" Text="Ticket No:"></asp:Label>
        <asp:Label ID="lblTicketActual" runat="server" style="z-index: 1; left: 205px; top: 170px; position: absolute" Text="Ticket#"></asp:Label>
        <asp:Label ID="lblProblemNo" runat="server" style="z-index: 1; left: 94px; top: 210px; position: absolute" Text="Problem No:"></asp:Label>
        <asp:Label ID="lblProblemNoActual" runat="server" style="z-index: 1; left: 205px; top: 210px; position: absolute" Text="Problem#"></asp:Label>
        <asp:Label ID="lblProductNo" runat="server" style="z-index: 1; left: 94px; top: 250px; position: absolute" Text="*Product No:"></asp:Label>
        <asp:DropDownList ID="ddlProducts" runat="server" style="z-index: 1; left: 205px; top: 250px; position: absolute; width: 211px" OnSelectedIndexChanged="ddlProducts_SelectedIndexChanged">
        </asp:DropDownList>
        <asp:Label ID="lblProblemDesc" runat="server" style="z-index: 1; left: 94px; top: 290px; position: absolute" Text="*Problem:"></asp:Label>
        <asp:TextBox ID="txtProblem" runat="server" style="z-index: 1; left: 205px; top: 290px; position: absolute; height: 150px; width: 361px" TextMode="MultiLine" MaxLength="500"></asp:TextBox>
        <asp:Label ID="lblTechnician" runat="server" style="z-index: 1; left: 94px; top: 490px; position: absolute" Text="*Technician:"></asp:Label>
        <asp:DropDownList ID="ddlTechnician" runat="server" style="z-index: 1; left: 205px; top: 490px; position: absolute; width: 220px" OnSelectedIndexChanged="ddlTechnician_SelectedIndexChanged">
        </asp:DropDownList>
        <asp:Label ID="lblRequiredInfo" runat="server" ForeColor="#D91739" style="z-index: 1; left: 94px; top: 530px; position: absolute" Text="* indicates required information"></asp:Label>
        <asp:Button ID="btnSubmit" runat="server" style="z-index: 1; left: 94px; top: 570px; position: absolute; width: 100px" Text="Submit" OnClick="btnSubmit_Click" />
        <asp:Button ID="btnClear" runat="server" style="z-index: 1; left: 300px; top: 570px; position: absolute; width: 100px" Text="Clear" OnClick="btnClear_Click" />
        <asp:Label ID="lblError" runat="server" ForeColor="Red" style="z-index: 1; left: 94px; top: 610px; position: absolute; right: 707px" Text="Error"></asp:Label>
    </form>
</body>
</html>
