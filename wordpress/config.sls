configure wordpress:
  file.managed:
    - name: /var/www/html/wp-config.php
    - source: salt://wordpress/wp-config.php.j2
    - template: jinja

do install:
  file.managed:
    - name: /usr/local/bin/wp
    - user: root
    - group: root
    - mode: 755
    - source: salt://wordpress/wp-cli.phar
    - source_hash: a647367c1e6c34c7357e380515d59e15fbc86fa2
    - reload_modules: True

  wordpress.installed:
    - path: /var/www/html/
    - user: {{salt['config.get']('wordpress:user', 'apache')}}
    - admin_user: {{salt['config.get']('wordpress:user', 'gtmanfred')}}
    - admin_password: "{{salt['grains.get_or_set_hash']('wordpress:password')}}"
    - admin_email: "daniel@gtmanfred.com"
    - title: "GtManfred's Blog"
    - url: "http://localhost"
