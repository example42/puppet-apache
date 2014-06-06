require "#{File.join(File.dirname(__FILE__),'..','spec_helper.rb')}"

describe 'apache::vhost' do

  let(:title) { 'apache::vhost' }
  let(:node) { 'rspec.example42.com' }
  let(:facts) { { :arch => 'i386' , :operatingsystem => 'redhat' } }

  describe 'Test apache::virthost on redhat with default port' do
    it 'should include apache::dotconf' do
      should contain_apache__dotconf('00-NameVirtualHost').with_content(/NameVirtualHost \*:80/)
    end
  end

  describe 'Test apache::virthost on redhat with other port' do
    let(:params) { { 'port' =>  '42' } }
    it 'should include apache::dotconf' do
      should contain_apache__listen('42').with_namevirtualhost('*')
    end
  end

  describe 'Test apache::virthost on redhat with other port and specific ip' do
    let(:params) { { 'port' =>  '42', 'ip_addr' => '10.42.42.42' } }
    it 'should include apache::dotconf' do
      should contain_apache__listen('42').with_namevirtualhost('10.42.42.42')
    end
  end
end

