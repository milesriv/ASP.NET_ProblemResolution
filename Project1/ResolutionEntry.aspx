<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ResolutionEntry.aspx.cs" Inherits="Project1.ResolutionEntry" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Resolution Entry</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
        </div>
        <asp:Label ID="lblTitle" runat="server" Font-Bold="True" Font-Size="X-Large" style="z-index: 1; left: 400px; top: 50px; position: absolute" Text="Resolution Entry"></asp:Label>
        <asp:Button ID="btnReturn" runat="server" style="z-index: 1; left: 88px; top: 117px; position: absolute" Text="Return to Problem List" OnClick="btnReturn_Click" />
        <asp:Label ID="lblTicketNo" runat="server" style="z-index: 1; left: 95px; top: 180px; position: absolute" Text="Ticket No:"></asp:Label>
        <asp:Label ID="lblTicketActual" runat="server" style="z-index: 1; left: 205px; top: 180px; position: absolute" Text="Ticket#"></asp:Label>
        <asp:Label ID="lblProblemNo" runat="server" style="z-index: 1; left: 95px; top: 220px; position: absolute" Text="Problem No:"></asp:Label>
        <asp:Label ID="lblProblemNoActual" runat="server" style="z-index: 1; left: 205px; top: 220px; position: absolute" Text="Problem#"></asp:Label>
        <asp:Label ID="lblResolutionNo" runat="server" style="z-index: 1; left: 95px; top: 260px; position: absolute" Text="Resolution No:"></asp:Label>
        <asp:Label ID="lblResolutionNoActual" runat="server" style="z-index: 1; left: 205px; top: 260px; position: absolute" Text="Resolution#"></asp:Label>
        <asp:Label ID="lblProblemDesc" runat="server" style="z-index: 1; left: 205px; top: 300px; position: absolute" Text="Problem Description"></asp:Label>
        <asp:Label ID="lblResolutionDesc" runat="server" style="z-index: 1; left: 95px; top: 340px; position: absolute" Text="*Resolution:"></asp:Label>
        <asp:TextBox ID="txtResolutionDesc" runat="server" style="z-index: 1; left: 205px; top: 340px; position: absolute; height: 77px; width: 439px" TextMode="MultiLine"></asp:TextBox>
        <asp:Label ID="lblTechnician" runat="server" style="z-index: 1; left: 95px; top: 450px; position: absolute" Text="*Technician:"></asp:Label>
        <asp:DropDownList ID="ddlTechnician" runat="server" style="z-index: 1; left: 205px; top: 450px; position: absolute; width: 242px" OnSelectedIndexChanged="ddlTechnician_SelectedIndexChanged">
        </asp:DropDownList>
        <asp:Label ID="lblHours" runat="server" style="z-index: 1; left: 95px; top: 500px; position: absolute" Text="*Hours:"></asp:Label>
        <asp:TextBox ID="txtHours" runat="server" style="z-index: 1; left: 175px; top: 500px; position: absolute; width: 51px"></asp:TextBox>
        <asp:Label ID="lblMileage" runat="server" style="z-index: 1; left: 325px; top: 500px; position: absolute" Text="Mileage:"></asp:Label>
        <asp:TextBox ID="txtMileage" runat="server" style="z-index: 1; left: 404px; top: 500px; position: absolute; width: 52px"></asp:TextBox>
        <asp:Label ID="lblCostMiles" runat="server" style="z-index: 1; left: 536px; top: 500px; position: absolute" Text="Cost Miles:"></asp:Label>
        <asp:TextBox ID="txtCostMiles" runat="server" style="z-index: 1; left: 620px; top: 500px; position: absolute; width: 51px"></asp:TextBox>
        <asp:Label ID="lblSupplies" runat="server" style="z-index: 1; left: 95px; top: 530px; position: absolute" Text="Supplies:"></asp:Label>
        <asp:TextBox ID="txtSupplies" runat="server" style="z-index: 1; left: 175px; top: 530px; position: absolute; width: 79px"></asp:TextBox>
        <asp:Label ID="lblMisc" runat="server" style="z-index: 1; left: 325px; top: 530px; position: absolute" Text="Misc:"></asp:Label>
        <asp:TextBox ID="txtMisc" runat="server" style="z-index: 1; left: 404px; top: 530px; position: absolute; width: 50px"></asp:TextBox>
        <asp:Label ID="lblDateFixed" runat="server" style="z-index: 1; left: 95px; top: 560px; position: absolute" Text="Date Fixed:"></asp:Label>
        <asp:TextBox ID="txtDateFixed" runat="server" style="z-index: 1; left: 175px; top: 560px; position: absolute" MaxLength="10"></asp:TextBox>
        <asp:Label ID="lblDateOnsite" runat="server" style="z-index: 1; left: 458px; top: 560px; position: absolute" Text="Date Onsite:"></asp:Label>
        <asp:TextBox ID="txtDateOnsite" runat="server" style="z-index: 1; left: 551px; top: 560px; position: absolute" MaxLength="10"></asp:TextBox>
        <asp:Label ID="lblRequiredInfo" runat="server" ForeColor="#D91739" style="z-index: 1; left: 94px; top: 635px; position: absolute" Text="*indicates required information"></asp:Label>
        <asp:Button ID="btnSubmit" runat="server" style="z-index: 1; left: 94px; top: 691px; position: absolute; width: 70px;" Text="Submit" OnClick="btnSubmit_Click" />
        <asp:Button ID="btnClear" runat="server" style="z-index: 1; left: 320px; top: 693px; position: absolute; width: 70px;" Text="Clear" OnClick="btnClear_Click" />
        <asp:Label ID="lblError" runat="server" ForeColor="Red" style="z-index: 1; left: 95px; top: 736px; position: absolute" Text="Error"></asp:Label>
        <asp:CheckBox ID="chkNoCharge" runat="server" style="z-index: 1; left: 535px; top: 530px; position: absolute" Text="No Charge:" TextAlign="Left" Font-Bold="True" />
        <asp:Label ID="lblDateDesc1" runat="server" style="z-index: 1; left: 175px; top: 582px; position: absolute" Text="MM/DD/YYYY" ForeColor="#9966FF"></asp:Label>
        <asp:Label ID="lblDateDesc2" runat="server" style="z-index: 1; left: 551px; top: 582px; position: absolute" Text="MM/DD/YYYY" ForeColor="#9966FF"></asp:Label>
        <asp:Label ID="lblProblemDescTitle" runat="server" style="z-index: 1; left: 95px; top: 300px; position: absolute" Text="Problem:"></asp:Label>
    </form>
</body>
</html>
