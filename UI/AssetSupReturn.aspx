<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AssetSupReturn.aspx.cs" Inherits="UI.Asset.AssetSupReturn" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Assets Supervisor Return</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet" />
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap" rel="stylesheet" />
    <!-- MDB -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/6.0.1/mdb.min.css" rel="stylesheet" />
    <style>
        .auto-style5 th{
            text-align:center;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12">
                    <div class="card mt-3">
                        <div class="card-header">
                            Asset Return List
                        </div>
                        <div class="card-body p-3">
                            <asp:GridView ID="dgvlist" runat="server" AutoGenerateColumns="False" Font-Size="12px" ShowFooter="True" CellPadding="3" FooterStyle-Font-Bold="true" FooterStyle-HorizontalAlign="Right" BackColor="#DEBA84" BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellSpacing="2" CssClass="auto-style5" Width="100%">
                                <Columns>

                                    <asp:TemplateField HeaderText="Name" SortExpression="srId">
                                        <ItemTemplate>
                                            <asp:Label ID="txtName" Font-Size="11px" runat="server" Text='<%# Bind("EmployeeName") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="center" />
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Enroll" SortExpression="srId">
                                        <ItemTemplate>
                                            <asp:Label ID="enrollID" Font-Size="11px" runat="server" Text='<%# Bind("Enroll") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="center" />
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Asset Name" SortExpression="srId">
                                        <ItemTemplate>
                                            <asp:Label ID="assetNameID" Font-Size="11px" runat="server" Text='<%# Bind("AssetName") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="center" />
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Job Station" SortExpression="srId">
                                        <ItemTemplate>
                                            <asp:Label ID="jobID" Font-Size="11px" runat="server" Text='<%# Bind("Employee_Designation") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="center" />
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Department" SortExpression="intId">
                                        <ItemTemplate>
                                            <asp:Label ID="depID" Font-Size="11px" runat="server" Text='<%# Bind("Department") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="center" />
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Job Station" SortExpression="intId">
                                        <ItemTemplate>
                                            <asp:Label ID="jbStatID" Font-Size="11px" runat="server" Text='<%# Bind("JobStation") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="center" />
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Return Reason" SortExpression="srId">
                                        <ItemTemplate>
                                            <asp:Label ID="reasonID" Font-Size="11px" runat="server" Text='<%# Bind("Reason") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="center" />
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Reject Reason" SortExpression="srId">
                                        <ItemTemplate>
                                            <asp:TextBox class="form-control" ID="ReasonTextID" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="center" />
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Action" SortExpression="srId">
                                        <ItemTemplate>
                                            <div class="btn-group btn-group-sm" role="group" aria-label="Basic mixed styles example">
                                                <asp:Button ID="btnAprvd" runat="server" class="btn btn-sm btn-success" Text="Approved" OnClick="apprvBtnClick" CommandArgument='<%# Eval("intId") %>' />
                                                <asp:Button class="btn btn-sm btn-warning" ID="btnRjct" runat="server" OnClick="rejectBtnClick" Text="Reject" CommandArgument='<%# Eval("intId") %>' />
                                            </div>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="center" />
                                    </asp:TemplateField>
                                </Columns>

                                <FooterStyle BackColor="#F7DFB5" ForeColor="#8C4510" />
                                <HeaderStyle BackColor="#A55129" Font-Bold="True" ForeColor="White" />
                                <PagerStyle ForeColor="#8C4510" HorizontalAlign="Center" />
                                <RowStyle BackColor="#FFF7E7" ForeColor="#8C4510" />
                                <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="White" />
                                <SortedAscendingCellStyle BackColor="#FFF1D4" />
                                <SortedAscendingHeaderStyle BackColor="#B95C30" />
                                <SortedDescendingCellStyle BackColor="#F1E5CE" />
                                <SortedDescendingHeaderStyle BackColor="#93451F" />
                            </asp:GridView>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
