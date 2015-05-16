require 'spec_helper'

describe 'functions::line' do

  let(:title) { 'line_rspec' }

  let(:params) { {:file => '/foo/bar/baz', :line => 'test_line'} }

  it do
    should contain_exec("/bin/echo 'test_line' >> '/foo/bar/baz'").with({
      'unless' => "/bin/grep -qFx 'test_line' '/foo/bar/baz'",
      'refreshonly' => false
    })
  end

  context 'with ensure => absent' do

    let(:params) { {:file => '/foo/bar/baz', :line => 'test_line', :ensure => 'absent'} }

     it do
       should contain_exec("/usr/bin/perl -ni -e 'print unless /^\\Qtest_line\\E\$/' '/foo/bar/baz'").with({
         'onlyif' => "/bin/grep -qFx 'test_line' '/foo/bar/baz'",
         'refreshonly' => false
       })
     end
  end

end
