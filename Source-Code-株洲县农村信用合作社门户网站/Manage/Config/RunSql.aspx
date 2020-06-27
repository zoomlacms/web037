﻿<%@ page language="C#" autoeventwireup="true" inherits="manage_Config_Sql, App_Web_z03oqmk3" enableviewstatemac="false" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<!DOCTYPE html>
<html>
<head runat="server">
<title>SQL执行</title>
<link type="text/css" rel="stylesheet" href="../../App_Themes/AdminDefaultTheme/Guide.css" />
<link type="text/css" rel="stylesheet" href="../../App_Themes/AdminDefaultTheme/index.css" />
<link type="text/css" rel="stylesheet" href="../../App_Themes/AdminDefaultTheme/main.css" />
<script type="text/javascript" src="../../JS/jquery-1.9.1.min.js"></script>
<script src="/JS/DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
    window.onload = function () {
        //页面状态保持
        if (document.getElementById("contain").value == "2") {
            ShowCreate('crt2', 'TabTitle2');
        }
        if (document.getElementById("contain").value == "3") {
            ShowCreate('crt3', 'TabTitle3')
        }
    }
    function addFile() {
        //添加文件上传Html组件
        var str = '<div>&nbsp;&nbsp;&nbsp;<a stytle="margin-left:5px" href="#" onclick="remove(this)">[-]</a><input type="file" name="File"/></div>'
        document.getElementById('MyFile').insertAdjacentHTML("beforeEnd", str)
    }
    function remove(obj) {
        while (obj.tagName != "DIV") obj = obj.parentNode;
        obj.parentNode.removeChild(obj);

    }
    function CheckUpLoadFile(obj) {
        DenyExt = "sql|txt|xml";
        var FileExt = "";
        FileExt = obj.value.substr(obj.value.lastIndexOf(".") + 1).toLowerCase();
        if (DenyExt.indexOf(FileExt) == -1) {
            alert("只允许上传" + DenyExt + "格式文件");
            if (!window.addEventListener) {
                obj.outerHTML += '';
            }
            else {
                obj.value = "";
                return false;
            }
        }
    }
    function Reset() {
        //重置文件上传Html组件
        var str = '<a href="#" onclick="addFile()">[+]</a> <input name="File" type="file" id="File1" /> ';
        str = str + '<br>';
        document.getElementById('MyFile').innerHTML = str;
    }

    //限制多选
    function checkCount() {
        var obj = document.getElementById("sl");
        var j = 0;
        for (var i = 0; i < obj.length; i++) {
            if (obj.options[i].selected) {
                j++;
                if (j > 1) {
                    obj.options[i].selected = false;

                }
            }
        }
       document.getElementById("HiddenField1").value= obj.value;
      //  $("#HiddenField1").val($(obj).val());
   
    }

    //滑动门
    var tID = 0;
    var arrTabTitle = new Array("TabTitle1", "TabTitle2", "TabTitle3");
    function pload() {
        var ID = '<%=Request.QueryString["id"]%>';
        if (ID != tID) {
            if (document.getElementById(arrTabTitle[ID].toString()) != null) {
                document.getElementById(arrTabTitle[ID].toString()).className = "titlemouseover";
            }
            if (document.getElementById(arrTabTitle[tID].toString()) != null) {
                document.getElementById(arrTabTitle[tID].toString()).className = "tabtitle";
            }
        }
        else 
        {
            if (document.getElementById("TabTitle") != null) {
                document.getElementById("TabTitle").style.display = "";
                document.getElementById("TabTitle").className = "titlemouseover";
            }
            tID = ID;
        }
    }

    function ShowCreate(result, id) {
        document.getElementById("contain").value = id.substr(8, 1);
        HideCreate();
        document.getElementById(result).style.display = "";

        for (var i = 0; i < arrTabTitle.length; i++) {
            if (arrTabTitle[i] == id) {
                document.getElementById(arrTabTitle[i]).style.display = "";
                document.getElementById(arrTabTitle[i]).className = "titlemouseover";
            } else {
                document.getElementById(arrTabTitle[i]).className = "tabtitle";
            }
        }
    }

    function HideCreate() {
        for (i = 1; i < 4; i++) {
            document.getElementById("crt" + i).style.display = "none";
        }
    }
    function ShowMainsgourl(lurl, rurl) {
        parent.parent.frames["left"].location = lurl;
        parent.parent.frames["main_right"].location = rurl; void (0);
    }
    //点击搜索后判断日期文本框是否有值
    function validator() {
        var patrn = /^\d{4}-\d{2}-\d{2}$/;
        if (!patrn.exec(document.getElementById("start").value)) {
            document.getElementById("lbStart").style.display = "";
            return false;
        }
        else {
            document.getElementById("lbStart").style.display = "none";
        }
        if (!patrn.exec(document.getElementById("end").value)) {
            document.getElementById("lbEnd").style.display = "";
            return false;
        }
        else {
            document.getElementById("lbEnd").style.display = "none";
        }
    }
</script>
<script type="text/javascript" src="../../js/jquery.js"></script>
<script type="text/javascript" src="../../js/Common.js"></script>
</head>
<body>
<form id="form1" runat="server" enctype="multipart/form-data">
<asp:HiddenField ID="contain" runat="server" /><%--页面保持--%>
<div class="r_navigation">
    <%if(GetOpenHelp.IsopenHelp()=="1")
    { %>
      <div id="help"> <a onclick="help_show('65')" title="帮助"></a></div>
  <%} %>后台管理&gt;&gt;扩展功能&gt;&gt;<a href="RunSql.aspx">开发中心</a>&gt;&gt;执行SQL语句</div>
