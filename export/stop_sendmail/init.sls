{% for directive in ['sendmail_enable', 'sendmail_msp_queue_enable', 'sendmail_submit_enable'] %}
set {{ directive }} to NO:
  cmd.run:
    - name: "sysrc {{directive}}=NO"
    - shell: /bin/sh
    - unless: 'test "$(sysrc -n {{directive}})" = NO'
{% endfor %}

stop sendmail service:
  service.dead:
    - name: sendmail
