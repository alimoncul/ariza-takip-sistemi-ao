<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="yetkili.aspx.cs" Inherits="ariza_takip.main" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Arıza Takip Sistemi - Yetkili</title>
    <link href="Resources/main.css" rel="stylesheet" />
    <link href="Resources/girisSayfasi.css" rel="stylesheet" />
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
                <asp:Button ID="yetkili_ekleme" runat="server" Text="Yetki ver" CssClass="girisBilgieri" style="border-radius:4px;height:70px;width:20%;font-size:44px;background-color:royalblue;color:beige;font:bold;float:left" OnClick="yetkili_ekleme_Click"/>
                <asp:Button ID="rapor_cikart" runat="server" Text="Rapor çıkart" CssClass="girisBilgieri" style="border-radius:4px;height:70px;width:30%;font-size:44px;background-color:darkgoldenrod;color:beige;font:bold;float:left" OnClick="rapor_cikart_Click"/>
                <asp:Button ID="Ariza_ekleme" runat="server" Text="Arıza Bildir" CssClass="girisBilgieri" style="border-radius:4px;height:70px;width:50%;font-size:44px;background-color:crimson;color:beige;font:bold;float:left" OnClick="Ariza_ekleme_Click"/>
                <div>
                    <asp:Panel ID="yetkiVermePanel" runat="server" Visible="true" CssClass="girisBilgieri">
                        <asp:GridView ID="yetkiVerGrid" AutoGenerateColumns="False" runat="server" AllowPaging="True" CellPadding="4" ForeColor="Black" GridLines="Vertical" CssClass="grid" BackColor="White" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" PageSize="50" OnPageIndexChanging="Grid_PageIndexChanging" OnRowCommand="yetkiVerGrid_RowCommand">
                            <Columns>
                                <asp:BoundField DataField="isim" HeaderText="İsim" ItemStyle-Width="190px"></asp:BoundField>
                                <asp:BoundField DataField="soyisim" HeaderText="Soyisim" ItemStyle-Width="190px"></asp:BoundField>
                                <asp:BoundField DataField="calistigi_bolum" HeaderText="Çalıştığı Bölüm" ItemStyle-Width="490px"></asp:BoundField>
                                <asp:BoundField DataField="sicil_no" HeaderText="Sicil No" ItemStyle-Width="190px"></asp:BoundField>
                                <asp:TemplateField ItemStyle-Width="650px">
                                    <ItemTemplate>
                                        <asp:Button ID="yetki_ver" runat="server" Text="Yetki ver" CommandName="Yetkilendir" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" CssClass="cozumleButon"/> 
                                        <asp:Button ID="kullanici_sil" runat="server" Text="Kullanıcıyı Sil" CommandName="KullaniciSil" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" CssClass="cozumleButon"/> 
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <AlternatingRowStyle BackColor="White" />
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
                    </asp:Panel>
                </div>
                <div style="margin-left:35%">
                    <asp:Panel ID="arizaEklemePanelYetkili" runat="server" CssClass="girisBilgieri" Visible="false">
                        <table>
                            <tr>
                                <th colspan="2" style="font-size:37px">Arıza Bildirim Formu</th>
                            </tr>
                            <tr>
                                <td>İsim: </td>
                                <td><asp:TextBox ID="ariza_bildirme_isim" runat="server" CssClass="arizaTablo" ></asp:TextBox></td>
                                <td><asp:RequiredFieldValidator ID="ArizaBildirmeKontrolIsım" runat="server" ErrorMessage="*İsim alanı boş bırakılamaz!" ControlToValidate="ariza_bildirme_isim" CssClass="arizaBildirme"></asp:RequiredFieldValidator></td>
                            </tr>
                            <tr>
                                <td>Soyad: </td>
                                <td><asp:TextBox ID="ariza_bildirme_soyisim" runat="server" CssClass="arizaTablo" ></asp:TextBox></td>
                                <td><asp:RequiredFieldValidator ID="ArizaBildirmeKontrolSoyIsım" runat="server" ErrorMessage="*Soyisim alanı boş bırakılamaz!" ControlToValidate="ariza_bildirme_soyisim" CssClass="arizaBildirme"></asp:RequiredFieldValidator></td>
                            </tr>
                            <tr>
                                <td>Çalıştığınız Bölüm: </td>
                                <td><asp:DropDownList ID="calisma_bolumleri" runat="server" CssClass="arizaDropdown">
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
                            <tr style="text-align:center">
                                <td colspan="2">Açıklama</td>
                            </tr>
                            <tr>
                                <td colspan="2" rowspan="1"><asp:TextBox ID="ariza_bildirme_aciklama" runat="server" CssClass="arizaTip" style="width:100%;height:100px" TextMode="MultiLine"></asp:TextBox></td>
                                <td><asp:RequiredFieldValidator ID="ArizaBildirmeKontrolAciklama" runat="server" ErrorMessage="*Açıklama alanı boş bırakılamaz!" ControlToValidate="ariza_bildirme_aciklama" CssClass="arizaBildirme"></asp:RequiredFieldValidator></td>
                            </tr>
                            <tr>
                                <th colspan="2"><asp:Button ID="ariza_bildirme_gonder" runat="server" Text="Arızayı bildir" style="border-radius:4px;height:50px;width:200px;font-size:27px" OnClick="ariza_bildirme_gonder_Click"/></th>
                            </tr>
                        </table>
                    </asp:Panel>
                </div>
            </div>
            <asp:GridView ID="arizaList" AutoGenerateColumns="False" runat="server" AllowPaging="True" CellPadding="4" ForeColor="Black" GridLines="Vertical" CssClass="grid" BackColor="White" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" PageSize="50" OnPageIndexChanging="Grid_PageIndexChanging" OnRowCommand="arizaList_RowCommand">
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:BoundField DataField="id" HeaderText="Arıza Numarası" ItemStyle-Width="170px"></asp:BoundField>
                        <asp:BoundField DataField="bolum" HeaderText="Arızanın Bölümü" ItemStyle-Width="340px" ></asp:BoundField>
                        <asp:BoundField DataField="ariza_birakan_isim" HeaderText="İsim" ItemStyle-Width="140px"></asp:BoundField>
                        <asp:BoundField DataField="ariza_birakan_soyisim" HeaderText="Soyad" ItemStyle-Width="140px"></asp:BoundField>
                        <asp:BoundField DataField="aciklama" HeaderText="Açıklama" ItemStyle-Width="500px"></asp:BoundField>
                        <asp:BoundField DataField="ariza_tarihi" HeaderText="Tarih" ItemStyle-Width="100px"></asp:BoundField>
                        <asp:BoundField DataField="cozulme_durumu" HeaderText="Çözülme Durumu"/>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:Button ID="ariza_cozumle" runat="server" Text="Çözümle" CommandName="Cozumle" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" CssClass="cozumleButon"/>     
                            </ItemTemplate>
                        </asp:TemplateField>
                        
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
    </form>
</body>
</html>
