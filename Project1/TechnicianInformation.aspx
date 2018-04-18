<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TechnicianInformation.aspx.cs" Inherits="Project1.Technician" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Technician Information</title>
</head>
<body>
    <form id="form1" runat="server">
        <div style="height: 635px">
            <asp:Label ID="lblTechInfo" runat="server" Font-Bold="True" Font-Size="X-Large" style="z-index: 1; left: 400px; top: 50px; position: absolute" Text="Technician Maintenance"></asp:Label>
            <asp:Button ID="btnTechReturn" runat="server" style="z-index: 1; left: 88px; top: 117px; position: absolute" Text="Return to Main Menu" OnClick="btnTechReturn_Click" />
            <asp:Label ID="lblTechnician" runat="server" height="19px" style="z-index: 1; left: 94px; top: 170px; position: absolute" Text="Technician:"></asp:Label>
            <asp:Label ID="lblFirstName" runat="server" height="19px" style="z-index: 1; left: 94px; top: 210px; position: absolute" Text="*First Name:"></asp:Label>
            <asp:TextBox ID="txtMiddleInitial" runat="server" style="z-index: 1; left: 207px; top: 250px; position: absolute; width: 21px;" MaxLength="1" TabIndex="2"></asp:TextBox>
            <asp:TextBox ID="txtLastName" runat="server" style="z-index: 1; left: 207px; top: 290px; position: absolute; bottom: 352px;" TabIndex="3"></asp:TextBox>
            <asp:TextBox ID="txtEMail" runat="server" style="z-index: 1; left: 207px; top: 330px; position: absolute" TabIndex="4"></asp:TextBox>
            <asp:TextBox ID="txtDepartment" runat="server" style="z-index: 1; left: 207px; top: 370px; position: absolute" TabIndex="5"></asp:TextBox>
            <asp:TextBox ID="txtPhone" runat="server" style="z-index: 1; left: 207px; top: 410px; position: absolute" MaxLength="10" TabIndex="6"></asp:TextBox>
            <asp:TextBox ID="txtHourlyRate" runat="server" style="z-index: 1; left: 207px; top: 450px; position: absolute" TabIndex="7"></asp:TextBox>
            <asp:DropDownList ID="ddlTechnician" runat="server" style="z-index: 1; left: 208px; top: 170px; position: absolute; width: 191px" Autopostback="True" OnSelectedIndexChanged ="ddlTechnician_SelectedIndexChanged">
            </asp:DropDownList>
            <asp:Label ID="lblMiddleInitial" runat="server" height="19px" style="z-index: 1; left: 94px; top: 250px; position: absolute" Text="Middle Initial:"></asp:Label>
            <asp:Label ID="lblLastName" runat="server" height="19px" style="z-index: 1; left: 94px; top: 290px; position: absolute" Text="*Last Name:"></asp:Label>
            <asp:Label ID="lblEMail" runat="server" height="19px" style="z-index: 1; left: 94px; top: 330px; position: absolute" Text="E-mail:"></asp:Label>
            <asp:Label ID="lblDepartment" runat="server" style="z-index: 1; left: 94px; top: 370px; position: absolute" Text="Department:"></asp:Label>
            <asp:Label ID="lblPhone" runat="server" height="19px" style="z-index: 1; left: 94px; top: 410px; position: absolute" Text="*Phone:"></asp:Label>
            <asp:Label ID="lblHourlyRate" runat="server" height="19px" style="z-index: 1; left: 94px; top: 450px; position: absolute" Text="*Hourly Rate:"></asp:Label>
            <asp:Label ID="lblRequiredInfo" runat="server" Font-Size="Medium" ForeColor="#0033CC" style="z-index: 1; left: 71px; top: 490px; position: absolute" Text="* indicates required information"></asp:Label>
            <asp:Button ID="btnTechAccept" runat="server" height="26px" style="z-index: 1; left: 80px; top: 530px; position: absolute; right: 1153px;" Text="Accept" width="68px" Enabled="False" OnClick="btnTechAccept_Click" />
            <asp:Button ID="btnTechCancel" runat="server" height="26px" style="z-index: 1; left: 220px; top: 530px; position: absolute" Text="Cancel" width="68px" Enabled="False" OnClick="btnTechCancel_Click" />
            <asp:Button ID="btnTechRemove" runat="server" style="z-index: 1; left: 360px; top: 530px; position: absolute" Text="Remove" Enabled="False" OnClick="btnTechRemove_Click" />
            <asp:Button ID="btnTechClear" runat="server" height="26px" style="z-index: 1; left: 500px; top: 530px; position: absolute" Text="Clear" width="68px" Enabled="False" OnClick="btnTechClear_Click" />
            <asp:TextBox ID="txtFirstName" runat="server" style="z-index: 1; left: 207px; top: 210px; position: absolute" TabIndex="1"></asp:TextBox>
            <asp:Button ID="btnNewTechnician" runat="server" style="z-index: 1; left: 424px; top: 168px; position: absolute" Text="New Technician" OnClick="btnNewTechnician_Click" />
            <asp:Label ID="lblError" runat="server" ForeColor="Red" style="z-index: 1; left: 94px; top: 602px; position: absolute" Text="error"></asp:Label>
        </div>
    </form>
</body>
</html>
