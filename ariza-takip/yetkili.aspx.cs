using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Npgsql;

namespace ariza_takip
{
    public partial class main : System.Web.UI.Page
    {
        public static string baglanti_stringi = "Server=localhost;Port=5432;Database=ariza-takip-sistemi;User Id=postgres;Password = alim1234;";
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!Page.IsPostBack)
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
                        NpgsqlCommand arizaListelemeKomut = new NpgsqlCommand("select * from ariza where cozulme_durumu='Çözülmedi' order by cozulme_durumu desc, id desc;");
                        arizaListelemeKomut.Connection = baglanti;
                        baglanti.Open();
                        NpgsqlDataAdapter adapter = new NpgsqlDataAdapter(arizaListelemeKomut);
                        DataTable dt = new DataTable();
                        adapter.Fill(dt);
                        arizaListelemeKomut.Dispose();
                        komut.Dispose();
                        baglanti.Close();
                        arizaList.DataSource = dt;
                        arizaList.DataBind();
                    }
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

        protected void Ariza_ekleme_Click(object sender, EventArgs e)
        {
            arizaEklemePanelYetkili.Visible = true;
        }
        protected void Grid_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            arizaList.PageIndex = e.NewPageIndex;
            arizaList.DataBind();
        }
        protected void ariza_bildirme_gonder_Click(object sender, EventArgs e)
        {
            string ariza_isim = ariza_bildirme_isim.Text;
            string ariza_soyisim = ariza_bildirme_soyisim.Text;
            string ariza_bolum = calisma_bolumleri.SelectedValue;
            string ariza_aciklama = ariza_bildirme_aciklama.Text;
            NpgsqlConnection baglanti = new NpgsqlConnection(baglanti_stringi);
            NpgsqlCommand komut = new NpgsqlCommand("INSERT INTO ariza(ariza_birakan_isim,ariza_birakan_soyisim,bolum,aciklama,cozulme_durumu,ariza_tarihi) VALUES('" + ariza_isim + "','" + ariza_soyisim + "','" + ariza_bolum + "','" + ariza_aciklama + "','Çözülmedi',CURRENT_DATE);");
            komut.Connection = baglanti;
            baglanti.Open();
            komut.ExecuteNonQuery();
            komut.Dispose();
            baglanti.Close();
            string script = "alert(\"Arıza bildirildi, en yakın sürede ekibimiz yardımcı olacaktır.\");";
            ScriptManager.RegisterStartupScript(this, GetType(), "ServerControlScript", script, true);
            NpgsqlCommand arizaListelemeKomut = new NpgsqlCommand("select * from ariza where cozulme_durumu='Çözülmedi' order by cozulme_durumu desc, id desc;");
            arizaListelemeKomut.Connection = baglanti;
            baglanti.Open();
            NpgsqlDataAdapter adapter = new NpgsqlDataAdapter(arizaListelemeKomut);
            DataTable dt = new DataTable();
            adapter.Fill(dt);
            arizaListelemeKomut.Dispose();
            komut.Dispose();
            baglanti.Close();
            arizaList.DataSource = dt;
            arizaList.DataBind();
        }
        protected void arizaList_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if(e.CommandName.CompareTo("Cozumle")==0)
            {
                string arizaID_S = arizaList.Rows[Convert.ToInt32(e.CommandArgument)].Cells[0].Text;
                int arizaID = Convert.ToInt32(arizaID_S);
                NpgsqlConnection baglanti = new NpgsqlConnection(baglanti_stringi);
                NpgsqlCommand komut = new NpgsqlCommand("UPDATE ariza SET cozulme_durumu='Çözüldü' WHERE id='" + arizaID + "';");
                komut.Connection = baglanti;
                baglanti.Open();
                komut.ExecuteNonQuery();
                komut.Dispose();
                baglanti.Close();
                NpgsqlCommand arizaListelemeKomut = new NpgsqlCommand("select * from ariza where cozulme_durumu='Çözülmedi' order by cozulme_durumu desc, id desc;");
                arizaListelemeKomut.Connection = baglanti;
                baglanti.Open();
                NpgsqlDataAdapter adapter = new NpgsqlDataAdapter(arizaListelemeKomut);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                arizaListelemeKomut.Dispose();
                komut.Dispose();
                baglanti.Close();
                arizaList.DataSource = dt;
                arizaList.DataBind();
            }
        }
        protected void yetkiVerGrid_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.CompareTo("Yetkilendir") == 0)
            {
                string sicilNo_S = yetkiVerGrid.Rows[Convert.ToInt32(e.CommandArgument)].Cells[3].Text;
                string isim = yetkiVerGrid.Rows[Convert.ToInt32(e.CommandArgument)].Cells[0].Text;
                string soyisim = yetkiVerGrid.Rows[Convert.ToInt32(e.CommandArgument)].Cells[1].Text;
                int sicilNo = Convert.ToInt32(sicilNo_S);
                NpgsqlConnection baglanti = new NpgsqlConnection(baglanti_stringi);
                NpgsqlCommand komut = new NpgsqlCommand("UPDATE yetki SET seviyesi=1 WHERE sicil_no='" + sicilNo + "'");
                komut.Connection = baglanti;
                baglanti.Open();
                komut.ExecuteNonQuery();
                komut.Dispose();
                NpgsqlCommand komut2 = new NpgsqlCommand("INSERT INTO mudur(isim,sicil_no,soyisim) VALUES('" + isim + "','" + sicilNo + "','" + soyisim + "')");
                komut2.Connection = baglanti;
                komut2.ExecuteNonQuery();
                komut2.Dispose();
                NpgsqlCommand komut3 = new NpgsqlCommand("DELETE FROM kullanici WHERE sicil_no='"+sicilNo+"'");
                komut3.Connection = baglanti;
                komut3.ExecuteNonQuery();
                komut3.Dispose();
                baglanti.Close();

                //Kullanıcıyı yetkilendirdikten sonra gridview'i yenilemek
                NpgsqlCommand komut4 = new NpgsqlCommand("SELECT * FROM kullanici;");
                komut4.Connection = baglanti;
                baglanti.Open();
                NpgsqlDataAdapter adapter = new NpgsqlDataAdapter(komut4);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                komut4.Dispose();
                baglanti.Close();
                yetkiVerGrid.DataSource = dt;
                yetkiVerGrid.DataBind();
            }
            else if(e.CommandName.CompareTo("KullaniciSil") ==0)
            {
                string sicilNo_S = yetkiVerGrid.Rows[Convert.ToInt32(e.CommandArgument)].Cells[3].Text;
                string isim = yetkiVerGrid.Rows[Convert.ToInt32(e.CommandArgument)].Cells[0].Text;
                string soyisim = yetkiVerGrid.Rows[Convert.ToInt32(e.CommandArgument)].Cells[1].Text;
                int sicilNo = Convert.ToInt32(sicilNo_S);
                NpgsqlConnection baglanti = new NpgsqlConnection(baglanti_stringi);
                NpgsqlCommand komut = new NpgsqlCommand("DELETE FROM kullanici WHERE sicil_no='" + sicilNo + "'");
                komut.Connection = baglanti;
                baglanti.Open();
                komut.ExecuteNonQuery();
                komut.Dispose();
                NpgsqlCommand komut2 = new NpgsqlCommand("DELETE FROM yetki WHERE sicil_no='" + sicilNo + "'");
                komut2.Connection = baglanti;
                komut2.ExecuteNonQuery();
                komut2.Dispose();
                NpgsqlCommand komut3 = new NpgsqlCommand("DELETE FROM ariza WHERE ariza_birakan_isim='" + isim +"' and ariza_birakan_soyisim='" + soyisim + "'");
                komut3.Connection = baglanti;
                komut3.ExecuteNonQuery();
                komut3.Dispose();
                baglanti.Close();

                //Kullanıcıyı yetkilendirdikten sonra gridview'i yenilemek
                NpgsqlCommand komut4 = new NpgsqlCommand("SELECT * FROM kullanici;");
                komut4.Connection = baglanti;
                baglanti.Open();
                NpgsqlDataAdapter adapter = new NpgsqlDataAdapter(komut4);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                komut4.Dispose();
                baglanti.Close();
                yetkiVerGrid.DataSource = dt;
                yetkiVerGrid.DataBind();
            }
        }

        protected void yetkili_ekleme_Click(object sender, EventArgs e)
        {
            NpgsqlConnection baglanti = new NpgsqlConnection(baglanti_stringi);
            NpgsqlCommand komut = new NpgsqlCommand("SELECT * FROM kullanici;");
            komut.Connection = baglanti;
            baglanti.Open();
            NpgsqlDataAdapter adapter = new NpgsqlDataAdapter(komut);
            DataTable dt = new DataTable();
            adapter.Fill(dt);
            komut.Dispose();
            komut.Dispose();
            baglanti.Close();
            yetkiVerGrid.DataSource = dt;
            yetkiVerGrid.DataBind();
            yetkiVermePanel.Visible = true;
        }

        protected void rapor_cikart_Click(object sender, EventArgs e)
        {
            if (Session["user"] == "Müdür")
            {
                Response.Redirect("raporlama.aspx");
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
}