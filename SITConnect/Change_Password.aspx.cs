using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SITConnect
{
    public partial class Change_Password : System.Web.UI.Page
    {

        string userID = null;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["LoggedIn"] != null && Session["AuthToken"] != null && Request.Cookies["AuthToken"] != null)
            {
                if (!Session["AuthToken"].ToString().Equals(Request.Cookies["AuthToken"].Value))
                {
                    Response.Redirect("Login.aspx", false);
                }
                else
                {
                    userID = (string)Session["LoggedIn"];
                }
            }
            else
            {
                Response.Redirect("Login.aspx", false);
            }
        }

        //server side password complexity check
        private int checkPassword(string password)
        {
            int score = 0;
            //length
            if (password.Length < 8)
            {
                return 1;
            }
            else
            {
                score = 1;
            }
            // lower case
            if (Regex.IsMatch(password, "[a-z]"))
            {
                score++;
            }
            // upper case
            if (Regex.IsMatch(password, "[A-Z]"))
            {
                score++;
            }
            // numeral
            if (Regex.IsMatch(password, "[0-9]"))
            {
                score++;
            }
            //special characters
            if (Regex.IsMatch(password, "[^A-Za-z0-9]"))
            {
                score++;
            }
            return score;
        }

        //server side password complexity check
        private void Pwd_complexity_scoring()
        {
            int scores = checkPassword(tb_password.Text);
            string status = "";
            switch (scores)
            {
                case 1:
                    status = "Very Weak";
                    break;
                case 2:
                    status = "Weak";
                    break;
                case 3:
                    status = "Medium";
                    break;
                case 4:
                    status = "Strong";
                    break;
                case 5:
                    status = "Excellent";
                    break;

                default:
                    break;
            }
            lb_pwdcheck.Text = "Status:" + status;
            if (scores < 4)
            {
                lb_pwdcheck.ForeColor = Color.Red;
                return;
            }
            lb_pwdcheck.ForeColor = Color.Green;
        }

        //check password and confirm password are the same
        protected bool Cfm_password()
        {
            if (tb_password.Text != tb_pwd2.Text)
            {
                lb_cfmpwdcheck.Text = "Passwords do not match";
                lb_cfmpwdcheck.ForeColor = Color.Red;
                return false;
            }
            return true;
        }


        protected void btn_submit_Click(object sender, EventArgs e)
        {
            var success = true;
            Pwd_complexity_scoring();
            if (Cfm_password() == false)
            {
                success = false;
            };

            if (success == true)
            {

            }
            else
            {

            }
        }
    }
}