<div class="spacingtitle">
    执行SQL语句</div>
<div>
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr align="center">
            <td id="TabTitle1" name="TabTitle1" class="titlemouseover" onclick="ShowCreate('crt1','TabTitle1')">
                录入脚本
            </td>
            <td id="TabTitle2" name="TabTitle2" class="tabtitle" onclick="ShowCreate('crt2','TabTitle2')">
                上传脚本
            </td>
            <td id="TabTitle3" name="TabTitle3" class="tabtitle" onclick="ShowCreate('crt3','TabTitle3')">
                按日期执行
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
    </table>
</div>
<table width="100%" style="height:220px;margin:auto;" border="0" cellpadding="0" cellspacing="1" class="border"
    id="crt1" name="crt1">
    <tr class="title">
        <td colspan="2">
            请输入标准T-SQL语句查询
        </td>
    </tr>
    <tr class="tdbg">
        <td colspan="2">
            <div style="margin: 5px;">
                输入您要执行SQL语句：<br />
                <asp:TextBox ID="TextBox1" runat="server" AutoCompleteType="Disabled" TextMode="MultiLine" CssClass="x_input" Style="width: 780px; height: 170px;"></asp:TextBox>
                <br />
                <asp:Button ID="btnSql1" runat="server" Text="主数据库执行SQL语句" CssClass="C_input" OnClick="btnSql1_Click" />
                <asp:Button ID="btnSql2" runat="server" Text="从数据库执行SQL语句" CssClass="C_input" OnClick="btnSql2_Click" />
                <asp:Button ID="btnClr" runat="server" Text="清空内容" CssClass="C_input" OnClick="btnClr_Click" />
                <asp:Button ID="saveSql" runat="server" Text="保存为脚本" CssClass="C_input" OnClick="saveSql_Click"  />
            </div>
            <asp:HiddenField ID="HiddenField1" Value="" runat="server" />
        </td>
    </tr>
</table><style>
        #sl select{ display:block; width=780px;}
        </style>
<!--end录入脚本-->
<table width="100%" border="0" cellpadding="2" cellspacing="1" class="border" id="crt2" name="crt2" style="display: none; height:220px; margin:auto;">
    <tr class="title">
        <td colspan="2">请上传标准T-SQL文件查询</td>
    </tr>
    <tr class="tdbg">
        <td colspan="2">
            <div style="height:170px;">
                <div id="sel" runat="server" style="float: left;width: 480px; height: 170px;">
                </div>
                <div id="MyFile" style="float: left; width: 255px;">
                    <a href="#" onclick="addFile()">[+]</a>
                    <input name="File" type="file" id="File1" />
                </div>
                <asp:Button ID="uploadSql" runat="server" OnClick="uploadSql_Click" Text="上传" CssClass="C_input" />
                <input type="button" value="重置" onclick="return Reset()" class="C_input" />
                <asp:Button ID="delete" runat="server" Text="删除" CssClass="C_input" OnClick="delete_Click" />
            </div>
            <asp:Button ID="btnSql3" runat="server" Text="在主数据库中执行SQL脚本" CssClass="C_input" OnClick="btnSql3_Click" />
            <asp:Button ID="btnSql4" runat="server" Text="在从数据库中执行SQL脚本" CssClass="C_input" OnClick="btnSql4_Click" />
            <div class="clear">
            </div>
        </td>
    </tr>
</table>
<!--end上传脚本-->
<!--start按日期执行-->
<table width="100%" border="0" cellpadding="2" cellspacing="1" class="border" id="crt3" name="crt3" style="display: none; height:220px; margin:auto;">
    <tr class="title">
        <td colspan="2">按日期执行</td>
    </tr>
    <tr class="tdbg">
        <td colspan="2">
            <div style="width:500px; height:220px;">
                <div>
                    <input type="text" runat="server" id="start" onblur="WdatePicker();" onclick="WdatePicker();" style="width:130px;" /><label id="lbStart" style="color:red;display:none;">*</label>
                    <input type="text" runat="server" id="end"  onblur="WdatePicker();" onclick="WdatePicker();" style="width:130px;" /><label id="lbEnd" style="color:red;display:none;">*</label>
                    <asp:Button ID="searchSql" runat="server" Text="搜索"  OnClick="searchsql_Click" CssClass="C_input" OnClientClick="return validator()"/>
                </div>
                <asp:ListBox ID="ListBox1" runat="server" Width="333px" Height="170px">
                </asp:ListBox>
                <div>
                    <asp:Button ID="Button5" runat="server" Text="主数据库执行SQL语句" CssClass="C_input" OnClick="btnSql5_Click" />
                <asp:Button ID="Button6" runat="server" Text="从数据库执行SQL语句" CssClass="C_input" OnClick="btnSql6_Click" />
                </div>
            </div>
        </td>
    </tr>
</table>
<!--end按日期执行-->
<div style="clear: both;">
</div>
<div id="RunOK" runat="server">
</div>
<div id="ErrorDiv" runat="server" style="color: Red;">
</div>
</form>
</body>
</html>
