# = Define: apache::module
#
# This define places files and if required extracts files being archives.
# It respects the dependencies between modules and module files and notifies
# the apache service after the files have been placed. 
# this definition requires the puppet module https://github.com/akquinet/puppet-archmngt.git 
#
# == Parameters
# [*source*]
# the absolute path to the source file, can be either a file on the target machine or a file
# from an extra_files directory of the puppet server.
# 
# [*target_dir*]
# directory in which the file shall be placed and if necessary into which it's contents are 
# going to be extracted
# 
# [*module_name*]
# the name of the apache module a file placement is related to. Be aware that apache::module 
# need to be defined or that your reciped contains at least a package snippet with the symbolic name 
# "ApacheModule_{module_name}" 
#
# == Examples
#
# apache::place_module_files { "place_ssl_files": 
#   module_Name => 'ssl',
# 	source => "puppet:///extra_files/ssl_files.zip",
#	target_dir => "/etc/httpd/ssl",
#	files_need_to_be_extracted => true,
# }
define apache::place_module_files ($source,
	$module_name,
	$target_dir,
	$notify_service = true,
	$files_need_to_be_extracted = false,
	$overwrite_existing_files = false) {
	include apache
		
	$manage_service_autorestart = $notify_service ? {
		true => 'Service[apache]',
		default => undef,
	}
	$do_before_extraction = ( $notify_service and $files_need_to_be_extracted )
	$manage_service_autorestart_before_extraction = $do_before_extraction ? {
		true => 'Service[apache]',
		default => undef,
	}
	
	file { "$target_dir" :
			ensure => directory,
			require => Package['apache', "ApacheModule_${module_name}"],
	}
	$file_name_segments = split($source, '[/]')
	## this method is part of the archmngt module
	$target_file = last_element($file_name_segments)
	
	file { "$target_dir/$target_file" :
			ensure => present,
			source => "$source",
			replace => true,
			notify => $manage_service_autorestart_before_extraction,
			require => [Package['apache'], File["$target_dir"]],
	}
	if $files_need_to_be_extracted {
		archmngt::extract { "extract_$source" :
				archive_file => "$target_dir/$target_file",
				target_dir => "$target_dir",
				overwrite => $overwrite_existing_files,
				notify => $manage_service_autorestart,
				require => [File["$target_dir/$target_file"]],
		}
	}
}