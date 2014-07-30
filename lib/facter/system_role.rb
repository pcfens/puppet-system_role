if File.exists?('/etc/system_role')
  file = File.open('/etc/system_role', 'rb')
  hostname = file.read
  file.close()
else
  hostname = Facter.value(:hostname)
end
values = /^([-\w]+?)-?(\d*)$/.match(hostname)

Facter.add("cluster_name") do
  setcode do
    unless values[1].nil?
      values[1]
    end
  end
end

Facter.add("node_number") do
  setcode do
    unless values[2].nil?
      values[2]
    end
  end
end
