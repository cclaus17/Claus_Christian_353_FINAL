<%@ Page Title="Search" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Search.aspx.cs" Inherits="Claus_Christian_HW4_MIST353.Search" %>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    <div>
        <h2>Search Cities</h2>
        <div>
            <asp:TextBox ID="txtMinTemperature" runat="server" placeholder="Min Temperature" />
            <asp:TextBox ID="txtMaxTemperature" runat="server" placeholder="Max Temperature" />
            <asp:TextBox ID="txtUserName" runat="server" placeholder="User Name" />
            <asp:DropDownList ID="ddlMonth" runat="server">
                <asp:ListItem Text="January" Value="1" />
                <asp:ListItem Text="February" Value="2" />
                <asp:ListItem Text="March" Value="3" />
                <asp:ListItem Text="April" Value="4" />
                <asp:ListItem Text="May" Value="5" />
                <asp:ListItem Text="June" Value="6" />
                <asp:ListItem Text="July" Value="7" />
                <asp:ListItem Text="August" Value="8" />
                <asp:ListItem Text="September" Value="9" />
                <asp:ListItem Text="October" Value="10" />
                <asp:ListItem Text="November" Value="11" />
                <asp:ListItem Text="December" Value="12" />
            </asp:DropDownList>
            <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" />
        </div>
        <br />
        <asp:GridView ID="CitiesGridView" runat="server" AutoGenerateColumns="False">
            <Columns>
                <asp:BoundField DataField="CityName" HeaderText="City" />
                <asp:BoundField DataField="AverageTemp" HeaderText="Average Temperature" />
              
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
