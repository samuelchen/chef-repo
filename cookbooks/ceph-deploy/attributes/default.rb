default["ceph"]["clusterdir"] = "/root/mycluster"
default["ceph"]["osddir"] = "/var/local/osd"
# temp value
default["ceph"]["osddirnum"] = 0

default["ceph"]["config"]["auth_service_required"] = "cephx"
default["ceph"]["config"]["filestore_xattr_use_omap"] = true
default["ceph"]["config"]["auth_client_required"] = "cephx"
default["ceph"]["config"]["auth_cluster_required"] = "cephx"
default["ceph"]["config"]["osd_pool_default_size"] = 2
default["ceph"]["config"]["osd_pool_default_pg_num"] = 128
default["ceph"]["config"]["osd_pool_default_pgp_num"] = 128

# components
# default["ceph"]["cluster"]["mons"] = "10.111.5.159"
default["ceph"]["osds"] = {}
