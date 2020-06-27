﻿<%@ page language="C#" autoeventwireup="true" inherits="manage_Shop_SystemOrderModel, App_Web_l5gmkswb" enableviewstatemac="false" masterpagefile="~/Manage/I/Default.master" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<asp:Content runat="server" ContentPlaceHolderID="head">
    <title>订单参数</title>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
  <table id="EGV" class="table table-striped table-bordered table-hover">
      <tr>
          <td>
              <strong>字段名</strong>
          </td>
          <td style="width: 10%;">
              <strong>字段别名</strong>
          </td>
          <td style="width: 10%;">
              <strong>字段类型</strong>
          </td>
          <td style="width: 10%;">
              <strong>字段级别</strong>
          </td>
          <td style="width: 10%;">
              <strong>是否必填</strong>
          </td>
          <td style="width: 20%;">
              <strong>排序</strong>
          </td>
          <td style="width: 30%;">
              <strong>操作</strong>
          </td>
      </tr>
        <asp:Repeater ID="RepSystemModel" runat="server">
            <ItemTemplate>
                <tr>
                    <td>
                        <%#Eval("FieldName")%>
                    </td>
                    <td >
                        <%#Eval("FieldAlias")%>
                    </td>
                    <td >
                        <%# Eval("FieldType", "{0}")%>
                    </td>
                    <td >
                        <span style="color: #339900">系统</span>
                    </td>
                    <td >
                        <%# GetStyleTrue(Eval("IsNotNull", "{0}"))%>
                    </td>
                    <td>
                    </td>
                    <td >
                    </td>
                </tr>
            </ItemTemplate>
        </asp:Repeater>
        <asp:Repeater ID="RepModelField" runat="server" OnItemCommand="Repeater1_ItemCommand">
            <ItemTemplate>
                <tr>
                    <td><%#Eval("FieldName")%></td>
                    <td><%#Eval("FieldAlias")%></td>
                    <td><%# GetFieldType(Eval("FieldType", "{0}").ToString ())%></td>
                    <td>自定义</td>
                    <td><%# GetStyleTrue(Eval("IsNotNull", "{0}"))%></td>
                    <td>
                        <asp:LinkButton ID="LinkButton2" runat="server" CommandName="UpMove" CommandArgument='<%# Eval("FieldID") %>'>上移</asp:LinkButton>
                        |
                        <asp:LinkButton ID="LinkButton3" runat="server" CommandName="DownMove" CommandArgument='<%# Eval("FieldID") %>'>下移</asp:LinkButton>
                    </td>
                    <td >
                        <a href="ModifySysOrderField.aspx?FieldID=<%# Eval("FieldID") %>">修改</a> |
                        <asp:LinkButton ID="LinkButton1" runat="server" CommandName="Delete" CommandArgument='<%# Eval("FieldID") %>' OnClientClick="return confirm('确定删除此字段吗?')">删除</asp:LinkButton>
                    </td>
                </tr>
            </ItemTemplate>
        </asp:Repeater>
    </table>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">
    <script type="text/javascript">
        $().ready(function () {

        })
        window.onload = function ()
        {
            $("#EGV tr td:contains('系统')").parent().hide();
        }
        function ShowList() {
            $("#EGV tr td:contains('系统')").parent().toggle();
            $("#ShowLink").text($("#ShowLink").text() == "[显示所有字段]" ? "[隐藏系统字段]" : "[显示所有字段]");
        }
    </script>
</asp:Content>