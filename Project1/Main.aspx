<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Main.aspx.cs" Inherits="Project1.Main" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Main</title>
</head>
<body>
    <form id="form1" runat="server">
        <div style="height: 579px">
            <asp:Button ID="btnService" runat="server" height="26px" style="z-index: 1; left: 372px; top: 129px; position: absolute" Text="Service Event" width="181px" OnClick="btnService_Click" />
            <asp:Button ID="btnProblem" runat="server" height="26px" style="z-index: 1; left: 372px; top: 184px; position: absolute" Text="Problem Resolution" width="181px" OnClick="btnProblem_Click" />
            <asp:Button ID="btnReports" runat="server" height="26px" style="z-index: 1; left: 372px; top: 245px; position: absolute; bottom: 393px" Text="Reports" width="181px" OnClick="btnReports_Click" />
            <asp:Button ID="btnManage" runat="server" style="z-index: 1; left: 372px; top: 308px; position: absolute; width: 182px" Text="Manage Technicians" OnClick="btnManage_Click" />
            <asp:Label ID="lblMainTitle" runat="server" style="z-index: 1; left: 400px; top: 50px; position: absolute" Text="Main Form" Font-Bold="True" Font-Size="X-Large"></asp:Label>
        </div>
    </form>
</body>
</html>
