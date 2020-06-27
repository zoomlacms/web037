﻿<%@ page language="C#" autoeventwireup="true" inherits="manage_Site_SiteDetail, App_Web_ukja2mry" masterpagefile="~/manage/Site/SiteMaster.master" title="站点详情" debug="true" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<asp:Content runat="server" ContentPlaceHolderID="head" >
<meta charset="" />
<title>网站详情</title>
<script type="text/javascript" src="/JS/Common.js"></script>  
<script type="text/javascript" src="/JS/jquery-1.9.1.min.js"></script>
<script src="/Plugins/Chart/Js/highcharts.js" type="text/javascript"></script>
<script src="/Plugins/Chart/Js/exporting.js" type="text/javascript" charset="gb2312"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>站点详情</title>
<link href="../../dist/css/bootstrap.min.css" rel="stylesheet">
<!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
  <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
<![endif]-->
<style>
#site_nav .site01 a {background: url(../../App_Themes/AdminDefaultTheme/images/site/menu_cur.png) left no-repeat;}
#nav_site{ background:none; top:-10px;}
#optionDiv a {margin-left:5px;}
#optionUL { list-style:none;}
#optionUL li{ width:70px; float:left;text-align:center;margin-left:8px;} 
#optionUL li img{ width:60px;height:60px;} 
.urlbox{ display:none;}
#button1:hover{cursor:pointer;}
.copy_input{ border:1px solid #ccc; height:24px;}
#copytxt{height:150px;left:40%;top:200px; width:350px; background:#fff;margin: 0 auto;position:absolute; padding:20px; border:1px solid #ccc;}
.copy_botton{ margin-top:10px; float:right; width:70px; height:30px;text-align:center;}
.site_border{ border-left:1px solid #ccc;border-right:1px solid #ccc;border-bottom:1px solid #ccc;}
.site_boot{ height:13px;}
</style>
    <script language='javascript'>
        function copyToClipBoard(a)
        {
            var ma = document.getElementById('<%=manageID.ClientID%>');
            if (ma.value == "") 
            {
                alert("未分配管理员, 无法颁发");
            }
            else
            {
                var Sys = {};
                var ua = navigator.userAgent.toLowerCase();
                var s;(s = ua.match(/chrome\/([\d.]+)/)) ? Sys.chrome = s[1] :0;           
                if (Sys.chrome)
                {  
                    var copydiv = document.getElementById("copytxt");
                    copydiv.style.display = "block";
                    $("#<%=TextBox2.ClientID%>").select();
                }
                else 
                {
                    window.clipboardData.setData("Text", a.value); alert("复制成功\r\n\r\n" + '<%=manageID.Value%>');
                }
            }
        }
        function copyhidden()
        {
            document.getElementById("copytxt").style.display="none";
        }
    </script>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="pageContent">
    <div style="margin:auto">
    <div id="copytxt" style="display:none;">
        <p style="margin-bottom:20px; line-height:20px;">你使用的是非IE核心浏览器，请按下Ctrl+C复制代码到剪贴板</p>
        <asp:TextBox ID="TextBox2" runat="server" Width="300" CssClass="copy_input"></asp:TextBox>
        <input type="button" value="确定" onclick="copyhidden()" class="copy_botton" />
    </div>
    </div>
    <div id="m_site">
        <p>站群中心 >> 配置管理 >> 网站详情 <a href="SiteFileManage.aspx<%=Request.Url.Query+"&index=0" %>" title="" style="color:red;">[浏览文件]</a>
            <asp:TextBox ID="TextBox1" runat="server" ViewStateMode="Disabled" CssClass="urlbox"></asp:TextBox>
            <input type="button" id="button1" value="颁发管理链接" class="site_button" onclick="copyToClipBoard(<%=TextBox1.ClientID%>)" style="margin-left:10px;" /></p>
    </div>     
<script type="text/javascript">
        function ShowTabs(obj, id, b) {//Div切换
            $(obj).addClass("titlemouseover").siblings().removeClass("titlemouseover").addClass("tabtitle");
            $("#tab" + id).show().siblings().hide();
            $("#tab0" + id).show().siblings().hide();
        }
        function frameInit(obj) {//设定高度，并隐藏iframe中的面包屑导航
            //obj.height = document.frames['mainFrame'].document.body.scrollHeight * 0.95;
            //$doc = document.frames['mainFrame'].document;
        }
    //需要relative,top:-18px;left:16px;
</script>
<div id="site_main">
    <div class="pull-left" style="width:34%">
        <ul class="nav nav-tabs">
            <li class="active"><a href="#tab4" data-toggle="tab">基本设置</a></li>
            <li><a href="#tab2" data-toggle="tab">高级设置</a></li>
        </ul>
        <div class="tab-content">
            <div class="tab-pane active" id="tab4">
                <div id="CSWSDiv" class="cswsDiv site_border" style="margin-top:0px;display:none; padding-left:10px;padding-top:10px;">
                    <table id="Table1">
           <tr><td>站点名称：</td><td><asp:TextBox runat="server" ID="Name" MaxLength="20" CssClass="site_input" style="width:200px;" /></td></tr>
           <tr><td>管 理 员：</td><td><asp:TextBox runat="server" CssClass="site_input" ID="manageName"></asp:TextBox></td></tr>
           <tr><td>操作系统：</td><td><asp:Label runat="server" ID="opSystem" /></td></tr>
           <tr><td>IIS 版本：</td><td><asp:Label runat="server" ID="iisVersion" /></td></tr>
           <tr><td>Net 版本：</td><td>
               <asp:DropDownList runat="server" ID="netVersion">
                   <asp:ListItem Value="v2.0">v2.0</asp:ListItem>
                   <asp:ListItem Value="v4.0">v4.0</asp:ListItem>
               </asp:DropDownList>
               </td></tr>
           <tr><td>运行模式：</td><td>
                    <asp:DropDownList runat="server" ID="runMode">
                        <asp:ListItem Value="Integrated">集成模式</asp:ListItem>
                        <asp:ListItem Value="Classic">经典模式</asp:ListItem>
                    </asp:DropDownList></td></tr>
           <tr><td>I P 地址：</td><td><asp:Label runat="server" ID="serverIP" /></td></tr>
           <tr><td>站点状态：</td><td><asp:Label runat="server" ID="siteState" />
                   <asp:Button runat="server" ID="ssBtn1" OnClick="SSSite_Click" Text="启动" CssClass="site_button" style="margin-left:10px;"/></td></tr>
           <asp:Literal runat="server" ID="literalPath"></asp:Literal>
           <asp:Literal runat="server" ID="literalBind"></asp:Literal><!--协议，端口，域名-->
             <tr id="batTr"><td colspan="2" style="text-align:center;"><label for="newa">新增绑定</label>
	 	 <a href="javascript:" onclick="newadd()" title="添列一列" id="newa"><img src="../../App_Themes/AdminDefaultTheme/images/padd.jpg" /></a></td></tr>
           <tr><td>错误页(禁止访问)：</td><td><asp:TextBox runat="server" ID="errorPage1" MaxLength="40" CssClass="site_input" Text="无法读取配置文件" style="width:200px;"></asp:TextBox></td></tr>
           <tr><td>错误页(未 找 到)：</td><td><asp:TextBox runat="server" ID="errorPage2" MaxLength="40" CssClass="site_input" Text="无法读取配置文件" style="width:200px;"></asp:TextBox></td></tr>
           <tr><td>错误页(内部错误)：</td><td><asp:TextBox runat="server" ID="errorPage3" MaxLength="40" CssClass="site_input" Text="无法读取配置文件" style="width:200px;"></asp:TextBox></td></tr>
           <tr><td>错误页(服务不可用)：</td><td><asp:TextBox runat="server" ID="errorPage4" MaxLength="40" CssClass="site_input" Text="无法读取配置文件" style="width:200px;"></asp:TextBox></td></tr>
           <tr><td>应用程序池：</td><td><asp:Label runat="server" ID="siteAppPool" /></td></tr>
           <tr><td>操    作：</td>
               <td> <asp:Button runat="server" ID="basicSaveBtn" Text="保存基本设置"  CssClass="site_button" OnClick="BasicSaveBtn_Click" OnClientClick="return localCheck(this)"/>
                    <input type="button" id="reset" onclick="location=location;"  class="site_button" value="重置"/>
                    <input type="button"  value="取消" class="site_button" onclick="disDiv()"/>
               </td></tr>
        </table>
                </div>
                <div id="readOnlyDiv" class="cswsDiv site_border" style="margin-top:0px;padding-left:10px;padding-top:10px;">
                    <table id="tab0">
           <tr id="adminTR" runat="server"><td>站点名称：</td><td><asp:Label runat="server" ID="lName" /></td></tr>
            <tr id="userTR" runat="server" visible="false"><td>站点名称：</td><td><asp:DropDownList runat="server" ID="siteList" 
                  ToolTip="切换站点" AutoPostBack="true" OnSelectedIndexChanged="siteList_SelectedIndexChanged" /></td></tr>
           <tr><td>管 理 员：</td><td><asp:Label runat="server" ID="lManager" />
               <asp:HiddenField runat="server" ID="manageID" /> 
                              </td></tr>
           <tr><td>操作系统：</td><td><asp:Label runat="server" ID="lOPSystem" /></td></tr>
           <tr><td>IIS 版本：</td><td><asp:Label runat="server" ID="lIISVersion" /></td></tr>
           <tr><td>Net 版本：</td><td><asp:Label runat="server" ID="lNetVersion" /></td></tr>
           <tr><td>运行模式：</td><td><asp:Label runat="server" ID="lRunMode" /></td></tr>
           <tr><td>I P 地址：</td><td><asp:Label runat="server" ID="lServerIP" /></td></tr>
           <tr><td>站点状态：</td><td><asp:Label runat="server" ID="lSiteState" />
                   <asp:Button runat="server" ID="ssBtn2" OnClick="SSSite_Click" Text="启动" CssClass="site_button" style="margin-left:10px;"/></td></tr>
           <asp:Literal runat="server" ID="labelPath"></asp:Literal>
           <asp:Literal runat="server" ID="labelBind"></asp:Literal><!--协议，端口，域名-->
            <tr><td>站点网址：</td><td><a href="http://<%= GetUrl() %>" target="_blank"><%= GetUrl() %></a></td></tr>
           <tr><td>错误页(禁止访问)：</td><td><asp:Label runat="server" ID="lErrorPage1" Text="无法读取配置文件" /></td></tr>
           <tr><td>错误页(未 找 到)：</td><td><asp:Label runat="server" ID="lErrorPage2" Text="无法读取配置文件" /></td></tr>
           <tr><td>错误页(内部错误)：</td><td><asp:Label runat="server" ID="lErrorPage3" Text="无法读取配置文件" /></td></tr>
           <tr><td>错误页(服务不可用)：</td><td><asp:Label runat="server" ID="lErrorPage4" Text="无法读取配置文件" /></td></tr>
           <tr><td>应用程序池：</td><td><asp:Label runat="server" ID="lSitePool" /> </td></tr>
           <tr><td>操    作：</td>
               <td> <input type="button" id="editMode" value="编辑" class="site_button" onclick="disDiv()"/>
                    <input  runat="server" id="rBtn" type="button" value="返回管理界面" class="site_button" onclick="back();"/>
               </td></tr>
        </table>
                </div>
            </div>
            <div class="tab-pane fade" id="tab2">
                <div id="CSWSDiv1" class="cswsDiv site_border" style="margin-top:0px;display:none;padding-left:10px;padding-top:10px;">
                    <table id="Table2" style="">
           <tr><td>最大CPU使用限制(1/1000)：</td><td><asp:TextBox runat="server" ID="emaxCPULimit" MaxLength="20" CssClass="site_input" style="width:300px;" /></td></tr>
           <tr><td>发生配置更改时禁止回收： </td><td>
               <asp:DropDownList runat="server" ID="econfigChange">
                   <asp:ListItem Value="True">是</asp:ListItem>
                   <asp:ListItem Value="False">否</asp:ListItem>
               </asp:DropDownList></td></tr>
           <tr><td>固定回收时间间隔(分钟)： </td><td><asp:TextBox runat="server" ID="eTimeSpanRecy" MaxLength="20" CssClass="site_input" style="width:300px;" /></td></tr>
           <tr><td>最大虚拟内存限制(MB)：   </td><td><asp:TextBox runat="server" ID="emaxMemory" MaxLength="20" CssClass="site_input" style="width:300px;" /></td></tr>
           <tr><td>最大专用内存限制(MB)：   </td><td><asp:TextBox runat="server" ID="emaxPrivateMemory" MaxLength="20" CssClass="site_input" style="width:300px;" /></td></tr>
           <tr><td>默认文档：</td><td><asp:TextBox runat="server" ID="edefaultDoc" CssClass="site_input" Width="300" Height="200" TextMode="MultiLine" /></td></tr>
                <tr><td>操    作：</td>
               <td> <asp:Button runat="server" ID="advSaveBtn" Text="保存高级设置"  CssClass="site_button" OnClick="advSaveBtn_Click"/>
                    <input type="button" id="Button4" onclick="location = location;"  class="site_button" value="重置"/>
                    <input type="button"  value="取消" class="site_button" onclick="disDiv()"/>
               </td></tr>
        </table>
                </div>
                <div id="readOnlyDiv1" class="cswsDiv site_border" style="margin-top:0px;padding-left:10px;padding-top:10px;">
                    <table id="tab1" style="">
           <tr><td>最大CPU使用限制(1/1000)：</td><td><asp:Label runat="server" ID="lmaxCPULimit" /></td></tr>
           <tr><td>发生配置更改时禁止回收： </td><td><asp:Label runat="server" ID="lconfigChange" /></td></tr>
           <tr><td>固定回收时间间隔(分钟)： </td><td><asp:Label runat="server" ID="lTimeSpanRecy" /></td></tr>
           <tr><td>最大虚拟内存限制(MB)：   </td><td><asp:Label runat="server" ID="lmaxMemory" /></td></tr>
           <tr><td>最大专用内存限制(MB)：   </td><td><asp:Label runat="server" ID="lmaxPrivateMemory" /></td></tr>
           <tr><td>默认文档：</td><td><asp:Literal runat="server" ID="ldefaultDoc" /></td></tr>
           <tr><td></td></tr>
                <tr><td>操    作：</td>
               <td> <input type="button" id="Button2" value="编辑" class="site_button" onclick="disDiv()"/>
                    <input runat="server" id="Button3" type="button" value="返回管理界面" class="site_button" onclick="back();"/>
               </td></tr>
        </table>
                </div>
            </div>
        </div>
    </div>
        <div style="float:right;width:65%;margin-left:10px;">
            <div style="margin-top:41px; border:1px solid #ccc; padding-top:10px;">
                <ul style="list-style:none;" id="optionUL">
                  <li><a href="javascript:;" title="Mime设置"><img src="/App_Themes/AdminDefaultTheme/images/System1.png" onclick="disFrame('Mime.aspx?siteName=<%=Server.UrlEncode(siteName) %>');"/></a>
                      <br /><span>Mime设置</span></li>
                  <li><a href="javascript:;" title="虚拟目录"><img src="/App_Themes/AdminDefaultTheme/images/System13.png" onclick="disFrame('VirtualDirectory.aspx?siteName=<%=Server.UrlEncode(siteName) %>');"/></a>
                      <br /><span>虚拟目录</span></li>
                  <li>
                      <a href="javascript:;" title="快云安装"><img src="/App_Themes/AdminDefaultTheme/images/System5.png" onclick="location='SiteCloudSetup.aspx?siteName=<%=Server.UrlEncode(siteName) %>';"/></a>
                      <br /><span>快云安装</span>
                  </li>
                <li><a href="javascript:;" title="绑定订单"><img src="/App_Themes/AdminDefaultTheme/images/System14.png" onclick="disFrame('BountOrder.aspx?siteName=<%=Server.UrlEncode(siteName) %>');"/></a>
                      <br /><span>绑定订单</span></li>
                </ul>
                  <iframe id="mainFrame" onload="frameInit(this);"  style="width:100%;height:626px;display:none;" frameborder=0 scrolling="yes" ></iframe>
                <div class="clearbox"></div>
            </div>
        </div>
    <div class="clearfix"></div>
              <script type="text/javascript">
                  function disFrame(url)
                  {
                      $("#optionUL").hide();
                      $("#mainFrame").attr("src",url).show();
                  }
                  function disOptionDiv()
                  {
                      $("#optionUL").show();
                      $("#mainFrame").hide().attr("src","");//避免闪烁
                  }
              </script>            
        <div id="container" style="width:360px; height:220px; margin:10px;"></div>
    <div style="display:none;">
        <asp:Literal runat="server" ID="hideIPLiteral" />
    </div>
</div><!--mainDiv-->
<!--------------------------------------------------------------------->
<script type="text/javascript">
    //保留小数点后一位
    function Decimal(x) {
        var f_x = parseFloat(x);
        if (isNaN(f_x)) {
            alert('参数为非数字，无法转换！');
            return false;
        }
        var f_x = Math.round(x * 10) / 10;

        return f_x;
    }


    var chart;
    $(document).ready(function () {
        chart = new Highcharts.Chart({
            chart: {
                renderTo: 'container',
                plotBackgroundColor: null,
                plotBorderWidth: null,
                plotShadow: false
            },
            title: {
                text: '<%=siteName%>'
            },
            tooltip: {
                formatter: function () {
                    return '<b>' + this.point.name + '</b>: ' +Decimal(this.percentage) + ' %';
                }
            },
            plotOptions: {
                pie: {
                    allowPointSelect: true,
                    cursor: 'default',
                    dataLabels: {
                        enabled: true,
                        color: '#000000',
                        connectorColor: '#000000',
                        formatter: function () {
                            return '<b>' + this.point.name + '</b>: ' + Decimal(this.percentage) + ' %';
                        }
                    }
                }
            },
            series: [{
                type: 'pie',
                name: 'Browser share',
                data: [<%=piePercent%>]
            }]
        });
        });

</script>
<script type="text/javascript">
        function localCheck(obj)
        {
            if (checkinfo('sitePort', 'Domain', 'PPath', 'siteIP'))
            {
                if(confirm("更改设置,目标网站必须重启，你确定要重启目标网站吗！！"))
                {
                    setTimeout(function () { obj.disabled = true;},50);
                    return true;
                }
                else return false;
            }
            else{
                return false;
            }
        }

        function disDiv()
        {
            $("#CSWSDiv").toggle();
            $("#readOnlyDiv").toggle();
            $("#CSWSDiv1").toggle();
            $("#readOnlyDiv1").toggle();
        }
        $(document).ready(function(){
            $("#readOnlyDiv tr").attr("height","30px");
            $("#readOnlyDiv1 tr").attr("height","30px");
        });

        function newadd() {
            var tr = "";
            tr += "<tr><td>新增绑定：<a href='javascript:' onclick='remove(this)' title='移除'><img src='../../App_Themes/AdminDefaultTheme/images/error.gif' /></a></td><td>";
            tr += "<label style='position:relative;bottom:5px;'>IP：</label><input type='text' name='siteIP'  class='site_input' style='width:275px;'  maxlength='15'  txt='IP不能为空' list='ipList'/><br />";
            tr += "<label style='position:relative;bottom:5px;'>端口：</label>";
            tr += "<input type='text' name='sitePort'  class='site_input' style='width:30px;'  maxlength='6'  txt='端口不能为空' /> ";
            tr += "<label style='position:relative;bottom:5px;'>域名：</label><input type='text' name='Domain' style='width:190px;' class='site_input'  txt='域名不能为空'/>";
            tr += "</td></tr>";
            $("#batTr").after(tr);
        }
        function remove(obj) {
            $(obj).parent().parent().remove();
        }
        function back()
        {
            url = "Default.aspx";
            if (getParam("remote") == "true")
            {
                url += "?remote=true"
            }
            location = url;
        }
    </script>
    <script src="../../dist/js/bootstrap.min.js" type="text/javascript"></script>
</asp:Content> 
