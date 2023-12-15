<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SearchHistory.aspx.cs" Inherits="WebFormsIdentity.SearchHistory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div>
        <h4>Search History</h4>
        <hr />
        <asp:GridView ID="SearchHistoryGridView" runat="server" AutoGenerateColumns="False">
            <Columns>
                <asp:BoundField DataField="UserName" HeaderText="UserName" />
                <asp:BoundField DataField="MinTemperature" HeaderText="Min Temperature" />
                <asp:BoundField DataField="MaxTemperature" HeaderText="Max Temperature" />
                <asp:BoundField DataField="SelectedMonth" HeaderText="Month" DataFormatString="{0:MMMM}" />
                <asp:BoundField DataField="SearchDate" HeaderText="Search Date" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
