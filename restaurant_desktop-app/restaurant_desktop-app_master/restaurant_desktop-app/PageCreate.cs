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
        // Declare TickBlink Purposes
        int blinkCount = 0;
        string tempPrice;

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

        private async void btnCreate_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(txtMenuName.Text) || string.IsNullOrEmpty(txtPrice.Text))
            {
                timerErrorField.Start();
                return;
            }
            if (!long.TryParse(txtPrice.Text, out long number) && !string.IsNullOrEmpty(txtPrice.Text))
            {
                tempPrice = txtPrice.Text;
                timerErrorNumber.Start();
                return;
            }

            // Create Struct Models for POST data
            Menu menuPost = new Menu();
            // Declare the value
            menuPost.MenuName = txtMenuName.Text;
            menuPost.Description = txtDesc.Text;
            menuPost.Price = Convert.ToInt32(txtPrice.Text);

            // Post to API
            await controller.PostMenuDataAsync(menuPost);

            // Refresh the Menu data
            MenuResponse menuResponse = await controller.GetMenusDataAsync();
            dgvMenu.DataSource = menuResponse.AllMenu;

            // Clear all field
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
            }
            else if (blinkCount > 700)
            {
                // End Of Blink
                blinkCount = 0;
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
