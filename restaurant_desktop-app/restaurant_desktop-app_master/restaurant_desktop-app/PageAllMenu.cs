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
        // Declare Menu Controller
        Controller controller = new Controller();

        String api_endpoint = Properties.Settings.Default.api_endpoint;

        public PageAllMenu()
        {
            InitializeComponent();
        }

        private async void PageAllMenu_Load(object sender, EventArgs e)
        {
            // Load Endpoint Label
            lblEndpoint.Text = api_endpoint + "Menus";
            lblEndpoint2.Text = api_endpoint + "Menu/:id";

            // Take the All Menu Object and use it in the datasource
            MenuResponse menuResponse = await controller.GetMenusDataAsync();
            dgvMenu.DataSource = menuResponse.AllMenu;

            if (dgvMenu.Rows.Count >= 1)
            {
                // Set the name column to ID
                dgvMenu.Columns["Id"].HeaderText = "ID";

                // Set the name column to MENU NAME
                dgvMenu.Columns["MenuName"].HeaderText = "MENU NAME";

                // Set the name column to Description
                dgvMenu.Columns["Description"].HeaderText = "DESCRIPTION";

                // Set the name column to PRICE
                dgvMenu.Columns["Price"].HeaderText = "PRICE";
            }
        }

        private async void dgvMenu_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            // Take ID from the selected row
            int row = dgvMenu.CurrentCell.RowIndex;

            int id = Convert.ToInt32(dgvMenu.Rows[row].Cells[0].Value);

            // Take the Menu Object and use it
            MenuWrapper menuWrap = await controller.GetMenuDataAsync(id);
            // If Object Contain No Data
            if (menuWrap.Menu.Id == 0)
            {
                return;
            }

            // Set the result
            lblId.Text = "ID                 : " + menuWrap.Menu.Id.ToString();
            lblMenuName.Text = "Menu Name: " + menuWrap.Menu.MenuName;
            lblDescription.Text = "Description : " + menuWrap.Menu.Description;
            lblPrice.Text = "Price: Rp." + menuWrap.Menu.Price.ToString();
        }
    }
}
