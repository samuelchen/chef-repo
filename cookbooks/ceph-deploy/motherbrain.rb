stack_order do
  bootstrap 'ceph::all-in-one'
  bootstrap 'ceph::setup-mons'
  bootstrap 'ceph::setup-osds'
  bootstrap 'ceph::setup-admin'
  bootstrap 'ceph::setup-mds'
end

component 'ceph' do
  description "ceph cookbook application"

  group 'all-in-one' do
    recipe 'ceph-deploy::default'
    recipe 'ceph-deploy::mons'
    recipe 'ceph-deploy::osds'
    recipe 'ceph-deploy::admin'
    recipe 'ceph-deploy::mds'
  end

  group 'setup-osds' do
    recipe 'ceph-deploy::osds'
  end

  group 'setup-mons' do
    recipe 'ceph-deploy::default'
    recipe 'ceph-deploy::mons'
  end

  group 'setup-admin' do
    recipe 'ceph-deploy::admin'
  end

  group 'setup-mds' do
    recipe 'ceph-deploy::mds'
  end
end
