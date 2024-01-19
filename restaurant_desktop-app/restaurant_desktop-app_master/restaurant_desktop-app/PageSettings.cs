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
    public partial class PageSettings : Form
    {
        // Declare TickBlink Purposes
        int blinkCount = 0;

        // Declare Contoller 
        Controller controller = new Controller();

        // Declare API Endpoint from Setting Properties
        String api_endpoint = Properties.Settings.Default.api_endpoint;

        public PageSettings()
        {
            InitializeComponent();
        }

        private void PageSettings_Load(object sender, EventArgs e)
        {
            lblCurrentEndpoint.Text = "*your current endpoint: "+api_endpoint;
        }

        private async void btnSave_Click(object sender, EventArgs e)
        {
            // Validation
            if (string.IsNullOrEmpty(txtEndpoint.Text))
            {
                btnCheckConnection.Enabled = false;
                btnSave.Enabled = false;
                timerErrorField.Start();
                return;
            }

            // Check API Connection 
            try
            {
                bool result = await controller.checkApiConnection(txtEndpoint.Text);
                if (!result)
                {
                    MessageBox.Show("Error: Can't Connect to API. \nThere is something wrong with your endpoint input\n\nMaybe try with format:\nxxxx://xxx.xxx.x.x:xxxx/api/", "ERROR", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    return;
                }
            }
            catch (Exception er)
            {
                MessageBox.Show("Error: " + er.Message, "ERROR", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            // Save Endpoint
            Properties.Settings.Default["api_endpoint"] = txtEndpoint.Text;
            Properties.Settings.Default.Save();

            // Refresh Label
            lblCurrentEndpoint.Text = "*your current endpoint: " + Properties.Settings.Default.api_endpoint;

            // Message Success
            MessageBox.Show("API Endpoint Saved and changed successfully!", "SUCCESS", MessageBoxButtons.OK, MessageBoxIcon.Information);
            txtEndpoint.Clear();
            return;
        }

        private async void btnCheckConnection_Click(object sender, EventArgs e)
        {
            // Validation
            if (string.IsNullOrEmpty(txtEndpoint.Text))
            {
                btnCheckConnection.Enabled = false;
                btnSave.Enabled = false;
                timerErrorField.Start();
                return;
            }

            // Check API Connection 
            try
            {
                bool result = await controller.checkApiConnection(txtEndpoint.Text);

                if (result)
                {
                    MessageBox.Show("Successfully connected with API!\nThe API endpoint is ready to save.", "SUCCESS", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    return;
                }
                else
                {
                    MessageBox.Show("Error: Can't Connect to API. \nThere is something wrong with your endpoint input\n\nMaybe try with format:\nxxxx://xxx.xxx.x.x:xxxx/api/", "ERROR", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    return;
                }
            } 
            catch (Exception er)
            {
                MessageBox.Show("Error: " + er.Message, "ERROR", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }
        }

        private void timerErrorField_Tick(object sender, EventArgs e)
        {
            if ((blinkCount >= 200 && blinkCount <= 300) || (blinkCount >= 500 && blinkCount <= 600))
            {
                // Will Notice An Error and show Red Blink
                if (string.IsNullOrEmpty(txtEndpoint.Text))
                {
                    txtEndpoint.Enabled = false;
                    txtEndpoint.Text = "required";
                    txtEndpoint.ForeColor = Color.DimGray;
                    txtEndpoint.TextAlign = HorizontalAlignment.Center;
                    txtEndpoint.BackColor = Color.LightCoral;
                }
            }
            else if (blinkCount > 700)
            {
                // End Of Blink
                blinkCount = 0;
                txtEndpoint.Enabled = true;
                btnCheckConnection.Enabled = true;
                btnSave.Enabled = true;
                timerErrorField.Stop();
            }
            else
            {
                // After Red Blink
                if (txtEndpoint.BackColor == Color.LightCoral)
                {
                    txtEndpoint.Clear();
                    txtEndpoint.ForeColor = SystemColors.WindowText;
                    txtEndpoint.TextAlign = HorizontalAlignment.Left;
                    txtEndpoint.BackColor = SystemColors.Window;
                }
            }
            blinkCount += 100;
        }

    }
}
