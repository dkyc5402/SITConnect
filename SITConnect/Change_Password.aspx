<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Change_Password.aspx.cs" Inherits="SITConnect.Change_Password" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            width: 100%;
        }
        .auto-style2 {
            width: 354px;
        }
    </style>

    <script>
        //client side password complexity check
        function validatePassword() {
            var str = document.getElementById('<%=tb_password.ClientID%>').value;
            if (str.length < 8) {
                document.getElementById("lb_pwdcheck").innerHTML = "Password Length Must be at least 8 characters";
                document.getElementById("lb_pwdcheck").style.color = "Red";
                return ("too_short");
            }
            else if (str.search(/[0-9]/) == -1) {
                document.getElementById("lb_pwdcheck").innerHTML = "Password requires at least 1 numeral";
                document.getElementById("lb_pwdcheck").style.color = "Red";
                return ("no_number")
            }
            else if (str.search(/[A-Z]/) == -1) {
                document.getElementById("lb_pwdcheck").innerHTML = "Password requires at least 1 upper case letter";
                document.getElementById("lb_pwdcheck").style.color = "Red";
                return ("no_upper")
            }
            else if (str.search(/[a-z]/) == -1) {
                document.getElementById("lb_pwdcheck").innerHTML = "Password requires at least 1 lower case letter";
                document.getElementById("lb_pwdcheck").style.color = "Red";
                return ("no_lower")
            }
            else if (str.search(/[^A-Za-z0-9]/) == -1) {
                document.getElementById("lb_pwdcheck").innerHTML = "Password requires at least 1 special character";
                document.getElementById("lb_pwdcheck").style.color = "Red";
                return ("no_specialchar");
            }

            document.getElementById("lb_pwdcheck").innerHTML = "Excellent";
            document.getElementById("lb_pwdcheck").style.color = "Blue";

        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <h1 style="align-content:center; text-align: center;">SITConnect</h1>
            <hr />
        <h2>Change Password</h2>
        <div>
            <table class="auto-style1">
                <tr>
                    <td class="auto-style2">
                        <asp:Label ID="Label1" runat="server" Text="New Password"></asp:Label>
                        :</td>
                    <td >
                            <asp:TextBox ID="tb_password" TextMode="Password" Width="70%" runat="server" onkeyup="javascript:validatePassword()"></asp:TextBox>
                            <asp:Label ID="lb_pwdcheck" runat="server"></asp:Label>
                            </td>
                </tr>
                <tr>
                    <td class="auto-style2">
                        <asp:Label ID="Label2" runat="server" Text="Confirm New Password"></asp:Label>
                        :</td>
                    <td >
                            <asp:TextBox ID="tb_pwd2" Textmode="Password" Width="70%" runat="server"></asp:TextBox>
                            <asp:Label ID="lb_cfmpwdcheck" runat="server"></asp:Label>
                            </td>
                </tr>
                <tr>
                    <td class="auto-style2">
                        <asp:Label ID="lb_error" runat="server"></asp:Label>
                    </td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style2">
                        <asp:Button ID="btn_submit" runat="server" BorderStyle="Solid" Text="Submit" OnClick="btn_submit_Click" />
                    </td>
                    <td>&nbsp;</td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
