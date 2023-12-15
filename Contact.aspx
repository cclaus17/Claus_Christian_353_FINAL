<%@ Page Title="Super Cool Travel Service" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="Claus_Christian_HW4_MIST353.Contact" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <main aria-labelledby="title">
        <h2 id="Contacts:"><%: Title %>.</h2>
        <h3>Contacts</h3>
        <address>
            49 Falling Run Road<br />
            Morgantown, WV, 26505<br />
            <abbr title="Phone">P:</abbr>
            412-818-8320
        </address>

        <address>
            <strong>Support:</strong>   <a href="mailto:Support@example.com">ctc00001@mix.wvu.edu</a><br />
            <strong>Marketing:</strong> <a href="mailto:Marketing@example.com">ctc00001@mix.wvu.edu</a>
        </address>
    </main>
</asp:Content>
