import os

import testinfra.utils.ansible_runner

testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ['MOLECULE_INVENTORY_FILE']).get_hosts('all')


def test_java(host):

    assert host.exists("java")

    if (host.system_info.distribution != "opensuse-leap"):
        assert host.exists("javac")
        assert host.exists("jar")
        assert host.exists("keytool")

    assert host.run_test("java -version")
