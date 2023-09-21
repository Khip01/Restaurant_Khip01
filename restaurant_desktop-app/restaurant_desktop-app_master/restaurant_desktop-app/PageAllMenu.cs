using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Newtonsoft.Json;


namespace restaurant_desktop_app
{
    public partial class PageAllMenu : Form
    {
        private async Task<MenuResponse> GetMenuDataAsync()
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
                catch (Exception ex)
                {
                    // Tangani kesalahan jika terjadi
                    MessageBox.Show("Error: " + ex.Message);
                }
            }

            return menuResponse;
        }

        public PageAllMenu()
        {
            InitializeComponent();
        }

        private async void PageAllMenu_Load(object sender, EventArgs e)
        {
            // Mengambil Object All Menu dan menggunakannya di datasource
            MenuResponse menuResponse = await GetMenuDataAsync();
            dgvMenu.DataSource = menuResponse.AllMenu;

            // Mengatur nama kolom untuk ID
            dgvMenu.Columns["Id"].HeaderText = "ID";

            // Mengatur nama kolom untuk Name (MENU NAME)
            dgvMenu.Columns["MenuName"].HeaderText = "MENU NAME";

            // Mengatur nama kolom untuk Description
            dgvMenu.Columns["Description"].HeaderText = "DESCRIPTION";

            // Mengatur nama kolom untuk Price
            dgvMenu.Columns["Price"].HeaderText = "PRICE";

        }
    }

    // Menu Class inside the All Menu Array
    public class MenuResponse
    {
        [JsonProperty ("All Menu")]
        public List<Menu> AllMenu { get; set; }
    }

    // Class JSON as Menu
    public class Menu
    {
        [JsonProperty ("id")]
        public int Id { get; set; }

        [JsonProperty ("menu_name")]
        public string MenuName { get; set; }

        [JsonProperty ("description")]
        public string Description { get; set; }

        [JsonProperty ("price")]
        public int Price { get; set; }
    }
}
