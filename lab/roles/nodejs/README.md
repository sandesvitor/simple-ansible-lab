Node Js
=========

An nodejs process that provides an simple API for the application (express)

Requirements
------------

nodejs
npm
pm2

Example Playbook
----------------

Applied, in this first step, to the webservers (in the future, the API should have it's own vm)

```yml
    - hosts: webservers
      roles:
         - nodejs
```

License
-------

BSD