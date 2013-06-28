nginx:
    pkg:
        - installed
    service:
        - running        
        - watch:
            - file: /var/www/html/index.html
            - file: /etc/nginx/sites-enabled/default
pkgs:
    pkg.installed:
        - pkgs:
            - vim
            - curl
            - python
            - screen
            - git


python_pkgs:
    pkg.installed:
        - pkgs:
            - python-pip
            - python-dev
            - build-essential

pyrax:
    pip:
        - installed
        - name:  pyrax
    require:
        - pkg: python-pip

/var/www/html/index.html:
    file.managed:
    - source: salt://index.html.jinga
    - mode: 644
    - template: jinja
    - require:
        - pkg: nginx

/etc/nginx/sites-enabled/default:
    file.managed:
        - source: salt://default
        - mode: 644
