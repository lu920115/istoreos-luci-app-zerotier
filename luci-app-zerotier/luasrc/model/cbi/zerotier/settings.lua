a = Map("zerotier")
a.title = translate("ZeroTier")
a.description = translate("Zerotier is an open source, cross-platform and easy to use virtual LAN")

a:section(SimpleSection).template  = "zerotier/zerotier_status"

t = a:section(NamedSection, "sample_config", "zerotier")
t.anonymous = true
t.addremove = false

e = t:option(Flag, "enabled", translate("Enable"))
e.default = 0
e.rmempty = false

e = t:option(DynamicList, "join", translate('ZeroTier Network ID'))
e.password = true
e.rmempty = false

e = t:option(Flag, "nat", translate("Auto NAT Clients"))
e.description = translate("Allow zerotier clients access your LAN network")
e.default = 0
e.rmempty = false

e = t:option(DummyValue, "opennewwindow", translate("<input type=\"button\" class=\"cbi-button cbi-button-apply\" value=\"Zerotier.com\" onclick=\"window.open('https://my.zerotier.com/network')\" />"))
e.description = translate("Create or manage your zerotier network, and auth clients who could access")

e = t:option(Value, "selfhosted_url", translate("Self-hosted Controller URL"))
e.placeholder = "http://192.168.5.88:28000"
e.description = translate("Enter your self-hosted ZeroTier controller URL, then click the button below to open it")
e.rmempty = true

e = t:option(DummyValue, "selfhosted", translate("<input type=\"button\" class=\"cbi-button cbi-button-apply\" value=\"Open Self-hosted Controller\" onclick=\"var url=document.getElementById('cbid.zerotier.sample_config.selfhosted_url').value||'http://192.168.5.88:28000';window.open(url)\" />"))
e.description = translate("Click to open your self-hosted ZeroTier controller management page")

return a
