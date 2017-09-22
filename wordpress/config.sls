configure wordpress:
  file.managed:
    - name: /var/www/html/wp-config.php
    - source: salt://wordpress/wp-config.php.j2
    - user: apache
    - group: apache
    - template: jinja

get wp manager script:
  file.managed:
    - name: /usr/local/bin/wp
    - user: root
    - group: root
    - mode: 755
    - source: salt://wordpress/wp-cli.phar
    - source_hash: a647367c1e6c34c7357e380515d59e15fbc86fa2
    - reload_modules: True

do install:
  wordpress.installed:
    - path: /var/www/html/
    - user: {{salt.config.get('wordpress:user', 'apache')}}
    - admin_user: {{salt.config.get('wordpress:admin_user', 'wordpress')}}
    - admin_password: "{{salt.grains.get_or_set_hash('wordpress_password')}}"
    - admin_email: "{{salt.config.get('wordpress:admin_email', 'test@example.com')}}"
    - title: "{{salt.config.get('wordpress:title', 'Wordpress')}}"
    - url: "{{salt.config.get('wordpress:url', 'http://localhost.com')}}"
  file.directory:
    - name: /var/www/html
    - user: apache
    - group: apache
    - file_mode: 644
    - dir_mode: 2775
    - recurse:
      - user
      - group
      - mode
