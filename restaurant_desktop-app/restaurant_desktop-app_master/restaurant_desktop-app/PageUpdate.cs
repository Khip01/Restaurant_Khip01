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
        // Declare Menu Object temp for validation changes
        Menu tempMenu = new Menu();

        // Declare TickBlink Purposes
        int blinkCount = 0;
        string tempPrice;

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
            // If Object Contain No Data
            if (menuWrap.Menu.Id == 0)
            {
                return;
            }

            // Set the textFields
            txtId.Text = menuWrap.Menu.Id.ToString();
            txtMenuName.Text = menuWrap.Menu.MenuName;
            txtDesc.Text = menuWrap.Menu.Description;
            txtPrice.Text = menuWrap.Menu.Price.ToString();

            // Store temp data for validation
            tempMenu.MenuName = menuWrap.Menu.MenuName;
            tempMenu.Description = menuWrap.Menu.Description;
            tempMenu.Price = menuWrap.Menu.Price;
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

        private async void btnUpdate_Click(object sender, EventArgs e)
        {
            // Validation Error
            if (string.IsNullOrEmpty(txtMenuName.Text) || string.IsNullOrEmpty(txtPrice.Text) || string.IsNullOrEmpty(txtId.Text))
            {
                btnUpdate.Enabled = false;
                timerErrorField.Start();
                return;
            }
            if (!string.IsNullOrEmpty(txtPrice.Text) && !long.TryParse(txtPrice.Text, out long number))
            {
                btnUpdate.Enabled = false;
                tempPrice = txtPrice.Text;
                timerErrorNumber.Start();
                return;
            }


            // Create Object that will be place to store the Menu
            Menu menu = new Menu();
            // Declare the value of the object 
            menu.MenuName = txtMenuName.Text;
            menu.Description = txtDesc.Text;
            menu.Price = Convert.ToInt32(txtPrice.Text);

            // Store ID
            string id = txtId.Text;


            // Checking, if there are any changes to the input
            if (menu.Id == tempMenu.Id && menu.MenuName == tempMenu.MenuName && menu.Description == tempMenu.Description && menu.Price == tempMenu.Price)
            {
                MessageBox.Show("Nothing changed", "INFORMATION", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            }


            // Send To Put Method to process the PUT API
            await controller.PutMenuDataAsync(id, menu);

            // After PUT/Updating the menu, refresh the dataGridView and clear the textField andclear the textField and clear the textField
            // Refresh dgv
            MenuResponse menuResponse = await controller.GetMenusDataAsync();
            dgvMenu.DataSource = menuResponse.AllMenu;

            // Clear TextField
            txtId.Clear();
            txtMenuName.Clear();
            txtDesc.Clear();
            txtPrice.Clear();
        }

        private void timerErrorField_Tick(object sender, EventArgs e)
        {
            if ((blinkCount >= 200 && blinkCount <= 300) || (blinkCount >= 500 && blinkCount <= 600))
            {
                // Will Notice An Error and show Red Blink
                if (string.IsNullOrEmpty(txtMenuName.Text))
                {
                    txtMenuName.Text = "required";
                    txtMenuName.ForeColor = Color.DimGray;
                    txtMenuName.TextAlign = HorizontalAlignment.Center;
                    txtMenuName.BackColor = Color.LightCoral;
                }
                if (string.IsNullOrEmpty(txtPrice.Text))
                {
                    txtPrice.Text = "required";
                    txtPrice.ForeColor = Color.DimGray;
                    txtPrice.TextAlign = HorizontalAlignment.Center;
                    txtPrice.BackColor = Color.LightCoral;
                }
                if (string.IsNullOrEmpty(txtId.Text))
                {
                    txtId.Text = "select the data";
                    txtId.ForeColor = Color.DimGray;
                    txtId.BackColor = Color.LightCoral;
                }
            }
            else if (blinkCount > 700)
            {
                // End Of Blink
                blinkCount = 0;
                btnUpdate.Enabled = true;
                timerErrorField.Stop();
            }
            else
            {
                // After Red Blink
                if (txtMenuName.BackColor == Color.LightCoral)
                {
                    txtMenuName.Clear();
                    txtMenuName.ForeColor = SystemColors.WindowText;
                    txtMenuName.TextAlign = HorizontalAlignment.Left;
                    txtMenuName.BackColor = SystemColors.Window;
                }
                if (txtPrice.BackColor == Color.LightCoral)
                {
                    txtPrice.Clear();
                    txtPrice.ForeColor = SystemColors.WindowText;
                    txtPrice.TextAlign = HorizontalAlignment.Left;
                    txtPrice.BackColor = SystemColors.Window;
                }
                if (txtId.BackColor == Color.LightCoral)
                {
                    txtId.Clear();
                    txtId.ForeColor = SystemColors.WindowText;
                    txtId.BackColor = SystemColors.Window;
                }
            }
            blinkCount += 100;
        }

        private void timerErrorNumber_Tick(object sender, EventArgs e)
        {
            if ((blinkCount >= 200 && blinkCount <= 300) || (blinkCount >= 500 && blinkCount <= 600))
            {
                // Will Notice An Error and show Red Blink
                if (!long.TryParse(txtPrice.Text, out long number) && !string.IsNullOrEmpty(txtPrice.Text))
                {
                    // Use temporaryly for store the price textfield
                    txtPrice.Text = "numbers only";
                    txtPrice.ForeColor = Color.DimGray;
                    txtPrice.TextAlign = HorizontalAlignment.Center;
                    txtPrice.BackColor = Color.LightCoral;
                }
            }
            else if (blinkCount > 700)
            {
                // End Of Blink
                blinkCount = 0;
                btnUpdate.Enabled = true;
                timerErrorNumber.Stop();
            }
            else
            {
                // After Red Blink
                if (txtPrice.Text == "numbers only" && txtPrice.BackColor == Color.LightCoral)
                {
                    txtPrice.Text = tempPrice;
                    txtPrice.ForeColor = SystemColors.WindowText;
                    txtPrice.TextAlign = HorizontalAlignment.Left;
                    txtPrice.BackColor = SystemColors.Window;
                }
            }
            blinkCount += 100;
        }
    }
}
