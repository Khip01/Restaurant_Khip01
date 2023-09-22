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
            MenuResponse menuResponse = new MenuResponse();

            using (HttpClient client = new HttpClient())
            {
                try
                {
                    HttpResponseMessage response = await client.GetAsync("http://localhost:8081/api/Menus");
                    if (response.IsSuccessStatusCode)
                    {
                        string json = await response.Content.ReadAsStringAsync();
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
            MenuWrapper menuWrap = new MenuWrapper();

            using (HttpClient client = new HttpClient()){
                try
                {
                    HttpResponseMessage response = await client.GetAsync("http://localhost:8081/api/Menu/"+id);
                    if (response.IsSuccessStatusCode)
                    {
                        string json = await response.Content.ReadAsStringAsync();
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

    }
}
