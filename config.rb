
dir_data '/tmp/temp-containers/'
prefix 'temp-'
image_prefix ''
container_prefix ''
service_prefix ''


server 'mysql' do |s|

  s.build = {
     'build_type' => 'none',
     "base_image" => {"name" => "mysql", "repository" => "mysql", "tag" => "5.7.15" },
  }

  s.docker = {
       #"command"=> "",
       'volumes' => [
           ['data','/var/lib/mysql']
       ],
       'links' => [],
       'run_env'=>[
           ['MYSQL_ROOT_PASSWORD', 'mypass']
       ],

       'run_options'=>'',
  }

  s.attributes = { }

end




server 'nginx' do |s|

  s.build = {
      'build_type' => 'none',
      "base_image" => { "name" => "nginx", "repository" => "nginx", "tag" => "1.10" },
  }


  s.provision = {  }


  s.docker = {
      'command' => "",

      'volumes' => [
          ['./files/nginx.conf', '/etc/nginx/nginx.conf'],
          #['sites-enabled', '/etc/nginx/sites-enabled/'],
          #['sites-available', '/etc/nginx/sites-available/'],

          ['html', '/usr/share/nginx/html'],
          ['log', '/var/log/nginx/'],
      ],
      'links' => [
          ['mysql', 'mysql']
      ],
      'run_env'=>[
          ['NGINX_HOST', 'mydomain.com']

      ],

      'run_extra_options'=>'',
      'run_options'=>'',
  }

  s.attributes = {
      'hosts'=> [
          ['mysql', 'mysql']
      ],

  }

end


