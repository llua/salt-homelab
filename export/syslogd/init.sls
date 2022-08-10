ensure syslogd is running:
  service.running:
    - name: syslogd

manage /etc/rc.conf.d/syslogd:
  file.managed:
    - name: /etc/rc.conf.d/syslogd
    - mode: 640
    - user: root
    - group: wheel
    - content: |
      {{ salt['slsutil.banner']() }}
      syslogd_flags="-sO rfc5424"
    - listen_in:
      - service: syslogd
