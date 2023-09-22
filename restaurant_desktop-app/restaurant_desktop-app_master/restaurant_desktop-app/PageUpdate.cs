using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace restaurant_desktop_app
{
    public partial class PageUpdate : Form
    {
        Controller controller = new Controller();

        public PageUpdate()
        {
            InitializeComponent();
        }

        private async void dgvMenu_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            // Get the ID from dataGridView
            int row = dgvMenu.CurrentCell.RowIndex;
            int Id = Convert.ToInt32(dgvMenu.Rows[row].Cells[0].Value);

            // Get Object Menu from API 
            MenuWrapper menuWrap = await controller.GetMenuDataAsync(Id);

            // Set the textFields
            txtId.Text = menuWrap.Menu.Id.ToString();
            txtMenuName.Text = menuWrap.Menu.MenuName;
            txtDesc.Text = menuWrap.Menu.Description;
            txtPrice.Text = menuWrap.Menu.Price.ToString();
        }

        private async void PageUpdate_Load(object sender, EventArgs e)
        {
            // Take All Menu from API 
            MenuResponse menuResponse = await controller.GetMenusDataAsync();
            dgvMenu.DataSource = menuResponse.AllMenu;

            if (dgvMenu.Rows.Count >= 1)
            {
                // Set All Headers Name
                dgvMenu.Columns["Id"].HeaderText = "ID";
                dgvMenu.Columns["MenuName"].HeaderText = "MENU NAME";
                dgvMenu.Columns["Description"].HeaderText = "DESCRIPTION";
                dgvMenu.Columns["Price"].HeaderText = "PRICE";
            }
        }
    }
}
