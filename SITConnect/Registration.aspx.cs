using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text.RegularExpressions;
using System.Drawing;
using System.Security.Cryptography;
using System.Text;
using System.Data.SqlClient;
using System.Data;

namespace SITConnect
{
    public partial class Registration : System.Web.UI.Page
    {
        string MYDBConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["MYDBConnection"].ConnectionString;
        static string finalHash;
        static string salt;
        byte[] Key;
        byte[] IV;

        protected void Page_Load(object sender, EventArgs e)
        {

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
                //hash pwd with salt
                string pwd = tb_password.Text.ToString().Trim(); ;
                //Generate random "salt"
                RNGCryptoServiceProvider rng = new RNGCryptoServiceProvider();
                byte[] saltByte = new byte[8];
                //Fills array of bytes with a cryptographically strong sequence of random values.
                rng.GetBytes(saltByte);
                salt = Convert.ToBase64String(saltByte);
                SHA512Managed hashing = new SHA512Managed();
                string pwdWithSalt = pwd + salt;
                byte[] plainHash = hashing.ComputeHash(Encoding.UTF8.GetBytes(pwd));
                byte[] hashWithSalt = hashing.ComputeHash(Encoding.UTF8.GetBytes(pwdWithSalt));
                finalHash = Convert.ToBase64String(hashWithSalt);
                RijndaelManaged cipher = new RijndaelManaged();
                cipher.GenerateKey();
                Key = cipher.Key;
                IV = cipher.IV;
                //save registration
                createAccount();

                //Redirect to login page
                Response.Redirect("Login.aspx");

            }
            else
            {
                lb_error.Text = "Passwords do not match";
            }
        }

        //create account
        public void createAccount()
        {
            //try catch block to catch simple SQL injection through user input
            try
            {
                using (SqlConnection con = new SqlConnection(MYDBConnectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("INSERT INTO Account VALUES(@email,@first_name,@last_name,@dob,@PasswordHash, @PasswordSalt,@IV,@Key,@pwdhash_1,@pwdsalt_1,@pwdhash_2,@pwdsalt_2,@cc_number,@cc_expdate,@cc_cvc,@cc_name,@max_pwd_date,@min_pwd_date)"))
                    {
                        using (SqlDataAdapter sda = new SqlDataAdapter())
                        {
                            cmd.CommandType = CommandType.Text;
                            cmd.Parameters.AddWithValue("@email", tb_email.Text.Trim());
                            cmd.Parameters.AddWithValue("@first_name", tb_fname.Text.Trim());
                            cmd.Parameters.AddWithValue("@last_name", tb_lname.Text.Trim());
                            cmd.Parameters.AddWithValue("@dob", DateTime.Parse(tb_dob.Text.Trim()));
                            cmd.Parameters.AddWithValue("@PasswordHash", finalHash);
                            cmd.Parameters.AddWithValue("@PasswordSalt", salt);
                            cmd.Parameters.AddWithValue("@IV", Convert.ToBase64String(IV));
                            cmd.Parameters.AddWithValue("@Key", Convert.ToBase64String(Key));

                            //password history
                            cmd.Parameters.AddWithValue("@pwdhash_1", DBNull.Value);
                            cmd.Parameters.AddWithValue("@pwdsalt_1", DBNull.Value);
                            cmd.Parameters.AddWithValue("@pwdhash_2", DBNull.Value);
                            cmd.Parameters.AddWithValue("@pwdsalt_2", DBNull.Value);

                            //credit card info
                            cmd.Parameters.AddWithValue("@cc_number", Convert.ToBase64String(encryptData(tb_ccNumber.Text.Trim())));
                            cmd.Parameters.AddWithValue("@cc_expdate", Convert.ToBase64String(encryptData(tb_ccExp.Text.Trim())));
                            cmd.Parameters.AddWithValue("@cc_cvc", Convert.ToBase64String(encryptData(tb_ccCVC.Text.Trim())));
                            cmd.Parameters.AddWithValue("@cc_name", Convert.ToBase64String(encryptData(tb_ccName.Text.Trim())));

                            //max and min pwd 

                            var max_pwd = DateTime.Now.AddMinutes(15);
                            var min_pwd = DateTime.Now.AddMinutes(5);

                            cmd.Parameters.AddWithValue("@max_pwd_date", max_pwd);
                            cmd.Parameters.AddWithValue("@min_pwd_date", min_pwd);

                            cmd.Connection = con;
                            con.Open();
                            cmd.ExecuteNonQuery();
                            con.Close();
                        }
                    }
                }

            }
            catch (SqlException )
            {
                lb_error.Text = "Invalid inputs";
            }
            catch (Exception ex)
            {
                throw new Exception(ex.ToString());
            }
        }

        //encrypt function for credit card info
        protected byte[] encryptData(string data)
        {
            byte[] cipherText = null;
            try
            {
                RijndaelManaged cipher = new RijndaelManaged();
                cipher.IV = IV;
                cipher.Key = Key;
                ICryptoTransform encryptTransform = cipher.CreateEncryptor();
                byte[] plainText = Encoding.UTF8.GetBytes(data);
                cipherText = encryptTransform.TransformFinalBlock(plainText, 0, plainText.Length);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.ToString());
            }
            finally { }
            return cipherText;
        }


    }
}