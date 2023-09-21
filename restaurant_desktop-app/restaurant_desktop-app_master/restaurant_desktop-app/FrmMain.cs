using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Runtime.InteropServices;
using System.Windows.Forms;
using System.Drawing.Drawing2D;

namespace restaurant_desktop_app
{
    public partial class FrmMain : Form
    {
        // Var Declaration
        Button currentButton;
        bool isClicked = false;
        int pnlAboutBorder = 15;

        // Style Form border and Panel
        [DllImport("Gdi32.dll", EntryPoint = "CreateRoundRectRgn")]
        private static extern IntPtr CreateRoundRectRgn
        (
            int nLeftRect,     // x-coordinate of upper-left corner
            int nTopRect,      // y-coordinate of upper-left corner
            int nRightRect,    // x-coordinate of lower-right corner
            int nBottomRect,   // y-coordinate of lower-right corner
            int nWidthEllipse, // height of ellipse
            int nHeightEllipse // width of ellipse
        );

        // Style Component Edge Rounded
        private void ApplyRoundedBorder(Control control, int cornerRadius)
        {
            Rectangle bounds = new Rectangle(Point.Empty, control.Size);
            using (GraphicsPath path = GetRoundedPath(bounds, cornerRadius))
            {
                control.Region = new Region(path);
            }
        }

        private GraphicsPath GetRoundedPath(Rectangle bounds, int cornerRadius)
        {
            GraphicsPath path = new GraphicsPath();
            int diameter = cornerRadius * 2;
            Rectangle arcRect = new Rectangle(bounds.Location, new Size(diameter, diameter));

            // Top-left corner
            path.AddArc(arcRect, 180, 90);

            // Top-right corner
            arcRect.X = bounds.Right - diameter;
            path.AddArc(arcRect, 270, 90);

            // Bottom-right corner
            arcRect.Y = bounds.Bottom - diameter;
            path.AddArc(arcRect, 0, 90);

            // Bottom-left corner
            arcRect.X = bounds.Left;
            path.AddArc(arcRect, 90, 90);

            path.CloseFigure();
            return path;
        }

        private void loadPage(object Form)
        {
            // MENGECEK APAKAH panel dalam keadaan kosong/tidak, jika tidak hapus form...
            if (this.pnlContent.Controls.Count > 0)
            {
                this.pnlContent.Controls.RemoveAt(0);
            }

            // MEMBUAT/MENAMBAHKAN PANEL YANG DIINPUT PADA PARAMETER FORM
            Form f = Form as Form;
            f.TopLevel = false;
            f.Dock = DockStyle.Fill;
            this.pnlContent.Controls.Add(f);
            this.pnlContent.Tag = f;
            f.Show();
        }

        // SETTING BUTTON YANG BERGANTI WARNA
        private void changeButtonColor(object sender, EventArgs e)
        {
            if (currentButton != null)
            {
                currentButton.BackColor = Color.Transparent; // Mengubah warna button
                currentButton.Parent.BackColor = Color.Transparent; // Mengubah warna panel
            }
            currentButton = (Button)sender;
            currentButton.BackColor = Color.FromArgb(175, 145, 140); // Mengubah warna button
            currentButton.Parent.BackColor = Color.FromArgb(175, 145, 140); // Mengubah warna panel

            // Update warna button menjadi transparan
            btnAllMenu.BackColor = Color.Transparent;
            btnCreate.BackColor = Color.Transparent;
            btnUpdate.BackColor = Color.Transparent;
            btnDelete.BackColor = Color.Transparent;
        }

        // Main 
        public FrmMain()
        {
            InitializeComponent();
            // Style FormBorder
            Region = System.Drawing.Region.FromHrgn(CreateRoundRectRgn(0, 0, Width, Height, 20, 20));

            // Style Panel
            pnlTitle.BorderStyle = BorderStyle.None;
            pnlTitle.Padding = new Padding(1);
            pnlTitle.Region = Region.FromHrgn(CreateRoundRectRgn(0, 0, pnlTitle.Width, pnlTitle.Height, 20, 20));

            // Style Panel Navbar
            ApplyRoundedBorder(pnlNavbar, 15);

            // Style Panel Content
            ApplyRoundedBorder(pnlContent, 15);

            // Load Page Start Awal
            loadPage(new PageAllMenu());
            currentButton = btnAllMenu;

            // Style Panel About
            ApplyRoundedBorder(pnlAbout, 25);
        }

        private void btnClose_MouseEnter(object sender, EventArgs e)
        {
            btnClose.BackColor = Color.Red;
        }

        private void btnClose_MouseLeave(object sender, EventArgs e)
        {
            btnClose.BackColor = Color.FromArgb(188, 44, 20);
        }

        private void btnMinimize_MouseEnter(object sender, EventArgs e)
        {
            btnMinimize.BackColor = Color.FromArgb(175, 124, 116);
        }

        private void btnMinimize_MouseLeave(object sender, EventArgs e)
        {
            btnMinimize.BackColor = Color.FromArgb(188, 44, 20);
        }

        private void btnAllMenu_Click(object sender, EventArgs e)
        {
            loadPage(new PageAllMenu());
            changeButtonColor(sender, e);
        }

        private void btnCreate_Click(object sender, EventArgs e)
        {
            loadPage(new PageCreate());
            changeButtonColor(sender, e);
        }

        private void btnUpdate_Click(object sender, EventArgs e)
        {
            loadPage(new PageUpdate());
            changeButtonColor(sender, e);
        }

        private void btnDelete_Click(object sender, EventArgs e)
        {
            loadPage(new PageDelete());
            changeButtonColor(sender, e);
        }

        private void btnClose_Click(object sender, EventArgs e)
        {
            DialogResult dialogResult = MessageBox.Show("Are you sure to exit?", "WARNING!", MessageBoxButtons.YesNo, MessageBoxIcon.Warning);
            if (dialogResult == DialogResult.Yes)
            {
                Application.ExitThread();
            }
        }

        private void btnMinimize_Click(object sender, EventArgs e)
        {
            this.WindowState = FormWindowState.Minimized;
        }

        private void btnAbout_Click(object sender, EventArgs e)
        {
            timerAbout.Start();
        }

        private void timerAbout_Tick(object sender, EventArgs e)
        {
            if (isClicked)
            {
                pnlAboutPop.Height -= 15;
                pnlAboutPop.Top += 15;
                this.pnlAboutBorder += 1;
                ApplyRoundedBorder(pnlAbout, pnlAboutBorder);

                if (pnlAboutPop.Height <= pnlAboutPop.MinimumSize.Height)
                {
                    timerAbout.Stop();
                    pnlAboutPop.Visible = false;
                    this.isClicked = false;
                    this.pnlAboutBorder = 25;
                    ApplyRoundedBorder(pnlAbout, this.pnlAboutBorder);
                }
            }
            else
            {
                pnlAboutPop.Visible = true;
                pnlAboutPop.Height += 15;
                pnlAboutPop.Top -= 15;
                this.pnlAboutBorder -= 1;
                ApplyRoundedBorder(pnlAbout, pnlAboutBorder);

                if (pnlAboutPop.Height >= pnlAboutPop.MaximumSize.Height)
                {
                    timerAbout.Stop();
                    this.isClicked = true;
                    this.pnlAboutBorder = 1;
                    ApplyRoundedBorder(pnlAbout, this.pnlAboutBorder);
                }
            }
        }
    }

}
