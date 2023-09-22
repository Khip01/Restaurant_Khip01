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
    public partial class PageCreate : Form
    {
        // Declare Contoller 
        Controller controller = new Controller();

        public PageCreate()
        {
            InitializeComponent();
        }

        private async void PageCreate_Load(object sender, EventArgs e)
        {
            // Take All Menu Object from API and then display to dataGridView
            MenuResponse menuResponse = await controller.GetMenusDataAsync();
            dgvMenu.DataSource = menuResponse.AllMenu;

            if (dgvMenu.Rows.Count >= 1)
            {
                // Set all of the Header dataGridView
                dgvMenu.Columns["Id"].HeaderText = "ID";
                dgvMenu.Columns["MenuName"].HeaderText = "MENU NAME";
                dgvMenu.Columns["Description"].HeaderText = "DESCRIPTION";
                dgvMenu.Columns["Price"].HeaderText = "PRICE";
            }
        }

        private void btnClear_Click(object sender, EventArgs e)
        {
            txtId.Text = "AUTO INCREMENT";
            txtMenuName.Clear();
            txtDesc.Clear();
            txtPrice.Clear();
        }
    }
}
