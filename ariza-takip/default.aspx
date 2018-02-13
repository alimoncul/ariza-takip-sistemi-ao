<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="ariza_takip._default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Arıza Takip Sistemi</title>
    <link href="Resources/girisSayfasi.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server" style="min-width:1000px" class="yaziTipDegistir">
        <div id="anaDiv" style="height:100%">
            <div id="icDivÜst" style="height:30%;margin-left:auto;margin-top:3%;text-align:center">
                <asp:Label ID="girisLabel" runat="server" Text="Arıza Takip Sistemine Giriş" Font-Size="62px"></asp:Label>
            </div>
            <div id="icDivAlt" style="height:70%;margin-left:39.5%;margin-top:3%">
                <table>
                    <tr>
                        <th colspan="3" style="font-size:37px">Kullanıcı Girişi</th>
                    </tr>
                    <tr style="font-size:27px">
                        <td>Kullanıcı adı:</td>
                        <td><asp:TextBox ID="girisKullanciAdi" runat="server" CssClass="girisTablo" ></asp:TextBox></td>
                    </tr>
                    <tr style="font-size:27px">
                        <td>Şifre:</td>
                        <td><input id="girisPassword" runat="server" class="girisTablo" type="password"/></td>
                    </tr>
                    <tr>
                        <th colspan="1"><asp:Button ID="girisButon" runat="server" Text="Giriş yap" style="border-radius:4px;height:50px;width:200px;font-size:27px;background-color:lightgreen" OnClick="girisButon_Click"/></th>
                        <th colspan="1"><asp:Button ID="girisKayit" runat="server" Text="Kayıt ol" style="border-radius:4px;height:50px;width:200px;font-size:27px;background-color:lightskyblue" OnClick="girisKayit_Click"/></th>
                    </tr>
                    <tr>
                        <th colspan="3"><asp:Label ID="girisYanlis" runat="server" Text="Yanlış giriş yaptınız!" Visible="false" Font-Size="XX-Large" BorderColor="Red"></asp:Label></th>
                    </tr>
                </table>
            </div>
            <div style="margin-left:37%;margin-top:2%">
                <asp:Panel ID="kayitOlma" runat="server" Visible="false">
                <table>
                    <tr>
                        <th colspan="2" style="font-size:37px">Kayıt Formu</th>
                    </tr>
                    <tr style="font-size:27px">
                        <td>İsim: </td>
                        <td><asp:TextBox ID="kayit_isim" runat="server" CssClass="girisTablo" Width="270px"></asp:TextBox></td>
                        <td><asp:RequiredFieldValidator ID="kontrol_isim" runat="server" ErrorMessage="*İsim boş bırakılamaz!" ControlToValidate="kayit_isim" CssClass="validationTip"> </asp:RequiredFieldValidator></td>
                    </tr>
                    <tr style="font-size:27px">
                        <td>Soyisim: </td>
                        <td><asp:TextBox ID="kayit_soyisim" runat="server" CssClass="girisTablo" Width="270px"></asp:TextBox></td>
                        <td><asp:RequiredFieldValidator ID="kontrol_soyisim" runat="server" ErrorMessage="*Soyisim boş bırakılamaz!" ControlToValidate="kayit_soyisim" CssClass="validationTip"> </asp:RequiredFieldValidator></td>
                    </tr>
                    <tr style="font-size:27px">
                        <td>Çalıştığınız Bölüm: </td>
                        <td><asp:DropDownList ID="kayit_bolum" runat="server" CssClass="arizaDropdown">
                                    <asp:ListItem>İşletme ve İştirakler Müdürlüğü</asp:ListItem>
                                    <asp:ListItem>Park ve Bahçeler Müdürlüğü</asp:ListItem>
                                    <asp:ListItem>Kültür ve Sosyal İşler Müdürlüğü</asp:ListItem>
                                    <asp:ListItem>Muhtarlık İşleri Müdürlüğü</asp:ListItem>
                                    <asp:ListItem>Temizlik İşleri Müdürlüğü</asp:ListItem>
                                    <asp:ListItem>Kütüphane Müdürlüğü</asp:ListItem>
                                    <asp:ListItem>Destek Hizmetleri Müdürlüğü</asp:ListItem>
                                    <asp:ListItem>Mezarlıklar Müdürlüğü</asp:ListItem>
                                    <asp:ListItem>Fen İşleri Müdürlüğü</asp:ListItem>
                                    <asp:ListItem>Özel Kalem Müdürlüğü</asp:ListItem>
                                    <asp:ListItem>Mali Hizmetler Müdürlüğü</asp:ListItem>
                                    <asp:ListItem>Bilgi İşlem Müdürlüğü</asp:ListItem>
                                    <asp:ListItem>Yazı İşleri Müdürlüğü</asp:ListItem>
                                    <asp:ListItem>İnsan Kaynakları ve Eğitim Müdürlüğü</asp:ListItem>
                                    <asp:ListItem>İmar ve Şehircilik Müdürlüğü</asp:ListItem>
                                    <asp:ListItem>Zabıta Müdürlüğü</asp:ListItem>
                                    <asp:ListItem>Emlak ve İstimlak Müdürlüğü</asp:ListItem>
                                    <asp:ListItem>Yapı ve Kontrol Müdürlüğü</asp:ListItem>
                                    <asp:ListItem>Hukuk İşleri Müdürlüğü</asp:ListItem>
                                    </asp:DropDownList></td>
                    </tr>
                    <tr style="font-size:27px">
                        <td>Sicil Numaranız: </td>
                        <td><asp:TextBox ID="kayit_sicil" runat="server" CssClass="girisTablo" Width="270px" TextMode="Number"></asp:TextBox></td>
                        <td><asp:RequiredFieldValidator ID="kontrol_sicil" runat="server" ErrorMessage="*Lütfen bir sicil no giriniz!" ControlToValidate="kayit_sicil" CssClass="validationTip"> </asp:RequiredFieldValidator></td>
                    </tr>
                    <tr style="font-size:27px">
                        <td>Kullanıcı adı: </td>
                        <td><asp:TextBox ID="kayit_kullaniciadi" runat="server" CssClass="girisTablo" Width="270px"></asp:TextBox></td>
                        <td><asp:RequiredFieldValidator ID="kontrol_kadi" runat="server" ErrorMessage="*Kullanıcı adı boş bırakılamaz!" ControlToValidate="kayit_kullaniciadi" CssClass="validationTip"> </asp:RequiredFieldValidator></td>
                    </tr>
                    <tr style="font-size:27px">
                        <td>Şifreniz: </td>
                        <td><asp:TextBox ID="kayit_sifre" runat="server" TextMode="Password" CssClass="girisTablo" Width="270px"></asp:TextBox></td>
                        <td><asp:RequiredFieldValidator ID="kontrol_sifre" runat="server" ErrorMessage="*Lütfen bir şifre giriniz!" ControlToValidate="kayit_sifre" CssClass="validationTip"> </asp:RequiredFieldValidator></td>
                    </tr>
                    <tr>
                        <th colspan="2"><asp:Button ID="kayit_tamamla" runat="server" Text="Kayıt" style="border-radius:4px;height:50px;width:400px;font-size:32px;background-color:lightskyblue" OnClick="kayit_tamamla_Click"/></th>
                    </tr>
                </table>
            </asp:Panel>
            </div>
            
        </div>
    </form>
</body>
</html>
