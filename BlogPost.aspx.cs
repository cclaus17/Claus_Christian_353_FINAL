using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Claus_Christian_HW4_MIST353

{
    public partial class BlogPost : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadPosts();
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {

            string userName = txtUserName.Text; // Replace with actual user identity logic
            string title = txtTitle.Text.Trim();
            string content = txtContent.Text.Trim();

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["WeatherDataDB"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("INSERT INTO BlogPosts (Title, Content, PostDate, Author) VALUES (@Title, @Content, @PostDate, @Author)", conn))
                {
                    cmd.Parameters.AddWithValue("@Title", title);
                    cmd.Parameters.AddWithValue("@Content", content);
                    cmd.Parameters.AddWithValue("@PostDate", DateTime.Now);
                    cmd.Parameters.AddWithValue("@Author", userName);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            LoadPosts();
        }

        private void LoadPosts()
        {
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["WeatherDataDB"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT Title, Content, PostDate, Author FROM BlogPosts ORDER BY PostDate DESC", conn))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        GridViewPosts.DataSource = dt;
                        GridViewPosts.DataBind();
                    }
                }
            }
        }
    }
}
