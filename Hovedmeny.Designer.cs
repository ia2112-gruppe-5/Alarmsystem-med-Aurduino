namespace Test_1
{
    partial class Hovedmeny
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
            System.Windows.Forms.DataVisualization.Charting.ChartArea chartArea1 = new System.Windows.Forms.DataVisualization.Charting.ChartArea();
            System.Windows.Forms.DataVisualization.Charting.Legend legend1 = new System.Windows.Forms.DataVisualization.Charting.Legend();
            System.Windows.Forms.DataVisualization.Charting.Series series1 = new System.Windows.Forms.DataVisualization.Charting.Series();
            this.listBoxAlarmHistory = new System.Windows.Forms.ListBox();
            this.chartTemp = new System.Windows.Forms.DataVisualization.Charting.Chart();
            this.btnAddAbonnent = new System.Windows.Forms.Button();
            this.btnAlterAbonnent = new System.Windows.Forms.Button();
            this.btnTempIntervals = new System.Windows.Forms.Button();
            this.btnAlarmGrenser = new System.Windows.Forms.Button();
            this.btnClose = new System.Windows.Forms.Button();
            this.listBoxNewAlarms = new System.Windows.Forms.ListBox();
            this.btnAckAlarm = new System.Windows.Forms.Button();
            this.label1 = new System.Windows.Forms.Label();
            ((System.ComponentModel.ISupportInitialize)(this.chartTemp)).BeginInit();
            this.SuspendLayout();
            // 
            // listBoxAlarmHistory
            // 
            this.listBoxAlarmHistory.FormattingEnabled = true;
            this.listBoxAlarmHistory.Location = new System.Drawing.Point(471, 13);
            this.listBoxAlarmHistory.Name = "listBoxAlarmHistory";
            this.listBoxAlarmHistory.ScrollAlwaysVisible = true;
            this.listBoxAlarmHistory.Size = new System.Drawing.Size(597, 108);
            this.listBoxAlarmHistory.TabIndex = 0;
            // 
            // chartTemp
            // 
            chartArea1.Name = "ChartArea1";
            this.chartTemp.ChartAreas.Add(chartArea1);
            legend1.Name = "Legend1";
            this.chartTemp.Legends.Add(legend1);
            this.chartTemp.Location = new System.Drawing.Point(13, 245);
            this.chartTemp.Name = "chartTemp";
            series1.ChartArea = "ChartArea1";
            series1.ChartType = System.Windows.Forms.DataVisualization.Charting.SeriesChartType.Line;
            series1.Legend = "Legend1";
            series1.Name = "Temperatur";
            this.chartTemp.Series.Add(series1);
            this.chartTemp.Size = new System.Drawing.Size(1055, 463);
            this.chartTemp.TabIndex = 1;
            this.chartTemp.Text = "chart1";
            // 
            // btnAddAbonnent
            // 
            this.btnAddAbonnent.Location = new System.Drawing.Point(13, 13);
            this.btnAddAbonnent.Name = "btnAddAbonnent";
            this.btnAddAbonnent.Size = new System.Drawing.Size(173, 23);
            this.btnAddAbonnent.TabIndex = 2;
            this.btnAddAbonnent.Text = "Legg til abonnenter";
            this.btnAddAbonnent.UseVisualStyleBackColor = true;
            this.btnAddAbonnent.Click += new System.EventHandler(this.btnAddAbonnent_Click);
            // 
            // btnAlterAbonnent
            // 
            this.btnAlterAbonnent.Location = new System.Drawing.Point(13, 42);
            this.btnAlterAbonnent.Name = "btnAlterAbonnent";
            this.btnAlterAbonnent.Size = new System.Drawing.Size(173, 23);
            this.btnAlterAbonnent.TabIndex = 3;
            this.btnAlterAbonnent.Text = "Endre abonnenter";
            this.btnAlterAbonnent.UseVisualStyleBackColor = true;
            this.btnAlterAbonnent.Click += new System.EventHandler(this.btnAlterAbonnent_ClickAsync);
            // 
            // btnTempIntervals
            // 
            this.btnTempIntervals.Location = new System.Drawing.Point(12, 71);
            this.btnTempIntervals.Name = "btnTempIntervals";
            this.btnTempIntervals.Size = new System.Drawing.Size(174, 23);
            this.btnTempIntervals.TabIndex = 4;
            this.btnTempIntervals.Text = "Endre temepratur intervaler";
            this.btnTempIntervals.UseVisualStyleBackColor = true;
            this.btnTempIntervals.Click += new System.EventHandler(this.btnTempIntervals_ClickAsync);
            // 
            // btnAlarmGrenser
            // 
            this.btnAlarmGrenser.Location = new System.Drawing.Point(13, 100);
            this.btnAlarmGrenser.Name = "btnAlarmGrenser";
            this.btnAlarmGrenser.Size = new System.Drawing.Size(173, 23);
            this.btnAlarmGrenser.TabIndex = 5;
            this.btnAlarmGrenser.Text = "Endre alarm grenser";
            this.btnAlarmGrenser.UseVisualStyleBackColor = true;
            this.btnAlarmGrenser.Click += new System.EventHandler(this.btnAlarmGrenser_ClickAsync);
            // 
            // btnClose
            // 
            this.btnClose.Location = new System.Drawing.Point(13, 216);
            this.btnClose.Name = "btnClose";
            this.btnClose.Size = new System.Drawing.Size(173, 23);
            this.btnClose.TabIndex = 9;
            this.btnClose.Text = "Lukk program";
            this.btnClose.UseVisualStyleBackColor = true;
            this.btnClose.Click += new System.EventHandler(this.btnClose_Click);
            // 
            // listBoxNewAlarms
            // 
            this.listBoxNewAlarms.FormattingEnabled = true;
            this.listBoxNewAlarms.Location = new System.Drawing.Point(471, 127);
            this.listBoxNewAlarms.Name = "listBoxNewAlarms";
            this.listBoxNewAlarms.ScrollAlwaysVisible = true;
            this.listBoxNewAlarms.Size = new System.Drawing.Size(597, 108);
            this.listBoxNewAlarms.TabIndex = 10;
            // 
            // btnAckAlarm
            // 
            this.btnAckAlarm.Location = new System.Drawing.Point(192, 13);
            this.btnAckAlarm.Name = "btnAckAlarm";
            this.btnAckAlarm.Size = new System.Drawing.Size(173, 23);
            this.btnAckAlarm.TabIndex = 12;
            this.btnAckAlarm.Text = "Anerkjenn alarm";
            this.btnAckAlarm.UseVisualStyleBackColor = true;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.BackColor = System.Drawing.Color.White;
            this.label1.Location = new System.Drawing.Point(371, 13);
            this.label1.MaximumSize = new System.Drawing.Size(40, 40);
            this.label1.MinimumSize = new System.Drawing.Size(40, 40);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(40, 40);
            this.label1.TabIndex = 13;
            // 
            // Hovedmeny
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.DimGray;
            this.ClientSize = new System.Drawing.Size(1080, 720);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.btnAckAlarm);
            this.Controls.Add(this.listBoxNewAlarms);
            this.Controls.Add(this.btnClose);
            this.Controls.Add(this.btnAlarmGrenser);
            this.Controls.Add(this.btnTempIntervals);
            this.Controls.Add(this.btnAlterAbonnent);
            this.Controls.Add(this.btnAddAbonnent);
            this.Controls.Add(this.chartTemp);
            this.Controls.Add(this.listBoxAlarmHistory);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.None;
            this.Name = "Hovedmeny";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Hovedmeny";
            ((System.ComponentModel.ISupportInitialize)(this.chartTemp)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.ListBox listBoxAlarmHistory;
        private System.Windows.Forms.DataVisualization.Charting.Chart chartTemp;
        private System.Windows.Forms.Button btnAddAbonnent;
        private System.Windows.Forms.Button btnAlterAbonnent;
        private System.Windows.Forms.Button btnTempIntervals;
        private System.Windows.Forms.Button btnAlarmGrenser;
        private System.Windows.Forms.Button btnClose;
        private System.Windows.Forms.ListBox listBoxNewAlarms;
        private System.Windows.Forms.Button btnAckAlarm;
        private System.Windows.Forms.Label label1;
    }
}