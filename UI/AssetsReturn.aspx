<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AssetsReturn.aspx.cs" Inherits="UI.Asset.AssetsReturn" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Assets Return</title>
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
                        <h5 class="card-header bg-dark text-light text-center">Return Assets</h5>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-6">
                                    <asp:Label ID="fullName" Font-Size="Medium" runat="server" Text="Name: "></asp:Label>
                                    <asp:Label class="form-control" ID="strName" Font-Size="Medium" runat="server" Text=" Mowaz Ahmad"></asp:Label>
                                </div>
                                <div class="col-md-6">
                                    <asp:Label ID="fullEmail" Font-Size="Medium" runat="server" Text="Email: "></asp:Label>
                                    <asp:Label class="form-control" ID="strEmail" Font-Size="Medium" runat="server" Text=" intern3.it@akijassets.com"></asp:Label>
                                </div>
                                <div class="col-md-6">
                                    <asp:Label ID="enrollID" Font-Size="Medium" runat="server" Text="Enroll: "></asp:Label>
                                    <asp:Label class="form-control" ID="intEnroll" Font-Size="Medium" runat="server" Text=" 546516"></asp:Label>
                                </div>
                                <div class="col-md-6">
                                    <asp:Label ID="assetID" Font-Size="Medium" runat="server" Text="Assets: "></asp:Label>
                                    <asp:CompareValidator ID="CompareValidator1" runat="server"
                                        ControlToValidate="assetList" ValueToCompare="0" Operator="NotEqual"
                                        Type="Integer" ErrorMessage="* Please select a Asset type" ForeColor="Red" />
                                    <asp:DropDownList class="form-select form-select-sm mb-3" ID="assetList" runat="server">
                                    </asp:DropDownList>
                                </div>
                                <div class="col-md-6">
                                    <asp:Label ID="textBox" runat="server">Reason</asp:Label>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                        ControlToValidate="ReasonID"
                                        ErrorMessage="* Please enter your product return reason "
                                        ForeColor="Red">
                                    </asp:RequiredFieldValidator>
                                    <asp:TextBox class="form-control" ID="ReasonID" runat="server"></asp:TextBox>
                                </div>
                                <div class="col-md-6">
                                    <asp:Label ID="actionId" class="d-block" Font-Size="Medium" runat="server" Text="Action"></asp:Label>
                                    <div class="btn-group btn-group-sm" role="group">
                                        <asp:Button class="btn btn-sm btn-success" ID="btnSubID" runat="server" OnClick="submitBtnClick" Text="Submit" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="card mt-3">
                        <div class="card-header">
                            Asset Return Status
                        </div>
                        <div class="card-body p-3">
                            <asp:GridView ID="dgvlist" runat="server" AutoGenerateColumns="False" Font-Size="12px" ShowFooter="True" CellPadding="3" FooterStyle-Font-Bold="true" FooterStyle-HorizontalAlign="Right" BackColor="#DEBA84" BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellSpacing="2" CssClass="auto-style5" Width="100%">
                                <Columns>

                                    <asp:TemplateField HeaderText="Asset Name" SortExpression="srId" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label ID="assetNameID" Font-Size="11px" runat="server" Text='<%# Bind("AssetName") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="center" />
                                    </asp:TemplateField>

                                    

                                    <asp:TemplateField HeaderText="Supervisor Status" SortExpression="srId" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label ID="statusID" Font-Size="11px" runat="server" Text='<%# Bind("Aproved") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="center" />
                                    </asp:TemplateField>

                                   

                                    <asp:TemplateField HeaderText="Admin Status" SortExpression="srId" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label ID="adminstatusID" Font-Size="11px" runat="server" Text='<%# Bind("Approved") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="center" />
                                    </asp:TemplateField>

                                    

                                    <asp:TemplateField HeaderText="IT Status" SortExpression="srId" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label ID="ITstatusID" Font-Size="11px" runat="server" Text='<%# Bind("ITApproved") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="center" />
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Action" SortExpression="srId" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <div class="btn-group btn-group-sm" role="group" aria-label="Basic mixed styles example">
                                                <asp:Label ID="btnAprvd" Font-Size="10px" runat="server" class="btn btn-sm btn-success" Text='<%# Bind("StoreApproved") %>'/>
                                            </div>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="center" />
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Reject Reason" SortExpression="srId" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label ID="strRjctID" Font-Size="11px" runat="server" Text='<%# Bind("rjctReasn") %>'></asp:Label>
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
