Facter.add(:apache_fact_version) do
  setcode do

    apache2_cmd_result = Facter::Util::Resolution.exec('[ "$( which apache2 2>/dev/null )" != "" ] && apache2 -v | head -n1 |cut -d"/" -f2|awk \'{ print $1 }\'')
    httpd_cmd_result = Facter::Util::Resolution.exec('[ "$( which httpd 2>/dev/null )" != "" ] && httpd -v | head -n1 |cut -d"/" -f2|awk \'{ print $1 }\'')

    if not apache2_cmd_result.empty?
      apache2_cmd_result
    elsif not httpd_cmd_result.empty?
      httpd_cmd_result
    else
      ""
    end
  end
end
