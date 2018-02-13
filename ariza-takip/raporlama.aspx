<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="raporlama.aspx.cs" Inherits="ariza_takip.raporlama" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Arıza Takip Sistemi - Yetkili - Raporlama</title>
    <link href="Resources/main.css" rel="stylesheet" />
    <link href="Resources/girisSayfasi.css" rel="stylesheet" />
    <script>
        function SonT() {
            var selectedDate = document.getElementById("bitis_tarih").value;
            if (selectedDate > Date.now()) {
                alert("İleri bir tarihi seçemezsiniz.")
                return false;
            }
            return true;
        }
        function BasT()
        {
            var selectedDate = document.getElementById("baslangic_tarih").value;
            if (selectedDate > Date.now())
            {
                alert("İleri bir tarihi seçemezsiniz.")
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
    <form id="form1" runat="server" style="min-width:1000px">
        <div id="Main" style="height:100%;width:100%">
            <div style="height:20%;float:left;width:100%">
                <div style="height:100%">
                    <asp:Label ID="hos" runat="server" Text="Hoşgeldiniz, Sayın:" CssClass="girisBilgieri"></asp:Label>
                    <a href="OturumKapat.aspx" class="sagUst"> Güvenli Çıkış </a>
                    &nbsp;
                    <asp:Label ID="yetkili_isim" runat="server" Text="" CssClass="girisBilgieri"></asp:Label>
                    &nbsp;
                    <asp:Label ID="yetkili_soyisim" runat="server" Text="" CssClass="girisBilgieri"></asp:Label>
                </div>
                <div style="height:70%;margin-left:30.8%;margin-top:3%">
                    <table style="text-align:center;width:700px;border: 2px solid black;padding:10px">
                    <tr style="font-size:35px;font-family:'Segoe UI', Tahoma, Geneva, Verdana, sans-serif">
                        <th colspan="4"><asp:Label ID="tarihGir" runat="server" Text="Lütfen tarih aralığını seçiniz"></asp:Label></th>
                    </tr>
                    <tr style="font-size:26px;font-family:'Segoe UI', Tahoma, Geneva, Verdana, sans-serif">
                        <td colspan="2"><asp:Label ID="tarihSol" runat="server" Text="Başlangıç tarihini giriniz"></asp:Label></td>
                        <td colspan="2"><asp:Label ID="tarihSag" runat="server" Text="Bitiş tarihini giriniz"></asp:Label></td>
                    </tr>
                    <tr>
                        <td colspan="2"><input id="baslangic_tarih" type="date" runat="server" required="required" onchange="BasT" lang="tr" spellcheck="true"/></td>
                        <td colspan="2"><input id="bitis_tarih" type="date" runat="server"  required="required" onchange="SonT" lang="tr" spellcheck="true"/></td>
                    </tr>
                    <tr style="padding:15px">
                        <th colspan="4"><asp:Button ID="rapor_cikart" runat="server" Text="Raporu Çıkart" style="border-radius:4px;height:50px;width:400px;font-size:27px;background-color:lightskyblue" OnClick="rapor_cikart_Click"/></th>
                    </tr>
                     <tr style="padding:15px">
                         <th colspan="4"><asp:Button ID="rapor_indir" runat="server" Visible="false" Text="Raporu İndir" style="border-radius:4px;height:50px;width:400px;font-size:27px;background-color:lightsalmon" OnClick="rapor_indir_Click"/></th>
                    </tr>
                </table>
                </div>
                <asp:GridView ID="raporList" AutoGenerateColumns="False" runat="server" AllowPaging="True" CellPadding="4" ForeColor="Black" GridLines="Vertical" CssClass="grid" BackColor="White" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" PageSize="50" OnPageIndexChanging="grid_PageIndexChanging">
                    <AlternatingRowStyle BackColor="White"/>
                    <RowStyle Height="62px" />
                    <Columns>
                        <asp:BoundField DataField="id" HeaderText="Arıza Numarası" ItemStyle-Width="170px"/>
                        <asp:BoundField DataField="bolum" HeaderText="Arızanın Bölümü" ItemStyle-Width="340px" />
                        <asp:BoundField DataField="ariza_birakan_isim" HeaderText="İsim" ItemStyle-Width="140px"/>
                        <asp:BoundField DataField="ariza_birakan_soyisim" HeaderText="Soyad" ItemStyle-Width="140px"/>
                        <asp:BoundField DataField="aciklama" HeaderText="Açıklama" ItemStyle-Width="500px"/>
                        <asp:BoundField DataField="ariza_tarihi" HeaderText="Tarih" ItemStyle-Width="100px" />
                        <asp:BoundField DataField="cozulme_durumu" HeaderText="Çözülme Durumu"/>
                    </Columns>
                    <FooterStyle BackColor="#CCCC99" />
                    <HeaderStyle BackColor="#d6d5ab" Font-Bold="True" ForeColor="Black"  />
                    <PagerStyle BackColor="#d6d5ab" ForeColor="Black" HorizontalAlign="Right" />
                    <RowStyle BackColor="#F7F7DE" />
                    <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#FBFBF2" />
                    <SortedAscendingHeaderStyle BackColor="#d6d5ab" />
                    <SortedDescendingCellStyle BackColor="#EAEAD3" />
                    <SortedDescendingHeaderStyle BackColor="#575357" />
                </asp:GridView>
            </div>
        </div>
    </form>
</body>
</html>
