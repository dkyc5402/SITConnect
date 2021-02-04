<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="SITConnect.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            width: 100%;
        }
        .link{
            color:blue;
            text-decoration:underline;
            text-align:center;
            align-content:center;
        }
        
        .auto-style2 {
            width: 366px;
        }
        
    </style>


    <script type ="text/javascript">

        //client side email input format validation
        function validateEmail() {
            var str = document.getElementById('<%=tb_email.ClientID%>').value;
            var format = /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/;

            if (str.match(format)) {
                document.getElementById("lb_emailcheck").innerHTML = "Valid Email format";
                document.getElementById("lb_emailcheck").style.color = "Red";
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
        <div>
            <h1 style="align-content:center; text-align: center;">SITConnect</h1>
            <hr />

            <div>
                
                <fieldset>
                <legend>Login:</legend>
                
                    <table class="auto-style1">
                        <tr>
                            <td class="auto-style2">
                                <asp:Label ID="lb_email" runat="server" Text="Email Address:"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="tb_email" runat="server" Width="50%" onkeyup="javascript:validateEmail()"></asp:TextBox>
                            <asp:Label ID="lb_emailcheck" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style2">
                                <asp:Label ID="lb_password" runat="server" Text="Password:"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="tb_password" runat="server" Width="50%" TextMode="Password"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style2">
                <asp:HyperLink ID="hl_register" runat="server" CssClass="link" NavigateUrl="~/Registration.aspx">Don&#39;t have an account? Register now !</asp:HyperLink>
                            </td>
                            <td>
                    <asp:Button ID="btn_login" runat="server"  Text="Login" OnClick="btn_login_Click" />
                            </td>
                        </tr>
                    </table>
                    <asp:Label ID="lb_error" runat="server"></asp:Label>
                    <br />
                    <asp:Label ID="tokenLabel" runat="server" Visible="false"></asp:Label>
                    
                    <br />
                </fieldset>
            </div>

        </div>
    </form>
</body>    <script src="https://www.google.com/recaptcha/api.js?render=6LeqzUgaAAAAAMFtPJSZF-qg8s_wxReUq3nDp5hu"></script>    <script>
        function onClick(e) {
            e.preventDefault();
            grecaptcha.ready(function () {
                grecaptcha.execute('6LeqzUgaAAAAAMFtPJSZF-qg8s_wxReUq3nDp5hu', { action: 'login' }).then(function (token) {
                    // Add your logic to submit to your backend server here.
                    document.getElementById("<%=tokenLabel.ClientID%>").textContent = token;
                });
            });
        }
</script>
  
</html>