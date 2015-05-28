osds = node['ceph']['osds']

osds.each do |osd, items|
  if items['ipaddr'] == node['ipaddress']
    directory items['device'] do
      recursive true
      action :delete
    end
    directory items['device'] do
      owner "root"
      group "root"
      action :create
    end
  end
end
