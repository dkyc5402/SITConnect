<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Details.aspx.cs" Inherits="SITConnect.Details" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            width: 100%;
        }
        .auto-style2 {
            height: 26px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
         <h1 style="align-content:center; text-align: center;">SITConnect</h1>
            <hr />
        <h2>Account Details</h2>

        <div>
            <h3>Profile</h3>
            <table class="auto-style1">
                <tr>
                    <td>
                        <asp:Label runat="server" Text="First Name:"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lb_fname" runat="server"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="Label6" runat="server" Text="Last Name:"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lb_lname" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label2" runat="server" Text="Email:"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lb_email" runat="server"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="Label7" runat="server" Text="Date of Birth:"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lb_dob" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style2" colspan="4">
                        <asp:HyperLink ID="hl_changepwd" runat="server" Font-Underline="True" ForeColor="Blue" NavigateUrl="~/Change_Password.aspx">Click here to change your password</asp:HyperLink>
                    </td>
                </tr>
            </table>

            <h3>Credit Card Information</h3>
            <table class="auto-style1">
                <tr>
                    <td>
                        <asp:Label ID="Label13" runat="server" Text="Last 4 Digits: "></asp:Label>
                        <asp:Label ID="lb_cc4" runat="server"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="Label14" runat="server" Text="Expiry Date: "></asp:Label>
                        <asp:Label ID="lb_ccExp" runat="server"></asp:Label>
                    </td>
                </tr>
            </table>
            <br />
        </div>
         <asp:Button ID="btn_logout" runat="server" Text="Log Out" OnClick="btn_logout_Click" />
    </form>
</body>
</html>
