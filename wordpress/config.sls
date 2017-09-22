{% from "wordpress/defaults.yaml" import rawmap with context %}
{%- set config = salt['grains.filter_by'](rawmap, grain='os_family', merge=salt['config.get']('wordpress:lookup')) %}

configure wordpress:
  file.managed:
    - name: /var/www/html/wp-config.php
    - source: salt://wordpress/wp-config.php.j2
    - user: {{config.user}}
    - group: {{config.user}}
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
    - user: {{config.user}}
    - admin_user: {{config.admin_user}}
    - admin_password: "{{config.admin_password}}"
    - admin_email: "{{config.admin_email}}"
    - title: "{{config.title}}"
    - url: "{{config.url}}"

  file.directory:
    - name: /var/www/html
    - user: {{config.user}}
    - group: {{config.user}}
    - file_mode: 644
    - dir_mode: 2775
    - recurse:
      - user
      - group
      - mode
