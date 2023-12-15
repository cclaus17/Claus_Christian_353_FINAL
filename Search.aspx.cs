using Microsoft.AspNet.Identity;
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace Claus_Christian_HW4_MIST353
{
    public partial class Search : Page
    {
        protected void btnSearch_Click(object sender, EventArgs e)

        {
            string userName = txtUserName.Text;
            string minTemperature = txtMinTemperature.Text;
            string maxTemperature = txtMaxTemperature.Text;
            string selectedMonth = ddlMonth.SelectedValue;

            DataTable dt = SearchCities(minTemperature, maxTemperature, selectedMonth);
            LogSearch(userName, minTemperature, maxTemperature, selectedMonth);


            CitiesGridView.DataSource = dt;
            CitiesGridView.DataBind();

          
        }

        private void LogSearch(string userName, string minTemperature, string maxTemperature, string selectedMonth)
        {
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["WeatherDataDB"].ConnectionString))
            {
                conn.Open();
                using (SqlCommand cmd = new SqlCommand("TrackSearch", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@UserName", userName);
                    cmd.Parameters.AddWithValue("@MinTemperature", Convert.ToDecimal(minTemperature));
                    cmd.Parameters.AddWithValue("@MaxTemperature", Convert.ToDecimal(maxTemperature));
                    cmd.Parameters.AddWithValue("@Month", Convert.ToInt32(selectedMonth));

                    cmd.ExecuteNonQuery();
                }
            }
        }

        public DataTable SearchCities(string minTemperature, string maxTemperature, string selectedMonth)
        {
            DataTable dt = new DataTable();

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["WeatherDataDB"].ConnectionString))
            {
                conn.Open();

                string query = "exec FilterCitiesByTemperatureAndMonth @MinTemp, @MaxTemp, @Month";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@MinTemp", minTemperature);
                    cmd.Parameters.AddWithValue("@MaxTemp", maxTemperature);
                    cmd.Parameters.AddWithValue("@Month", selectedMonth);


                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {


                        da.Fill(dt);
                    }
                }
            }

            return dt;
        }




    }
}

