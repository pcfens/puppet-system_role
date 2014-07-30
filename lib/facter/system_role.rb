if File.exists?('/etc/system_role')
  file = File.open('/etc/system_role', 'rb')
  hostname = file.read
  file.close()
else
  hostname = Facter.value(:hostname)
end
values = /^(?<cluster_name>[-\w]+?)-?(?<node_number>\d*)$/.match(hostname)

Facter.add("cluster_name") do
  setcode do
    unless values[:cluster_name].nil?
      values[:cluster_name]
    end
  end
end

Facter.add("node_number") do
  setcode do
    unless values[:node_number].nil?
      values[:node_number]
    end
  end
end
