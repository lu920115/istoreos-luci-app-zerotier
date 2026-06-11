local a, t, e

a = Map("zerotier", translate("ZeroTier"),
	translate("Zerotier is an open source, cross-platform and easy to use virtual LAN") ..
	'<br><span style="color:red">此界面包版本luci-app-zerotier_1.3.2-r4_all.ipk，需要配合插件主程序使用zerotier_1.16.0-r2，github地址：<a href="https://github.com/lu920115/istoreos-luci-app-zerotier" target="_blank">https://github.com/lu920115/istoreos-luci-app-zerotier</a></span>')
a:section(SimpleSection).template  = "zerotier/zerotier_status"

t = a:section(NamedSection, "sample_config", "zerotier")
t.anonymous = true
t.addremove = false

e = t:option(Flag, "enabled", translate("Enabled"))
e.default = 0
e.rmempty=false

e = t:option(Flag, "nat", translate("Auto NAT Clients"), translate("Allow zerotier clients access your LAN network"))
e.default = 0
e.rmempty = false

e = t:option(DummyValue, "opennewwindow" ,
	translate("<input type=\"button\" class=\"cbi-button cbi-button-apply\" value=\"Zerotier.com\" onclick=\"window.open('https://my.zerotier.com/network')\" />"),
	translate("Create or manage your zerotier network, and auth clients who could access"))

-- Self-hosted Controller URL input
e = t:option(Value, "selfhosted_url", translate("Self-hosted Controller URL"))
e.default = "http://192.168.5.88:28000"
e.placeholder = "http://192.168.5.88:28000"
e.rmempty = true

-- SAVE button (event handled in zerotier_status.htm via delegation)
e = t:option(DummyValue, "_save_btn",
	translate([[<input type="button" class="cbi-button cbi-button-save" value="SAVE" id="zt_save_url_btn" style="background:#5b7cf9;color:#fff;border:none;" />]]),
	translate("Click SAVE to temporarily save the URL. You must click Save & Apply at the bottom right to permanently save."))

-- OPEN SELF-HOSTED CONTROLLER button
e = t:option(DummyValue, "_open_btn",
	translate([[<input type="button" class="cbi-button cbi-button-apply" value="OPEN SELF-HOSTED CONTROLLER" id="zt_open_controller_btn" style="background:#5b7cf9;color:#fff;border:none;" />]]),
	translate("Click to open your self-hosted ZeroTier controller management page"))

-- Join Network Section
t = a:section(TypedSection, "join", translate("Join Network"))
t.anonymous = true
t.addremove = true
t.template = "cbi/tblsection"

e = t:option(Flag, "enabled", translate("Enabled"))
e.default = 1

e = t:option(Value, "network", translate("ZeroTier Network ID"))
e.datatype = "and(rangelength(16,16),hexstring)"
e.maxlength = 16
e.size = 16
e.rmempty = false

e = t:option(Flag, "allow_managed", translate("Allow Managed"))
e.default = 1

e = t:option(Flag, "allow_global", translate("Allow Global"))

e = t:option(Flag, "allow_default", translate("Allow Default"))

e = t:option(Flag, "allow_dns", translate("Allow DNS"))

return a
