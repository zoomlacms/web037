﻿<%@ page language="C#" autoeventwireup="true" inherits="ZoomLa.WebSite.User.Content.MyContent, App_Web_ck41g3rm" enableviewstate="true" enableEventValidation="false" viewStateEncryptionMode="Never" %>

<!DOCTYPE HTML>
<html>
<head runat="server">
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>我的内容</title>
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->
    <link type="text/css" rel="stylesheet" href="/dist/css/bootstrap.min.css" />
    <link type="text/css" rel="stylesheet" href="/App_Themes/ICMS/User_V3.css" />
    <script type="text/javascript" src="/JS/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="/dist/js/bootstrap.min.js"></script>
     <script type="text/javascript" src="/JS/SelectCheckBox.js"></script>
</head>
<body>
    <ol class="breadcrumb">
        <li><asp:Label ID="lblNodeName" runat="server" Text="Label"></asp:Label></li>
        <li><asp:Label ID="lblAddContent" runat="server" Text="Label"></asp:Label></li>
        <li><a href="Recyle.aspx" style="color: blue;">进入回收站</a></li>
    </ol>
    <form id="form1" runat="server">
        <div class="us_seta">
            <ZL:ExGridView runat="server" ID="EGV" AutoGenerateColumns="false" AllowPaging="true" PageSize="10"  EnableTheming="False" IsHoldState="false"
                class="table table-striped table-bordered table-hover" EmptyDataText="当前没有信息!!" 
                OnPageIndexChanging="EGV_PageIndexChanging" OnRowCommand="Lnk_Click" >
                <Columns>
                   <asp:TemplateField HeaderText="选择">
                        <ItemTemplate>
                            <input type="checkbox" name="idChk" value="<%#Eval("GeneralID") %>"/>
                            <input type="hidden" id="order_Hid" mid="<%#Eval("GeneralID") %>" oid="<%#Eval("OrderID") %>"/>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:BoundField DataField="GeneralID" HeaderText="ID">
                        <HeaderStyle Width="6%" />
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="标题">
                        <HeaderStyle Width="50%" />
                        <ItemTemplate>
                            <a href="<%# GetUrl(Eval("GeneralID", "{0}"))%>" target="_blank"><%# GetModel(Eval("GeneralID", "{0}"))%><%# Eval("Title")%></a>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="状态">
                        <ItemTemplate>
                            <%# GetStatus(Eval("Status", "{0}")) %>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="已生成">
                        <ItemTemplate>
                            <%# GetCteate(Eval("IsCreate", "{0}"))%>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                  <asp:TemplateField HeaderText="排序">
                      <ItemTemplate>
                          <input type="text"   name="order_T"  value="<%#Eval("PageOrder") %>" onblur="OrderFunc(this);" style="width:50px;text-align:center;" tabindex="1"/>
                          <input type="hidden" name="order_Hid" value="<%#Eval("GeneralID")+":"+Eval("OrderID")+":"+Eval("PageOrder") %>" />
                      </ItemTemplate>
                  </asp:TemplateField>
                    <asp:TemplateField HeaderText="排序" Visible="false">
                        <ItemTemplate>
                        <a onclick="UpTr(this)" style="cursor:pointer;">上移</a>|
                        <a onclick="DownTr(this)" style="cursor:pointer;">下移</a>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="操作">
                        <ItemTemplate>
                            <asp:LinkButton ID="LinkButton2" runat="server" CommandName="Edit" CommandArgument='<%# Eval("GeneralID") %>'>修改</asp:LinkButton>
                    <asp:LinkButton ID="LinkButton3" runat="server" CommandName="Del" CommandArgument='<%# Eval("GeneralID") %>' OnClientClick="return confirm('你确定将该数据删除到回收站吗？')">删除</asp:LinkButton>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                   </Columns>
                    <PagerStyle HorizontalAlign="Center"/>
                   <RowStyle Height="24px" HorizontalAlign="Center" />
            </ZL:ExGridView>
            <div>
                <asp:Button ID="Button2" runat="server" Text="批量删除" OnClick="btnDeleteAll_Click" 
                    OnClientClick="return confirm('你确定要将所有选择项删除到回收站吗？');" CssClass="btn btn-primary" UseSubmitBehavior="true" />
                <input type="text" runat="server" id="TxtSearchTitle" class="form-control">
                <asp:Button ID="Btn_Search" runat="server" Text="搜索" CssClass="btn btn-primary" OnClick="Btn_Search_Click" />
                <asp:Button ID="saveOrder_Btn" runat="server" Text="保存排序" CssClass="btn btn-primary" OnClick="saveOrder_Btn_Click" OnClientClick="return confirm('确定要保存修改后的排序吗!!!');"/>
                <asp:HiddenField ID="hdid" runat="server" />
                <asp:HiddenField ID="hdflag" runat="server" />
                <asp:HiddenField ID="hdnoid" runat="server" />
                <asp:HiddenField ID="hdmdid" runat="server" />
            </div>
        </div>
        <script type="text/javascript">
            $().ready(function () {
                $("#<%=EGV.ClientID%>  tr>th:eq(0)").html("<input type=checkbox id='chkAll'/>");//EGV顶部
                $("#chkAll").click(function () { selectAllByName(this, "idChk"); });
            });
        </script>
<%--        <script type="text/javascript">
            function PostToCS(a, v, callBack) {
                $.ajax({
                    type: "Post",
                    data: { action: a, value: v },
                    success: function (data) { callBack(data); },
                    error: function () { callBack(data); }
                });
            }
            //交换ID，如无OrderID,则不交换
            function UpTr(obj) {
                var thisTr = $(obj).parent().parent();//tr
                var getup = $(obj).parent().parent().prev();//上一tr
                if ($(getup).find("#order_Hid").length < 1) return;//非需要交换行，不进行交换操作
                //交换ID
                switchID(thisTr, getup);
                $(getup).before(thisTr);
            }
            function DownTr(obj) {
                var thisTr = $(obj).parent().parent();
                var getdown = $(obj).parent().parent().next();
                if ($(getdown).find("#order_Hid").length < 1) return;
                switchID(thisTr, getdown);
                $(getdown).after(thisTr);
            }
            function switchID(tr1, tr2)//传入要交换Tr
            {
                $hid1 = $(tr1).find("#order_Hid");
                $hid2 = $(tr2).find("#order_Hid");
                oid1 = $hid1.attr("oid");
                oid2 = $hid2.attr("oid");
                mid1 = $hid1.attr("mid");
                mid2 = $hid2.attr("mid");
                $hid1.attr("oid", this.oid2);
                $hid2.attr("oid", this.oid1);
                PostToCS("UpdateOrder", mid1 + ":" + oid2 + "," + mid2 + ":" + oid1, CallBack);
            }
            function CallBack(data) {}
        </script>--%>
    </form>
</body>
</html>
