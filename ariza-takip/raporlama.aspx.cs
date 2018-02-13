using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Npgsql;

namespace ariza_takip
{
    public partial class raporlama : System.Web.UI.Page
    {
        public static string baglanti_stringi = "Server=localhost;Port=5432;Database=ariza-takip-sistemi;User Id=postgres;Password = alim1234;";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (Session["user"] == "Müdür")
                {
                    NpgsqlConnection baglanti = new NpgsqlConnection(baglanti_stringi);
                    NpgsqlCommand komut = new NpgsqlCommand("SELECT * FROM mudur WHERE sicil_no='" + Session["sicil_no"] + "';");
                    komut.Connection = baglanti;
                    baglanti.Open();
                    NpgsqlDataReader oku = komut.ExecuteReader();
                    if (oku.Read())
                    {
                        string isim = oku[0].ToString();
                        string soyisim = oku[1].ToString();
                        komut.Dispose();
                        baglanti.Close();
                        yetkili_isim.Text = isim;
                        yetkili_soyisim.Text = soyisim;
                        baglanti.Close();
                    }
                    baglanti.Close();
                }
                else if (Session["user"] == "Kullanıcı")
                {
                    Response.Redirect("kullanici.aspx");
                }
                else
                {
                    Response.Redirect("default.aspx");
                }
            }
        }

        protected void rapor_cikart_Click(object sender, EventArgs e)
        {
            string baslangic_tarih_s = baslangic_tarih.Value.ToString();
            string bitis_tarih_s = bitis_tarih.Value.ToString();
            NpgsqlConnection baglanti = new NpgsqlConnection(baglanti_stringi);
            NpgsqlCommand kontrol = new NpgsqlCommand("SELECT * FROM ariza WHERE '[" + baslangic_tarih_s + "," + bitis_tarih_s + "]'::daterange @> ariza_tarihi;");
            kontrol.Connection = baglanti;
            baglanti.Open();
            try
            {
                NpgsqlDataReader oku = kontrol.ExecuteReader();
                if (oku.Read())
                {
                    kontrol.Dispose();
                    baglanti.Dispose();
                    NpgsqlConnection baglanti2 = new NpgsqlConnection(baglanti_stringi);
                    NpgsqlCommand komut = new NpgsqlCommand("SELECT * FROM ariza WHERE '[" + baslangic_tarih_s + "," + bitis_tarih_s + "]'::daterange @> ariza_tarihi;");
                    komut.Connection = baglanti2;
                    baglanti2.Open();
                    NpgsqlDataAdapter adapter = new NpgsqlDataAdapter(komut);
                    DataTable dt = new DataTable();
                    adapter.Fill(dt);
                    komut.Dispose();
                    baglanti2.Close();
                    raporList.DataSource = dt;
                    raporList.DataBind();
                    rapor_indir.Visible = true;
                }
                else
                {
                    string script = "alert(\"Bir sonuç bulunamadı.!\");";
                    ScriptManager.RegisterStartupScript(this, GetType(), "ServerControlScript", script, true);
                }
            }
            catch (Npgsql.PostgresException)
            {
                string script = "alert(\"Başlangıç tarihi, bitiş tarihinden sonra seçilemez!\");";
                ScriptManager.RegisterStartupScript(this, GetType(), "ServerControlScript", script, true);
            }
            
            
        }
        protected void grid_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            raporList.PageIndex = e.NewPageIndex;
            raporList.DataBind();
        }

        public override void VerifyRenderingInServerForm(Control control)
        {
            //errorblock
        }

        protected void rapor_indir_Click(object sender, EventArgs e)
        {
            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment;filename=RaporCiktisi.xls");
            Response.ContentEncoding = System.Text.Encoding.Default;
            Response.Charset = "windows-1254";
            Response.ContentType = "application/vnd.ms-excel";
            using (StringWriter sw = new StringWriter())
            {
                HtmlTextWriter hw = new HtmlTextWriter(sw);

                //To Export all pages
                raporList.AllowPaging = false;

                raporList.HeaderRow.BackColor = Color.White;
                foreach (TableCell cell in raporList.HeaderRow.Cells)
                {
                    cell.BackColor = raporList.HeaderStyle.BackColor;
                    cell.Attributes.CssStyle["text-align"] = "center";
                    cell.Attributes.CssStyle["height"] = "25px";
                }
                foreach (GridViewRow row in raporList.Rows)
                {
                    row.BackColor = Color.White;
                    foreach (TableCell cell in row.Cells)
                    {
                        if (row.RowIndex % 2 == 0)
                        {
                            cell.BackColor = raporList.AlternatingRowStyle.BackColor;
                            cell.Attributes.CssStyle["text-align"] = "center";
                            cell.Attributes.CssStyle["height"] = "25px";
                        }
                        else
                        {
                            cell.BackColor = raporList.RowStyle.BackColor;
                            cell.Attributes.CssStyle["text-align"] = "center";
                            cell.Attributes.CssStyle["height"] = "25px";
                        }
                        cell.CssClass = "textmode";
                        row.Height = 25;
                    }
                }

                raporList.RenderControl(hw);

                //style to format numbers to string
                string style = @"<style> .textmode { } </style>";
                Response.Write(style);
                Response.Output.Write(sw.ToString());
                Response.Flush();
                Response.End();
            }
        }
    }
}