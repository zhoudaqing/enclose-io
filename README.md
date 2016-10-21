# Enclose.IO

Enclose.IO 
is a cloud-based service that creates a single executable out of your node.js application
for Windows, Linux and Mac OS X. It freezes your app code with the Node.js interpreter and all module dependencies,
making your app ready to be used out-of-the-box.

http://enclose.io/

[![Build Status](https://travis-ci.org/enclose-io/enclose-io.svg)](https://travis-ci.org/enclose-io/enclose-io)
[![Code Climate](https://codeclimate.com/github/enclose-io/enclose-io/badges/gpa.svg)](https://codeclimate.com/github/enclose-io/enclose-io)
[![codecov.io](https://codecov.io/github/enclose-io/enclose-io/coverage.svg?branch=master)](https://codecov.io/github/enclose-io/enclose-io?branch=master)

## Installation

### Linux (x86_64)

Suppose that you were using CentOS release 5.8 on a x86_64 machine,
then execute the following commands to set up the environment.

    gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
    \curl -sSL https://get.rvm.io | bash -s stable
    sudo yum install libyaml-devel readline-devel zlib-devel libffi-devel openssl-devel sqlite-devel
    rvm install ruby
    gem update --system
    gem install bundler
    
    curl -sL http://dl.fedoraproject.org/pub/epel/5/x86_64/epel-release-5-4.noarch.rpm -o /tmp/epel-release-5-4.noarch.rpm
    sudo rpm -Uvh /tmp/epel-release-5-4.noarch.rpm
    sudo curl -sL http://linuxsoft.cern.ch/cern/devtoolset/slc5-devtoolset.repo -o /etc/yum.repos.d/slc5-devtoolset.repo
    sudo rpm --import http://ftp.scientificlinux.org/linux/scientific/5x/x86_64/RPM-GPG-KEYs/RPM-GPG-KEY-cern
    sudo yum install devtoolset-2
    
    scl enable devtoolset-2 bash
    echo source /opt/rh/devtoolset-2/enable >> ~/.bash_profile

### Mac OS X

### Windows

## License

Enclose.IO is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

