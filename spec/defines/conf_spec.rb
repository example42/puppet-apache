require 'spec_helper'

describe 'apache::conf' do
  describe 'on test osfamily' do
    let(:facts) do
      { :osfamily => 'test' }
    end

    context 'with custom content' do
      let(:title) { 'test.conf' }
      let(:params) do
        { 
	  :content => 'my_value',
	}
      end
      it { is_expected.to compile.with_all_deps }
      it { is_expected.to contain_file('/etc/apache/test.conf').with_ensure('present') }
      it { is_expected.to contain_file('/etc/apache/test.conf').with_content('my_value') }
    end

    context 'with custom template and options hash' do
      let(:title) { 'test.conf' }
      let(:params) do
        { 
	  :template => 'apache/rspec/test.conf.erb',
	  :options  => { 'my_key' => 'my_value', 'my_key2' => 'my_value2' },
	}
      end
      it { is_expected.to compile.with_all_deps }
      it { is_expected.to contain_file('/etc/apache/test.conf').with ( {
        :ensure  => 'present',
        :path    => '/etc/apache/test.conf',
        :content => /my_value2/,
      } ) }
    end
  
    context 'with source => test.conf' do
      let(:title) { 'test.conf' }
      let(:params) do
        { 
	  :source => 'puppet:///modules/apache/rspec/test.conf',
	}
      end
      it { is_expected.to compile.with_all_deps }
      it { is_expected.to contain_file('/etc/apache/test.conf').with ( {
        :ensure  => 'present',
        :source  => 'puppet:///modules/apache/rspec/test.conf',
      } ) }
    end
  
  end
  
end
