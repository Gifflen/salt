#Installing nginx
#configuring it to start on boot and reload if the speicified files are edited.
nginx:
    pkg:
        - installed
    service:
        - running        
        - watch:
            - file: /var/www/html/index.html
            - file: /etc/nginx/sites-enabled/default

#Installaing required packages
base_pkgs:
    pkg.installed:
        - pkgs:
            - vim
            - curl
            - python
            - screen
            - git
            - python-pip
            - python-dev
            - build-essential

#Installing pyrax. Requiring the python package list above.
pyrax_install:
    pip.installed:
        - name: pyrax
        - require:
            - pkg: base_pkgs

#Setting up the required index file.
#Using Jinga and Pillar to drop in required data. 
/var/www/html/index.html:
    file.managed:
    - source: salt://index.html.jinga
    - mode: 644
    - template: jinja
    - require:
        - pkg: nginx

#Dropping in base default host config to set pages in nginx
/etc/nginx/sites-enabled/default:
    file.managed:
        - source: salt://default
        - mode: 644
