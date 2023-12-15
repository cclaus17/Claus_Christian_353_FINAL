using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace WebFormsIdentity
{
    public partial class SearchHistory : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Load search history when the page is first loaded
                LoadSearchHistory();
            }
        }

        private void LoadSearchHistory()
        {
            // Connect to the database and retrieve search history data
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["WeatherDataDB"].ConnectionString))
            {
                conn.Open();
                using (SqlCommand cmd = new SqlCommand("SELECT * FROM SearchHistory", conn))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        // Bind the data to the GridView
                        SearchHistoryGridView.DataSource = dt;
                        SearchHistoryGridView.DataBind();
                    }
                }
            }
        }
    }
}
