require 'spec_helper'

describe 'apache' do
  describe 'on test osfamily' do
    let(:facts) do
      { :osfamily => 'test' }
    end
    context 'with default options' do
      it { is_expected.to compile.with_all_deps }
      it { is_expected.to contain_service('apache').with_ensure('running') }
      it { is_expected.to contain_package('apache').with_ensure('present') }
      it { is_expected.to have_package_resource_count(1) }
      it { is_expected.to have_service_resource_count(1) }
      it { is_expected.to have_file_resource_count(0) }
      it { is_expected.to have_class_count(2) }
    end
  
    context 'with ensure => absent' do
      let(:params) do
        { :ensure => 'absent' }
      end
      it { is_expected.to compile.with_all_deps }
      it { is_expected.to contain_service('apache').with_ensure('stopped') }
      it { is_expected.to contain_package('apache').with_ensure('absent') }
    end
  
    context 'with install_class => ""' do
      let(:params) do
        { :install_class => '' }
      end
      it { is_expected.to have_package_resource_count(0) }
      it { is_expected.to have_service_resource_count(0) }
      it { is_expected.to have_file_resource_count(0) }
      it { is_expected.to have_class_count(1) }
    end
  
    context 'with install_class => "::apache::install::package"' do
      let(:params) do
        { :install_class => '::apache::install::package' }
      end
      it { is_expected.to have_package_resource_count(1) }
      it { is_expected.to have_file_resource_count(0) }
      it { is_expected.to have_class_count(2) }
      it { is_expected.to contain_class('apache::install::package') }
    end
  
    context 'with custom settings' do
      let(:params) do
        { :settings => { 'package_name' => 'custom_apache' , 'service_name' => 'custom_apache'} }
      end
      it { is_expected.to contain_service('custom_apache').with_ensure('running') }
      it { is_expected.to contain_package('custom_apache').with_ensure('present') }
    end
  
  end
end
