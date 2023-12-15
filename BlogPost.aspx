<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="BlogPost.aspx.cs" Inherits="Claus_Christian_HW4_MIST353.BlogPost" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div>
        <h2>Write a Blog Post</h2>
        <asp:Label ID="lblTitle" runat="server" Text="Title"></asp:Label><br />
        <asp:TextBox ID="txtTitle" runat="server" placeholder="Title"></asp:TextBox><br />
        <asp:Label ID="lblUserName" runat="server" Text="UserName"></asp:Label><br />
        <asp:TextBox ID="txtUserName" runat="server" placeholder="UserName"></asp:TextBox><br />
        <asp:Label ID="lblContent" runat="server" Text="Content"></asp:Label><br />
        <asp:TextBox ID="txtContent" runat="server" TextMode="MultiLine" Rows="5" placeholder="Content"></asp:TextBox><br />
        <asp:Button ID="btnSubmit" runat="server" Text="Submit Post" OnClick="btnSubmit_Click" /><br />
        <hr />
        <h2>Blog Posts</h2>
        <asp:GridView ID="GridViewPosts" runat="server"></asp:GridView>
    </div>
</asp:Content>
