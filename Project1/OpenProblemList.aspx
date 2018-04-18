<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OpenProblemList.aspx.cs" Inherits="Project1.ProblemList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Open Problem List</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
        </div>
        <asp:Label ID="lblTitle" runat="server" Font-Bold="True" Font-Size="X-Large" style="z-index: 1; left: 235px; top: 36px; position: absolute" Text="Open Problem List"></asp:Label>
        <asp:Button ID="btnReturn" runat="server" style="z-index: 1; left: 50px; top: 91px; position: absolute; width: 200px" Text="Return to Main Menu" OnClick="btnReturn_Click" />
        <asp:GridView ID="gvProblems" runat="server" style="z-index: 1; left: 36px; top: 156px; position: absolute; height: 258px; width: 728px" OnRowCommand="gvProblems_RowCommand">
            <Columns>
                <asp:ButtonField CommandName="SELECT" Text="Select" />
            </Columns>
        </asp:GridView>
        <asp:Label ID="lblError" runat="server" ForeColor="Red" style="z-index: 1; left: 41px; top: 449px; position: absolute" Text="Error"></asp:Label>
    </form>
</body>
</html>
