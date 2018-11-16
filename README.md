srsp.oracle-java for Ansible Galaxy
============

[![Build Status](https://travis-ci.org/srsp/ansible-oracle-java.svg?branch=master)](https://travis-ci.org/srsp/ansible-oracle-java) 

## Summary

Role name in Ansible Galaxy: **[srsp.oracle-java](https://galaxy.ansible.com/srsp/oracle-java/)**

This Ansible role has the following features related to the Oracle JDK:

 - Install the latest version of Oracle JDK 8 or 11.
 - Install the optional Java Cryptography Extensions (JCE). Only for JDK 8, as it is no longer needed for any JDK version > 8.
 - Install for CentOS, Debian/Ubuntu, SUSE, and macOS operating systems.
 
 **Attention:** As of April 2018 older versions of JDKs are no longer available publicly on the Oracle website,but you need an Oracle account to download these. 
 This role
 does not support downloading these old JDKs. **This means, that you can only download the latest version of all JDKs that have not yet reached their EOL with this role!**
 
However you can still use this role to install older versions, if you download them and provide them as pre-downloaded file or via http (just define `java_mirror` accordingly).
 
This role is based on [williamyeh.oracle-java](https://github.com/William-Yeh/ansible-oracle-java), but I wanted more recent Java versions and decided to drop support for older versions.

If you prefer OpenJDK, try alternatives such as [geerlingguy.java](https://galaxy.ansible.com/geerlingguy/java/) or [smola.java](https://galaxy.ansible.com/smola/java/).

## Role Variables

### Mandatory variables

None, but it is strongly advised to set `java_version`. You must set the `java_subversion` for JDKs other than 8.

### JDK 11 

```yaml
- hosts: all

  roles:
    - srsp.oracle-java

  vars:
    - java_version: 11
    - java_subversion: 0.1
```

### JDK 9 / 10

JDK 9 and 10 are only available in one version. If you want to use it, set the following vars and provide it as tarball (see next section):

```yaml
- hosts: all

  roles:
    - srsp.oracle-java

  vars:
    - java_version: 9  # or 10
```

### JDK 8

```yaml
- hosts: all

  roles:
    - srsp.oracle-java

  vars:
    - java_version: 8
```

If you do not define the `java_subversion` for JDK 8, you will get the latest version.


### Optional variables

User-configurable defaults:

```yaml
# Java Version
java_version: 8

# Java Subversion
java_subversion: 191

# Whether to download Java from from Oracle directly
# - oracle: Download from Oracle website on-the-fly.
# - mirror: Download from the URL defined in 'java_mirror'.
# - local: Copies from `{{ playbook_dir }}/files` on the control machine.
java_download_from: oracle

# Depending on the value of 'java_download_from' different things happen here:
# - oracle: You don't need to set it. It is prefilled with the Oracle download mirror.
# - mirror: You need to set it the mirror you want to download from. You need to set the complete URL including the file, like in the example below.
# - local: 'java_mirror' is not used, therefore the value is ignored.
#java_mirror: "https://private-repo.com/java/jdk-8u172-macosx-x64.dmg"
java_mirror: "http://download.oracle.com/otn-pub/java/jdk"

# Remove temporary downloaded files?
java_remove_download: true

# Set $JAVA_HOME?
java_set_java_home: true

# Install JCE?
java_install_jce: false
```

For other configurable options, read `tasks/set-role-variables.yml` file; for example, to see supported `java_version`/`java_subversion` combinations.

### I want to install a JDK which you don't yet support!

No problem! You have to specify the corresponding Java build number in the variables `java_build` and `jdk_tarball_hash` in addition to `java_version` and `java_subversion`, for example:

```yaml
# file: playbook.yml
- hosts: all

  roles:
    - srsp.oracle-java

  vars:
    - java_version: 8
    - java_subversion: 141
    - java_build: 15
    - jdk_tarball_hash: 336fa29ff2bb4ef291e347e091f7f4a7
```


## Usage

### Step 1: Add role

Add role name `srsp.oracle-java` to your playbook file.

### Step 2: Add variables

Set variables in your playbook file.

Simple example:

```yaml
# file: playbook.yml

- hosts: all

  roles:
    - srsp.oracle-java

  vars:
    - java_version: 8
```

### (Optionally) pre-fetch .rpm, .tar.gz or .dmg files

You may want to pre-fetch .rpm, .tar.gz or .dmg files *before the execution of this role*, instead of downloading from Oracle or a mirror

To do this, put the file for your intended system in the `{{ playbook_dir }}/files` directory:

```yaml
# file: playbook-prefetch.yml

- hosts: all

  roles:
    - srsp.oracle-java

  vars:
    - java_version: 8
    - java_download_from: local
```

### If running from the command line

```bash
ansible-playbook --ask-become-pass playbook.yml
```

## License

Licensed under the Apache License V2.0. See the [LICENSE file](LICENSE) for details.
