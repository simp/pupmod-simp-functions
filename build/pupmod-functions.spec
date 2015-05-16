Summary: Functions Puppet Module
Name: pupmod-functions
Version: 2.1.0
Release: 4
License: Apache License, Version 2.0
Group: Applications/System
Source: %{name}-%{version}-%{release}.tar.gz
Buildroot: %{_tmppath}/%{name}-%{version}-%{release}-buildroot
Requires: puppetlabs-stdlib
Requires: puppet >= 3.3.0
Requires: pupmod-common >= 4.2.0-5
Buildarch: noarch
Requires: simp-bootstrap >= 4.2.0
Obsoletes: pupmod-functions-test

Prefix:"/etc/puppet/environments/simp/modules"

%description
This Puppet module provides useful common functions.

%prep
%setup -q

%build

%install
[ "%{buildroot}" != "/" ] && rm -rf %{buildroot}

mkdir -p %{buildroot}/%{prefix}/functions

dirs='files lib manifests templates'
for dir in $dirs; do
  test -d $dir && cp -r $dir %{buildroot}/%{prefix}/functions
done

%clean
[ "%{buildroot}" != "/" ] && rm -rf %{buildroot}

mkdir -p %{buildroot}/%{prefix}/functions

%files
%defattr(0640,root,puppet,0750)
/etc/puppet/environments/simp/modules/functions

%post
#!/bin/sh

if [ -d /etc/puppet/environments/simp/modules/functions/plugins ]; then
  /bin/mv /etc/puppet/environments/simp/modules/functions/plugins /etc/puppet/environments/simp/modules/functions/plugins.bak
fi

%postun
# Post uninstall stuff

%changelog
* Fri Jan 16 2015 Trevor Vaughan <tvaughan@onyxpoint.com> - 2.1.0-4
- Changed puppet-server requirement to puppet

* Mon Aug 18 2014 Nick Markowski <nmarkowski@keywcorp.com> - 2.1.0-3
- Init_ulimit sysv provider had a typo.  value => value=(should).

* Thu Jul 31 2014 Trevor Vaughan <tvaughan@onyxpoint.com> - 2.1.0-2
- Removed the now obsolete telinit_q exec. The 'runlevel' native type
  should be used instead.
- Added new custom providers for init_ulimit that work with both sysv
  and systemd systems.
- Removed the associated test RPM since we're moving to Beaker from
  our internal mit framework.

* Wed Jul 02 2014 Kendall Moore <kmoore@keywcorp.com> - 2.1.0-1Alpha2
- Continued work on refactoring init_ulimit.

* Fri Jun 20 2014 Trevor Vaughan <tvaughan@onyxpoint.com> - 2.1.0-1Alpha
- Started to refactor init_ulimit

* Wed Jan 15 2014 Nick Markowski <nmarkowski@keywcorp.com> - 2.1.0-0
- Added rspec tests

* Fri Jan 10 2014 Kendall Moore <kmoore@keywcorp.com> - 2.1.0-0
- Updated module for puppet3/hiera and lint tests

* Fri Jul 26 2013 Trevor Vaughan <tvaughan@onyxpoint.com> - 2.0.0-9
- Updated append_if_no_such_line and prepend_if_no_such_line to use
  simp_file_line and support the 'deconflict' parameter.

* Thu Jun 27 2013 Trevor Vaughan <tvaughan@onyxpoint.com> - 2.0.0-8
- Updated the init_ulimit function to account for SELinux attributes.
  This turns out to be quite important. Bug reports were filed with
  Puppet Labs regarding the fact that their functions don't carry
  through SELinux context.

* Fri Feb 01 2013 Maintenace
2.0.0-7
- Created Cucumber tests for the functions module to ensure that all of the basic
  functions work correctly

* Tue Nov 27 2012 Trevor Vaughan <tvaughan@onyxpoint.com> - 2.0.0-6
- Updated to ensure that modifying the open files setting would only update to
  the maximum allowed by the system since 'unlimited' is not an allowed value.
- Added functionality to restart the service that had been modified by the init
  script should the service be in the catalog.
- Need to add full upstart support.

* Fri Aug 10 2012 Trevor Vaughan <tvaughan@onyxpoint.com> - 2.0.0-5
- Added a custom type 'init_ulimit' for managing the ulimit settings in init
  scripts. The old function::init_mod_open_files and function::init_mod_nice
  should no longer be used.

* Wed Apr 11 2012 Trevor Vaughan <tvaughan@onyxpoint.com> - 2.0.0-4
- Added a custom type 'prepend_file_line' to add lines to the top of a file.
- 'Append_if_no_such_line' now just calls the Puppet Labs 'file_line' stdlib.
- Moved mit-tests to /usr/share/simp...
- Updated pp files to better meet Puppet's recommended style guide.

* Fri Mar 02 2012 Trevor Vaughan <tvaughan@onyxpoint.com> - 2.0.0-3
- Improved test stubs.

* Mon Dec 26 2011 Trevor Vaughan <tvaughan@onyxpoint.com> - 2.0.0-2
- Updated the spec file to not require a separate file list.

* Mon Oct 10 2011 Trevor Vaughan <tvaughan@onyxpoint.com> - 2.0.0-1
- Modified all multi-line exec statements to act as defined on a single line to
  address bugs in puppet 2.7.5

* Tue Jan 11 2011 Trevor Vaughan <tvaughan@onyxpoint.com> - 2.0.0-0
- Refactored for SIMP-2.0.0-alpha release
- Scoped all functions to be 'functions::<function name>'

* Tue Oct 26 2010 Maintenance - 1-1
- Converting all spec files to check for directories prior to copy.

* Fri May 20 2010 Trevor Vaughan <tvaughan@onyxpoint.com> - 1.0-0
- Refactor and doc update.
- Actually imported the functions globally so that everything in the world didn't break.
- This is equivalent to what was happening before.

* Fri May 07 2010 Trevor Vaughan <tvaughan@onyxpoint.com> - 0.1-10
- Added the functions:
  - init_mod_nice -> Change the nice level within init scripts.
  - renice -> Change the nice level of running processes.

* Fri Feb 05 2010 Trevor Vaughan <tvaughan@onyxpoint.com> - 0.1-5
- Fixed the incorrect \'s in 'init_mod_open_files' and accounted for some
  potential problem cases.

* Thu Jan 14 2010 Trevor Vaughan <tvaughan@onyxpoint.com> - 0.1-4
- Added a new function 'init_mod_open_files' that modifies the maximum number of
  open files in an init script.

* Tue Dec 15 2009 Trevor Vaughan <tvaughan@onyxpoint.com> - 0.1-3
- Line manipulation functions now create the file if it doesn't exist.

* Mon Nov 02 2009 Trevor Vaughan <tvaughan@onyxpoint.com> - 0.1-2
- Added an unless statement to make append_if_no_such_line a bit more
  streamlined.
