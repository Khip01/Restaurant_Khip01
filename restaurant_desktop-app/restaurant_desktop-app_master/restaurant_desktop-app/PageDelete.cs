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
    public partial class PageDelete : Form
    {
        // Declare only for blink Error purposes
        int blinkCount = 0;

        // Declare Id for reference id data that will be deleted
        int IDMenu = 0;

        // Declare Controller
        Controller controller = new Controller();

        public PageDelete()
        {
            InitializeComponent();
        }

        private async void PageDelete_Load(object sender, EventArgs e)
        {
            // Get all of the menu from API and show to DataGridView
            MenuResponse menu = await controller.GetMenusDataAsync();
            dgvMenu.DataSource = menu.AllMenu;

            // Change the header dgv text
            if (dgvMenu.Rows.Count >= 1)
            {
                dgvMenu.Columns["Id"].HeaderText = "ID";
                dgvMenu.Columns["MenuName"].HeaderText = "MENU NAME";
                dgvMenu.Columns["Description"].HeaderText = "DESCRIPTION";
                dgvMenu.Columns["Price"].HeaderText = "PRICE";
            }
        }

        private async void dgvMenu_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            // Declare Row Selected
            int row = dgvMenu.CurrentCell.RowIndex;

            this.IDMenu = Convert.ToInt32(dgvMenu.Rows[row].Cells["ID"].Value);

            // Set the value Menu data Information below the dgv
            MenuWrapper menuWrap = await controller.GetMenuDataAsync(IDMenu);
            // If Object Contain No Data
            if (menuWrap.Menu.Id == 0)
            {
                return;
            }

            // Set Value
            lblId.Text = "ID                 : " + menuWrap.Menu.Id.ToString();
            lblMenuName.Text = "Menu Name: " + menuWrap.Menu.MenuName;
            lblDescription.Text = "Description : " + menuWrap.Menu.Description;
            lblPrice.Text = "Price: Rp." + menuWrap.Menu.Price.ToString();
        }

        private async void btnDelete_Click(object sender, EventArgs e)
        {
            if (lblId.Text == "ID                 :")
            {
                btnDelete.Enabled = false;
                timerErrorField.Start();
                return;
            }

            // Validation
            DialogResult res = MessageBox.Show("Are you sure to delete this data?", "Warning", MessageBoxButtons.YesNo, MessageBoxIcon.Warning);
            if (res != DialogResult.Yes)
            {
                return;
            }

            // Delete Menu from Database trough API
            await controller.DeleteMenuDataAsync(IDMenu.ToString());

            // Refresh the dataGridView
            MenuResponse menuResponse = await controller.GetMenusDataAsync();
            dgvMenu.DataSource = menuResponse.AllMenu;

            // Clear label field
            lblId.Text = "ID                 :";
            lblMenuName.Text = "Menu Name:";
            lblDescription.Text = "Description :";
            lblPrice.Text = "Price:";

            // Reset IDMenu to 0
            IDMenu = 0;
        }

        private void timerErrorField_Tick(object sender, EventArgs e)
        {
            if ((blinkCount >= 200 && blinkCount <= 300) || (blinkCount >= 500 && blinkCount <= 600))
            {
                // Will Notice An Error and show Red Blink
                if (lblId.Text == "ID                 :")
                {
                    lblId.Text = "ID                 : This data must exist";
                    lblId.ForeColor = Color.DimGray;
                    lblId.BackColor = Color.LightCoral;
                }
            }
            else if (blinkCount > 700)
            {
                // End Of Blink
                blinkCount = 0;
                btnDelete.Enabled = true;
                timerErrorField.Stop();
            }
            else
            {
                // After Red Blink
                if (lblId.BackColor == Color.LightCoral)
                {
                    lblId.Text = "ID                 :";
                    lblId.ForeColor = Color.DimGray;
                    lblId.BackColor = SystemColors.ButtonHighlight;
                }
            }
            blinkCount += 100;
        }
    }
}
