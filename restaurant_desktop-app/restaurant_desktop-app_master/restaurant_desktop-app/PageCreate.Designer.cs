
namespace restaurant_desktop_app
{
    partial class PageCreate
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            this.lblTitle = new System.Windows.Forms.Label();
            this.pnlDgv = new System.Windows.Forms.Panel();
            this.label1 = new System.Windows.Forms.Label();
            this.lblEndpoint = new System.Windows.Forms.Label();
            this.dgvMenu = new System.Windows.Forms.DataGridView();
            this.panel1 = new System.Windows.Forms.Panel();
            this.txtPrice = new System.Windows.Forms.TextBox();
            this.txtDesc = new System.Windows.Forms.TextBox();
            this.txtMenuName = new System.Windows.Forms.TextBox();
            this.txtId = new System.Windows.Forms.TextBox();
            this.lblDescription = new System.Windows.Forms.Label();
            this.lblPrice = new System.Windows.Forms.Label();
            this.lblMenuName = new System.Windows.Forms.Label();
            this.lblId = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.lblEndpoint2 = new System.Windows.Forms.Label();
            this.btnCreate = new System.Windows.Forms.Button();
            this.btnClear = new System.Windows.Forms.Button();
            this.timerErrorField = new System.Windows.Forms.Timer(this.components);
            this.timerErrorNumber = new System.Windows.Forms.Timer(this.components);
            this.pnlDgv.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgvMenu)).BeginInit();
            this.panel1.SuspendLayout();
            this.SuspendLayout();
            // 
            // lblTitle
            // 
            this.lblTitle.AutoSize = true;
            this.lblTitle.Font = new System.Drawing.Font("Segoe UI Semibold", 18F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point);
            this.lblTitle.Location = new System.Drawing.Point(29, 19);
            this.lblTitle.Margin = new System.Windows.Forms.Padding(20, 10, 10, 10);
            this.lblTitle.Name = "lblTitle";
            this.lblTitle.Size = new System.Drawing.Size(195, 41);
            this.lblTitle.TabIndex = 5;
            this.lblTitle.Text = "Create Menu";
            // 
            // pnlDgv
            // 
            this.pnlDgv.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
            this.pnlDgv.Controls.Add(this.label1);
            this.pnlDgv.Controls.Add(this.lblEndpoint);
            this.pnlDgv.Controls.Add(this.dgvMenu);
            this.pnlDgv.Location = new System.Drawing.Point(19, 80);
            this.pnlDgv.Margin = new System.Windows.Forms.Padding(10);
            this.pnlDgv.Name = "pnlDgv";
            this.pnlDgv.Size = new System.Drawing.Size(816, 277);
            this.pnlDgv.TabIndex = 11;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Segoe UI", 13.8F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point);
            this.label1.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(0)))), ((int)(((byte)(192)))), ((int)(((byte)(0)))));
            this.label1.Location = new System.Drawing.Point(20, 10);
            this.label1.Margin = new System.Windows.Forms.Padding(20, 10, 0, 10);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(61, 31);
            this.label1.TabIndex = 10;
            this.label1.Text = "GET:";
            // 
            // lblEndpoint
            // 
            this.lblEndpoint.AutoSize = true;
            this.lblEndpoint.Font = new System.Drawing.Font("Segoe UI", 13.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.lblEndpoint.Location = new System.Drawing.Point(81, 10);
            this.lblEndpoint.Margin = new System.Windows.Forms.Padding(0, 10, 10, 10);
            this.lblEndpoint.Name = "lblEndpoint";
            this.lblEndpoint.Size = new System.Drawing.Size(278, 31);
            this.lblEndpoint.TabIndex = 9;
            this.lblEndpoint.Text = "localhost:8081/api/Menus";
            // 
            // dgvMenu
            // 
            this.dgvMenu.AllowUserToAddRows = false;
            this.dgvMenu.AllowUserToDeleteRows = false;
            this.dgvMenu.AutoSizeColumnsMode = System.Windows.Forms.DataGridViewAutoSizeColumnsMode.Fill;
            this.dgvMenu.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvMenu.Location = new System.Drawing.Point(0, 54);
            this.dgvMenu.Name = "dgvMenu";
            this.dgvMenu.ReadOnly = true;
            this.dgvMenu.RowHeadersWidth = 51;
            this.dgvMenu.RowTemplate.Height = 50;
            this.dgvMenu.Size = new System.Drawing.Size(809, 221);
            this.dgvMenu.TabIndex = 7;
            // 
            // panel1
            // 
            this.panel1.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
            this.panel1.Controls.Add(this.txtPrice);
            this.panel1.Controls.Add(this.txtDesc);
            this.panel1.Controls.Add(this.txtMenuName);
            this.panel1.Controls.Add(this.txtId);
            this.panel1.Controls.Add(this.lblDescription);
            this.panel1.Controls.Add(this.lblPrice);
            this.panel1.Controls.Add(this.lblMenuName);
            this.panel1.Controls.Add(this.lblId);
            this.panel1.Controls.Add(this.label3);
            this.panel1.Controls.Add(this.lblEndpoint2);
            this.panel1.Location = new System.Drawing.Point(19, 377);
            this.panel1.Margin = new System.Windows.Forms.Padding(10);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(816, 214);
            this.panel1.TabIndex = 12;
            // 
            // txtPrice
            // 
            this.txtPrice.Font = new System.Drawing.Font("Segoe UI", 13.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.txtPrice.Location = new System.Drawing.Point(576, 58);
            this.txtPrice.Name = "txtPrice";
            this.txtPrice.Size = new System.Drawing.Size(216, 38);
            this.txtPrice.TabIndex = 20;
            // 
            // txtDesc
            // 
            this.txtDesc.Font = new System.Drawing.Font("Segoe UI", 13.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.txtDesc.Location = new System.Drawing.Point(182, 146);
            this.txtDesc.Name = "txtDesc";
            this.txtDesc.Size = new System.Drawing.Size(304, 38);
            this.txtDesc.TabIndex = 19;
            // 
            // txtMenuName
            // 
            this.txtMenuName.BackColor = System.Drawing.SystemColors.Window;
            this.txtMenuName.Font = new System.Drawing.Font("Segoe UI", 13.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.txtMenuName.Location = new System.Drawing.Point(182, 102);
            this.txtMenuName.Name = "txtMenuName";
            this.txtMenuName.Size = new System.Drawing.Size(304, 38);
            this.txtMenuName.TabIndex = 18;
            // 
            // txtId
            // 
            this.txtId.Enabled = false;
            this.txtId.Font = new System.Drawing.Font("Segoe UI", 13.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.txtId.ForeColor = System.Drawing.Color.DimGray;
            this.txtId.Location = new System.Drawing.Point(182, 58);
            this.txtId.Name = "txtId";
            this.txtId.Size = new System.Drawing.Size(224, 38);
            this.txtId.TabIndex = 17;
            this.txtId.Text = "AUTO INCREMENT";
            this.txtId.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
            // 
            // lblDescription
            // 
            this.lblDescription.AutoSize = true;
            this.lblDescription.Font = new System.Drawing.Font("Segoe UI", 13.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.lblDescription.ForeColor = System.Drawing.Color.DimGray;
            this.lblDescription.Location = new System.Drawing.Point(20, 149);
            this.lblDescription.Margin = new System.Windows.Forms.Padding(0, 5, 10, 5);
            this.lblDescription.Name = "lblDescription";
            this.lblDescription.Size = new System.Drawing.Size(136, 31);
            this.lblDescription.TabIndex = 16;
            this.lblDescription.Text = "Description:";
            // 
            // lblPrice
            // 
            this.lblPrice.AutoSize = true;
            this.lblPrice.Font = new System.Drawing.Font("Segoe UI", 13.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.lblPrice.ForeColor = System.Drawing.Color.DimGray;
            this.lblPrice.Location = new System.Drawing.Point(494, 61);
            this.lblPrice.Margin = new System.Windows.Forms.Padding(0, 5, 10, 5);
            this.lblPrice.Name = "lblPrice";
            this.lblPrice.Size = new System.Drawing.Size(69, 31);
            this.lblPrice.TabIndex = 15;
            this.lblPrice.Text = "Price:";
            // 
            // lblMenuName
            // 
            this.lblMenuName.AutoSize = true;
            this.lblMenuName.Font = new System.Drawing.Font("Segoe UI", 13.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.lblMenuName.ForeColor = System.Drawing.Color.DimGray;
            this.lblMenuName.Location = new System.Drawing.Point(20, 105);
            this.lblMenuName.Margin = new System.Windows.Forms.Padding(0, 5, 10, 5);
            this.lblMenuName.Name = "lblMenuName";
            this.lblMenuName.Size = new System.Drawing.Size(151, 31);
            this.lblMenuName.TabIndex = 14;
            this.lblMenuName.Text = "Menu Name: ";
            // 
            // lblId
            // 
            this.lblId.AutoSize = true;
            this.lblId.Font = new System.Drawing.Font("Segoe UI", 13.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.lblId.ForeColor = System.Drawing.Color.DimGray;
            this.lblId.Location = new System.Drawing.Point(20, 61);
            this.lblId.Margin = new System.Windows.Forms.Padding(0, 5, 10, 5);
            this.lblId.Name = "lblId";
            this.lblId.Size = new System.Drawing.Size(41, 31);
            this.lblId.TabIndex = 13;
            this.lblId.Text = "ID:";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Segoe UI", 13.8F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point);
            this.label3.ForeColor = System.Drawing.Color.Gold;
            this.label3.Location = new System.Drawing.Point(20, 10);
            this.label3.Margin = new System.Windows.Forms.Padding(20, 10, 0, 10);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(77, 31);
            this.label3.TabIndex = 12;
            this.label3.Text = "POST:";
            // 
            // lblEndpoint2
            // 
            this.lblEndpoint2.AutoSize = true;
            this.lblEndpoint2.Font = new System.Drawing.Font("Segoe UI", 13.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.lblEndpoint2.Location = new System.Drawing.Point(97, 10);
            this.lblEndpoint2.Margin = new System.Windows.Forms.Padding(0, 10, 10, 10);
            this.lblEndpoint2.Name = "lblEndpoint2";
            this.lblEndpoint2.Size = new System.Drawing.Size(450, 31);
            this.lblEndpoint2.TabIndex = 11;
            this.lblEndpoint2.Text = "localhost:8081/api/Menu (with body JSON)";
            // 
            // btnCreate
            // 
            this.btnCreate.BackColor = System.Drawing.Color.Gold;
            this.btnCreate.FlatAppearance.BorderSize = 0;
            this.btnCreate.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnCreate.Font = new System.Drawing.Font("Segoe UI Semibold", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point);
            this.btnCreate.Location = new System.Drawing.Point(338, 611);
            this.btnCreate.Margin = new System.Windows.Forms.Padding(10);
            this.btnCreate.Name = "btnCreate";
            this.btnCreate.Size = new System.Drawing.Size(169, 46);
            this.btnCreate.TabIndex = 13;
            this.btnCreate.Text = "Create";
            this.btnCreate.UseVisualStyleBackColor = false;
            this.btnCreate.Click += new System.EventHandler(this.btnCreate_Click);
            // 
            // btnClear
            // 
            this.btnClear.BackColor = System.Drawing.Color.IndianRed;
            this.btnClear.FlatAppearance.BorderSize = 0;
            this.btnClear.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnClear.Font = new System.Drawing.Font("Segoe UI Semibold", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point);
            this.btnClear.ForeColor = System.Drawing.SystemColors.Control;
            this.btnClear.Location = new System.Drawing.Point(666, 611);
            this.btnClear.Margin = new System.Windows.Forms.Padding(10);
            this.btnClear.Name = "btnClear";
            this.btnClear.Size = new System.Drawing.Size(169, 46);
            this.btnClear.TabIndex = 14;
            this.btnClear.Text = "Clear All Field";
            this.btnClear.UseVisualStyleBackColor = false;
            this.btnClear.Click += new System.EventHandler(this.btnClear_Click);
            // 
            // timerErrorField
            // 
            this.timerErrorField.Tick += new System.EventHandler(this.timerErrorField_Tick);
            // 
            // timerErrorNumber
            // 
            this.timerErrorNumber.Tick += new System.EventHandler(this.timerErrorNumber_Tick);
            // 
            // PageCreate
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 20F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.SystemColors.ButtonHighlight;
            this.ClientSize = new System.Drawing.Size(854, 676);
            this.Controls.Add(this.btnClear);
            this.Controls.Add(this.btnCreate);
            this.Controls.Add(this.panel1);
            this.Controls.Add(this.pnlDgv);
            this.Controls.Add(this.lblTitle);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.None;
            this.Name = "PageCreate";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "PageCreate";
            this.Load += new System.EventHandler(this.PageCreate_Load);
            this.pnlDgv.ResumeLayout(false);
            this.pnlDgv.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgvMenu)).EndInit();
            this.panel1.ResumeLayout(false);
            this.panel1.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label lblTitle;
        private System.Windows.Forms.Panel pnlDgv;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label lblEndpoint;
        private System.Windows.Forms.DataGridView dgvMenu;
        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.Label lblDescription;
        private System.Windows.Forms.Label lblPrice;
        private System.Windows.Forms.Label lblMenuName;
        private System.Windows.Forms.Label lblId;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label lblEndpoint2;
        private System.Windows.Forms.TextBox txtId;
        private System.Windows.Forms.TextBox txtDesc;
        private System.Windows.Forms.TextBox txtMenuName;
        private System.Windows.Forms.TextBox txtPrice;
        private System.Windows.Forms.Button btnCreate;
        private System.Windows.Forms.Button btnClear;
        private System.Windows.Forms.Timer timerErrorField;
        private System.Windows.Forms.Timer timerErrorNumber;
    }
}