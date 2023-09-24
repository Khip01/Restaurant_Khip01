using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace restaurant_desktop_app
{
    class Controller
    {
        // Get All Menus
        public async Task<MenuResponse> GetMenusDataAsync()
        {
            // Create new object that will become a Struct to return value
            MenuResponse menuResponse = new MenuResponse();

            using (HttpClient client = new HttpClient())
            {
                try
                {
                    HttpResponseMessage response = await client.GetAsync("http://localhost:8081/api/Menus");
                    if (response.IsSuccessStatusCode)
                    {
                        // Read JSON from Response
                        string json = await response.Content.ReadAsStringAsync();
                        // Deserialize JSON to Object
                        menuResponse = JsonConvert.DeserializeObject<MenuResponse>(json);
                    }
                }
                catch (Exception er)
                {
                    // If Error
                    MessageBox.Show("Error: " + er.Message, "ERROR", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
            }

            return menuResponse;
        }

        // Get one of the menu
        public async Task<MenuWrapper> GetMenuDataAsync(int id)
        {
            // Create new object that will become a Struct to return value
            MenuWrapper menuWrap = new MenuWrapper();

            using (HttpClient client = new HttpClient()){
                try
                {
                    HttpResponseMessage response = await client.GetAsync("http://localhost:8081/api/Menu/"+id);
                    if (response.IsSuccessStatusCode)
                    {
                        // Read JSON from Response
                        string json = await response.Content.ReadAsStringAsync();
                        // Deserialize JSON to Object
                        menuWrap = JsonConvert.DeserializeObject<MenuWrapper>(json);
                    }
                }
                catch (Exception er)
                {
                    // If Error
                    MessageBox.Show("Error: " + er.Message, "ERROR", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
            }

            return menuWrap;
        }

        // POST New Menu to database 
        public async Task<bool> PostMenuDataAsync(Menu menu)
        {
            using (HttpClient client = new HttpClient())
            {
                try
                {
                    // Serialize Object to JSON
                    string jsonMenu = JsonConvert.SerializeObject(menu);
                    // Create Content that will be send to API Body
                    var content = new StringContent(jsonMenu, Encoding.UTF8, "application/json");

                    // Send to API 
                    HttpResponseMessage response = await client.PostAsync("http://localhost:8081/api/Menu", content);
                    if (!response.IsSuccessStatusCode)
                    {
                        MessageBox.Show("Failed to Create some data, check the misspelling textfield!", "ERROR", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        return false;
                    } else
                    {
                        MessageBox.Show("Data Added Successfully!", "SUCCESS", MessageBoxButtons.OK, MessageBoxIcon.Information);
                        return true;
                    }
                }
                catch (Exception err)
                {
                    MessageBox.Show("Error: "+err, "ERROR", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    return false;
                }
            }
        }

        // PUT / UPDATE Menu from Database
        public async Task<bool> PutMenuDataAsync(string id, Menu menu)
        {
            using (HttpClient client = new HttpClient())
            {
                try
                {
                    // Create JSON from Param Menu Object 
                    string jsonMenu = JsonConvert.SerializeObject(menu);
                    // Create content for send to URL API
                    var content = new StringContent(jsonMenu, Encoding.UTF8, "application/json");

                    // Try to send Content to Database through API 
                    HttpResponseMessage response = await client.PutAsync("http://localhost:8081/api/Menu/"+id, content);
                    if (!response.IsSuccessStatusCode)
                    {
                        MessageBox.Show("Error: Can't Update the Data. \nThere is something wrong with your input", "ERROR", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        return false;
                    } 
                    else
                    {
                        MessageBox.Show("Data Updated Successfully!", "SUCCESS", MessageBoxButtons.OK, MessageBoxIcon.Information);
                        return true;
                    }
                }
                catch (Exception err)
                {
                    MessageBox.Show("Error: "+ err, "UNEXPECTED ERROR", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    return false;
                }

            }
        }

        // DELETE Menu from database
        public async Task<bool> DeleteMenuDataAsync(string id)
        {
            using (HttpClient client = new HttpClient())
            {
                try
                {
                    // Send to Delete Request to API 
                    HttpResponseMessage response = await client.DeleteAsync("http://localhost:8081/api/Menu/"+id);
                    if (!response.IsSuccessStatusCode)
                    {
                        MessageBox.Show("Error: Failed to Delete data.\nThere is something wrong with the requested data.", "ERROR", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        return false;
                    } else
                    {
                        MessageBox.Show("Data Deleted Successfully!", "SUCCESS", MessageBoxButtons.OK, MessageBoxIcon.Information);
                        return true;
                    }
                }
                catch (Exception err)
                {
                    MessageBox.Show("Error: "+ err, "UNEXPECTED ERROR", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    return false;
                }
            }
        }

    }
}
