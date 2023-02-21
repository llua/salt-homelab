{% for directive in ['sendmail_enable', 'sendmail_msp_queue_enable', 'sendmail_submit_enable', 'sendmail_outbound_enable'] %}
set {{ directive }} to NO:
  sysrc.managed:
    - name: "{{directive}}"
    - value: 'NO'
{% endfor %}

stop sendmail service:
  service.dead:
    - name: sendmail
