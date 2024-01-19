
namespace restaurant_desktop_app
{
    partial class PageSettings
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
            this.label4 = new System.Windows.Forms.Label();
            this.lblCurrentEndpoint = new System.Windows.Forms.Label();
            this.txtEndpoint = new System.Windows.Forms.TextBox();
            this.btnCheckConnection = new System.Windows.Forms.Button();
            this.btnSave = new System.Windows.Forms.Button();
            this.timerErrorField = new System.Windows.Forms.Timer(this.components);
            this.SuspendLayout();
            // 
            // lblTitle
            // 
            this.lblTitle.AutoSize = true;
            this.lblTitle.Font = new System.Drawing.Font("Segoe UI Semibold", 18F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point);
            this.lblTitle.Location = new System.Drawing.Point(29, 19);
            this.lblTitle.Margin = new System.Windows.Forms.Padding(20, 10, 10, 10);
            this.lblTitle.Name = "lblTitle";
            this.lblTitle.Size = new System.Drawing.Size(129, 41);
            this.lblTitle.TabIndex = 7;
            this.lblTitle.Text = "Settings";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Font = new System.Drawing.Font("Segoe UI", 13.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.label4.Location = new System.Drawing.Point(29, 91);
            this.label4.Margin = new System.Windows.Forms.Padding(0, 10, 10, 10);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(147, 31);
            this.label4.TabIndex = 12;
            this.label4.Text = "API Endpoint";
            // 
            // lblCurrentEndpoint
            // 
            this.lblCurrentEndpoint.AutoSize = true;
            this.lblCurrentEndpoint.Font = new System.Drawing.Font("Segoe UI", 10.2F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.lblCurrentEndpoint.ForeColor = System.Drawing.SystemColors.ControlDarkDark;
            this.lblCurrentEndpoint.Location = new System.Drawing.Point(29, 126);
            this.lblCurrentEndpoint.Margin = new System.Windows.Forms.Padding(0, 10, 10, 10);
            this.lblCurrentEndpoint.Name = "lblCurrentEndpoint";
            this.lblCurrentEndpoint.Size = new System.Drawing.Size(390, 23);
            this.lblCurrentEndpoint.TabIndex = 13;
            this.lblCurrentEndpoint.Text = "*your current endpoint: xxxx:xxxx/xxxx.xxx.x.x/api/";
            // 
            // txtEndpoint
            // 
            this.txtEndpoint.BackColor = System.Drawing.SystemColors.Window;
            this.txtEndpoint.Font = new System.Drawing.Font("Segoe UI", 13.8F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.txtEndpoint.Location = new System.Drawing.Point(29, 162);
            this.txtEndpoint.Name = "txtEndpoint";
            this.txtEndpoint.Size = new System.Drawing.Size(800, 38);
            this.txtEndpoint.TabIndex = 19;
            // 
            // btnCheckConnection
            // 
            this.btnCheckConnection.BackColor = System.Drawing.Color.Gray;
            this.btnCheckConnection.FlatAppearance.BorderSize = 0;
            this.btnCheckConnection.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnCheckConnection.Font = new System.Drawing.Font("Segoe UI Semibold", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point);
            this.btnCheckConnection.ForeColor = System.Drawing.SystemColors.ControlText;
            this.btnCheckConnection.Location = new System.Drawing.Point(29, 213);
            this.btnCheckConnection.Margin = new System.Windows.Forms.Padding(10);
            this.btnCheckConnection.Name = "btnCheckConnection";
            this.btnCheckConnection.Size = new System.Drawing.Size(232, 46);
            this.btnCheckConnection.TabIndex = 21;
            this.btnCheckConnection.Text = "Check Connection";
            this.btnCheckConnection.UseVisualStyleBackColor = false;
            this.btnCheckConnection.Click += new System.EventHandler(this.btnCheckConnection_Click);
            // 
            // btnSave
            // 
            this.btnSave.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(0)))), ((int)(((byte)(192)))), ((int)(((byte)(0)))));
            this.btnSave.FlatAppearance.BorderSize = 0;
            this.btnSave.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnSave.Font = new System.Drawing.Font("Segoe UI Semibold", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point);
            this.btnSave.ForeColor = System.Drawing.SystemColors.ControlText;
            this.btnSave.Location = new System.Drawing.Point(-3, 609);
            this.btnSave.Margin = new System.Windows.Forms.Padding(10);
            this.btnSave.Name = "btnSave";
            this.btnSave.Size = new System.Drawing.Size(859, 69);
            this.btnSave.TabIndex = 22;
            this.btnSave.Text = "SAVE";
            this.btnSave.UseVisualStyleBackColor = false;
            this.btnSave.Click += new System.EventHandler(this.btnSave_Click);
            // 
            // timerErrorField
            // 
            this.timerErrorField.Tick += new System.EventHandler(this.timerErrorField_Tick);
            // 
            // PageSettings
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 20F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.SystemColors.ButtonHighlight;
            this.ClientSize = new System.Drawing.Size(854, 676);
            this.Controls.Add(this.btnSave);
            this.Controls.Add(this.btnCheckConnection);
            this.Controls.Add(this.txtEndpoint);
            this.Controls.Add(this.lblCurrentEndpoint);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.lblTitle);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.None;
            this.Name = "PageSettings";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "PageSettings";
            this.Load += new System.EventHandler(this.PageSettings_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label lblTitle;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label lblCurrentEndpoint;
        private System.Windows.Forms.TextBox txtEndpoint;
        private System.Windows.Forms.Button btnCheckConnection;
        private System.Windows.Forms.Button btnSave;
        private System.Windows.Forms.Timer timerErrorField;
    }
}