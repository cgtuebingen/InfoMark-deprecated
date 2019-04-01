# Deprecation Warning

> This repo is deprecated. 
> We will publish our rewrite in Go+ELM soon.

The InfoMark application is based on:
* RubyOnRails as a webframework
* Resque for background processing of testing code submissions and zipping files for tutors
* Redis for communications between the web-app and Resque
* Docker for sandboxing the test environment of submissions

![screenshot](https://cgtuebingen.github.io/InfoMark/assets/img/profile.PNG)

Please refer to the infomark-worker repository.

Environment-Variables
-----------------------

To configure infomark we need to setup several environment variables:

* INFOMARK_DATADIR, this is the actual place where the submissions and uploads are stored
* INFOMARK_DOMAIN_NAME, will be the sender for outgoing mails
* INFOMARK_MAIL_REGEX, we just allowed to register accounts using mails matching 
`/\A[^@]+@(?:student\.|)uni-tuebingen.de/`
* SECRET_KEY, for running the devise-gem and pre-compile assets

HowTo Run - Locally
-----------------------

First clone this repository to your place by

```console
user@host $ git clone https://github.com/cgtuebingen/InfoMark.git
```

This package is shipped with a docker-compose configuration which allows you to use this app locally. Warning: This local version inside docker-compose uses Webrick which is single-threaded and not for production! Please refer to our Capistrano file for zero-deploy via Capistrano.

To build everything locally just run

```console
user@host $ cd InfoMark/server
user@host $ sudo docker-compose build
user@host $ sudo docker-compose run web rake db:create
user@host $ sudo docker-compose run web rake db:migrate
user@host $ sudo docker-compose run web rake db:seed
```

Now everything is ready

```console
user@host $ sudo docker-compose up
```

Now open http://localhost:3000 your web-browser. You should see the login-area. By default we add an user with login-credentials:

```
email: root@root.com
passwd: toor
```
