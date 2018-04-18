<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ServiceEvent.aspx.cs" Inherits="Project1.ServiceEvent" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Service Event</title>
</head>
<body>
    <form id="form1" runat="server">
        <div style="height: 600px">
            <asp:Label ID="lblServiceEvent" runat="server" style="z-index: 1; left: 400px; top: 50px; position: absolute" Text="Service Event Entry" Font-Bold="True" Font-Size="X-Large"></asp:Label>
            <asp:Button ID="btnServiceReturn" runat="server" style="z-index: 1; left: 88px; top: 117px; position: absolute" Text="Return to Main Menu" OnClick="btnServiceReturn_Click" />
            <asp:Label ID="lblEventDate" runat="server" height="19px" style="z-index: 1; left: 94px; top: 210px; position: absolute" Text="Event Date:"></asp:Label>
            <asp:Label ID="lblClient" runat="server" height="19px" style="z-index: 1; left: 94px; top: 250px; position: absolute" Text="*Client:"></asp:Label>
            <asp:Label ID="lblContact" runat="server" height="19px" style="z-index: 1; left: 94px; top: 290px; position: absolute" Text="*Contact:"></asp:Label>
            <asp:Label ID="lblPhone" runat="server" height="19px" style="z-index: 1; left: 94px; top: 330px; position: absolute" Text="*Phone:"></asp:Label>
            <asp:Label ID="lblRequiredInfo" runat="server" ForeColor="#D91739" style="z-index: 1; left: 94px; top: 370px; position: absolute" Text="* indicates required information" Font-Bold="False"></asp:Label>
            <asp:Label ID="lblEventDateActual" runat="server" style="z-index: 1; left: 203px; top: 210px; position: absolute" Text="EventDate"></asp:Label>
            <asp:DropDownList ID="ddlClient" runat="server" style="z-index: 1; left: 203px; top: 249px; position: absolute; width: 153px;" OnSelectedIndexChanged="ddlClient_SelectedIndexChanged">
            </asp:DropDownList>
            <asp:TextBox ID="txtContact" runat="server" style="z-index: 1; left: 203px; top: 289px; position: absolute" MaxLength="30"></asp:TextBox>
            <asp:TextBox ID="txtPhone" runat="server" style="z-index: 1; left: 204px; top: 327px; position: absolute" MaxLength="10"></asp:TextBox>
            <asp:Button ID="btnSubmit" runat="server" style="z-index: 1; left: 94px; top: 414px; position: absolute" Text="Submit" OnClick="btnSubmit_Click" />
            <asp:Button ID="btnReset" runat="server" height="26px" style="z-index: 1; left: 270px; top: 414px; position: absolute" Text="Reset" width="61px" />
            <asp:Label ID="lblError" runat="server" ForeColor="Red" style="z-index: 1; left: 94px; top: 481px; position: absolute" Text="Error"></asp:Label>
        </div>
    </form>
</body>
</html>
