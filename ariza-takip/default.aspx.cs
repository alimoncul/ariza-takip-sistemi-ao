using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Npgsql;

namespace ariza_takip
{
    public partial class _default : System.Web.UI.Page
    {
        public static string baglanti_stringi = "Server=localhost;Port=5432;Database=ariza-takip-sistemi;User Id=postgres;Password = alim1234;";
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void girisButon_Click(object sender, EventArgs e)
        {
            string kullanici_adi = girisKullanciAdi.Text.ToString();
            string sifre = girisPassword.Value;
            NpgsqlConnection baglanti = new NpgsqlConnection(baglanti_stringi);
            NpgsqlDataReader oku;
            NpgsqlCommand komut = new NpgsqlCommand("SELECT* FROM yetki WHERE kullanici_adi='" + kullanici_adi + "' and sifre='" + sifre + "'");
            komut.Connection = baglanti;
            baglanti.Open();
            oku=komut.ExecuteReader();
            
            if(oku.Read()) //eger en az bir satir dönmüşse
            {
                string yetki = oku.GetString(0);
                string kullaniciAdi = oku.GetString(1);
                string sicil_no = oku.GetString(3);
                if(yetki=="1")
                {
                    Session["user"] = "Müdür";
                    Session["kullanici_adi"] = kullaniciAdi;
                    Session["sicil_no"] = sicil_no;
                    //müdürgirişi
                    baglanti.Close();
                    Response.Redirect("yetkili.aspx");
                }
                else
                {
                    Session["user"] = "Kullanıcı";
                    Session["kullanici_adi"] = kullaniciAdi;
                    Session["sicil_no"] = sicil_no;
                    //kullanıcıgirişi
                    baglanti.Close();
                    Response.Redirect("kullanici.aspx");
                }
                baglanti.Close();
            }
            else //yanlis giris yapilmistir
            {
                girisKullanciAdi.Text = "";
                girisPassword.Value = string.Empty;
                girisYanlis.Visible = true;
                baglanti.Close();
            }
            
            
        }

        protected void girisKayit_Click(object sender, EventArgs e)
        {
            kayitOlma.Visible = true;
        }

        protected void kayit_tamamla_Click(object sender, EventArgs e)
        {
            string k_adi = kayit_kullaniciadi.Text;
            string k_pass = kayit_sifre.Text;
            string k_blm = kayit_bolum.SelectedValue;
            string k_isim = kayit_isim.Text;
            string k_soyisim = kayit_soyisim.Text;
            int k_sicilno = Int32.Parse(kayit_sicil.Text.ToString());
            NpgsqlConnection baglanti = new NpgsqlConnection(baglanti_stringi);
            NpgsqlCommand komut_SicilKontrolu = new NpgsqlCommand("select sicil_no from yetki where sicil_no='" + k_sicilno + "';");
            komut_SicilKontrolu.Connection = baglanti;
            baglanti.Open();
            var sicil_no = komut_SicilKontrolu.ExecuteScalar();
            komut_SicilKontrolu.Dispose();
            baglanti.Close();
            if(sicil_no!=null)
            {
                string script = "alert(\"Bu sicil no sistemde bulunmaktadır!\");";
                ScriptManager.RegisterStartupScript(this, GetType(), "ServerControlScript", script, true);
            }
            else
            {
                NpgsqlCommand komut_ekleYetki = new NpgsqlCommand("INSERT INTO yetki(kullanici_adi,seviyesi,sicil_no,sifre) VALUES('" + k_adi + "',0," + k_sicilno + ",'" + k_pass + "');");
                NpgsqlCommand komut_ekleKullanici = new NpgsqlCommand("INSERT INTO kullanici(calistigi_bolum,isim,sicil_no,soyisim) VALUES('" + k_blm + "','" + k_isim + "'," + k_sicilno + ",'" + k_soyisim + "');");
                komut_ekleYetki.Connection = baglanti;
                baglanti.Open();
                komut_ekleYetki.ExecuteNonQuery();
                komut_ekleYetki.Dispose();
                baglanti.Close();
                komut_ekleKullanici.Connection = baglanti;
                baglanti.Open();
                komut_ekleKullanici.ExecuteNonQuery();
                komut_ekleKullanici.Dispose();
                baglanti.Close();
                Response.Redirect("default.aspx");
                string script = "alert(\"Kayıdınız başarıyla oluşturuldu. Giriş yapabilirsiniz.\");";
                ScriptManager.RegisterStartupScript(this, GetType(),"ServerControlScript", script, true);
            }
        }
    }
}