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
    public partial class kullanici : System.Web.UI.Page
    {
        public static string baglanti_stringi = "Server=localhost;Port=5432;Database=ariza-takip-sistemi;User Id=postgres;Password = alim1234;";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["user"] == "Kullanıcı")
            {
                NpgsqlConnection baglanti = new NpgsqlConnection(baglanti_stringi);
                NpgsqlCommand komut = new NpgsqlCommand("SELECT * FROM kullanici WHERE sicil_no='" + Session["sicil_no"] + "'");
                komut.Connection = baglanti;
                baglanti.Open();
                NpgsqlDataReader oku = komut.ExecuteReader();
                if (oku.Read())
                {
                    Session["isim"] = oku[0].ToString();
                    Session["soyisim"] = oku[1].ToString();
                    string calistigi_bolum = oku[2].ToString();
                    kullanici_isim.Text = Session["isim"].ToString();
                    kullanici_soyisim.Text = Session["soyisim"].ToString();
                    kullanici_bolum.Text = calistigi_bolum;
                    baglanti.Close();
                    NpgsqlCommand arizaListelemeKomut = new NpgsqlCommand("select * from ariza where cozulme_durumu='Çözülmedi' and UPPER(ariza_birakan_isim) LIKE UPPER('"+ Session["isim"] + "') and UPPER(ariza_birakan_soyisim) LIKE UPPER('"+ Session["soyisim"] + "') order by cozulme_durumu desc, id desc;");
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
            else if (Session["user"] == "Müdür")
            {
                Response.Redirect("yetkili.aspx");
            }
            else
            {
                Response.Redirect("default.aspx");
            }
        }

        protected void ariza_ekleme_butonu_Click(object sender, EventArgs e)
        {
            arizaEklemePanel.Visible = true;
            ariza_bildirme_isim.Text = Session["isim"].ToString();
            ariza_bildirme_soyisim.Text = Session["soyisim"].ToString();
        }

        protected void grid_PageIndexChanging(object sender, GridViewPageEventArgs e)
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
            NpgsqlCommand arizaListelemeKomut = new NpgsqlCommand("select * from ariza where cozulme_durumu='Çözülmedi' and UPPER(ariza_birakan_isim) LIKE UPPER('" + Session["isim"] + "') and UPPER(ariza_birakan_soyisim) LIKE UPPER('" + Session["soyisim"] + "') order by cozulme_durumu desc, id desc;");
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
}