local a, t, e

a = Map("zerotier", translate("ZeroTier"),
	translate("Zerotier is an open source, cross-platform and easy to use virtual LAN"))
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

-- Self-hosted Controller Section (moved before Join Network)
e = t:option(Value, "selfhosted_url", translate("Self-hosted Controller URL"))
e.placeholder = "http://192.168.5.88:28000"
e.default = "http://192.168.5.88:28000"
e.rmempty = true

e = t:option(DummyValue, "save_selfhosted", 
	translate("<input type=\"button\" class=\"cbi-button cbi-button-save\" value=\"SAVE\" onclick=\"var el=document.querySelector('input[name=\\'cbid.zerotier.sample_config.selfhosted_url\\']'); if(!el){el=document.getElementById('cbid.zerotier.sample_config.selfhosted_url');} var url=el?el.value:''; if(!url){url='http://192.168.5.88:28000';} localStorage.setItem('zt_selfhosted_url',url); alert('URL saved: '+url);\" />"),
	translate("Click SAVE to save the self-hosted controller URL"))

e = t:option(DummyValue, "selfhosted", 
	translate("<input type=\"button\" class=\"cbi-button cbi-button-apply\" value=\"OPEN SELF-HOSTED CONTROLLER\" onclick=\"var url=localStorage.getItem('zt_selfhosted_url'); if(!url){var el=document.querySelector('input[name=\\'cbid.zerotier.sample_config.selfhosted_url\\']'); if(!el){el=document.getElementById('cbid.zerotier.sample_config.selfhosted_url');} url=el?el.value:'http://192.168.5.88:28000';} window.open(url);\" />"),
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
