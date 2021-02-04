<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="SITConnect.Registration" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Registration</title>
    <style type="text/css">
        .auto-style1 {
            width: 100%;
        }
        .auto-style2 {
            width: 144px;
        }
        .auto-style4 {
            width: 235px;
        }
        .auto-style5 {
            width: 197px;
        }
        .auto-style6 {
            width: 250px;
        }
    </style>

    <script type ="text/javascript">
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

        //client side email input format validation
        function validateEmail() {
            var str = document.getElementById('<%=tb_email.ClientID%>').value;
            var format = /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/;

            if (str.match(format)) {
                document.getElementById("lb_emailcheck").innerHTML = "Valid Email";
                document.getElementById("lb_emailcheck").style.color = "Blue";
            }
            else {
                document.getElementById("lb_emailcheck").innerHTML = "Email format is incorrect";
                document.getElementById("lb_emailcheck").style.color = "Red";
            }
        }

    </script>



</head>
<body>
    <form id="form1" runat="server">
        <h1 style="align-content:center; text-align: center;">SITConnect</h1>
            <hr />
        <div>
            <fieldset>
                <legend>Registration:</legend>

                <table class="auto-style1">
                    <tr>
                        <td class="auto-style4">
                            <asp:Label ID="lb_fname" runat="server" Text="First Name:"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="tb_fname" Width="70%" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style4">
                            <asp:Label ID="lb_lname" runat="server" Text="Last Name:"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="tb_lname" Width="70%" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style4">
                            <asp:Label ID="lb_email" runat="server" Text="Email Address: "></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="tb_email" Width="70%" TextMode="Email" runat="server" onkeyup="javascript:validateEmail()"></asp:TextBox>
                            <asp:Label ID="lb_emailcheck" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style4">
                            <asp:Label ID="lb_password" runat="server" Text="Password:"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="tb_password" TextMode="Password" Width="70%" runat="server" onkeyup="javascript:validatePassword()"></asp:TextBox>
                            <asp:Label ID="lb_pwdcheck" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style4">
                            <asp:Label ID="lb_pwd2" runat="server" Text="Confirm Password:"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="tb_pwd2" Textmode="Password" Width="70%" runat="server"></asp:TextBox>
                            <asp:Label ID="lb_cfmpwdcheck" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style4">
                            <asp:Label ID="lb_dob" runat="server" Text="Date Of Birth: "></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="tb_dob" runat="server" placeholder="dd/mm/yyy"></asp:TextBox>
                        </td>
                    </tr>
                </table>
                <fieldset style="margin:10px;">
                    <legend class="auto-style2">Credit Card Info</legend>
                    <table align="center" cellpadding="2" class="auto-style1">
                        <tr>
                            <td class="auto-style5">
                                <asp:Label ID="lb_ccName" runat="server" Text="Name On Card:"></asp:Label>
                            </td>
                            <td colspan="3">
                                <asp:TextBox ID="tb_ccName" runat="server" Width="100%"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style5">
                                <asp:Label ID="lb_ccNumber" runat="server" Text="Credit Card Number:"></asp:Label>
                            </td>
                            <td colspan="3">
                                <asp:TextBox ID="tb_ccNumber" runat="server" Width="100%"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style5">
                                <asp:Label ID="lb_ccExp" runat="server" Text="Exp Date:"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="tb_ccExp" runat="server" Width="50%" MaxLength="5" placeholder="mm/yy"></asp:TextBox>
                            </td>
                            <td class="auto-style6">
                                <asp:Label ID="lb_ccCvc" runat="server" Text="CVC:"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="tb_ccCVC" runat="server" Width="50%" ></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </fieldset>

                <asp:Button ID="btn_submit" runat="server" Text="Register" OnClick="btn_submit_Click"/>
            &nbsp;<asp:Label ID="lb_error" runat="server"></asp:Label>
            </fieldset>
        </div>
        
    </form>
</body>
</html>
