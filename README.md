upstart
=======

A Ruby library to inspect and control the
[Ubuntu Upstart](http://upstart.ubuntu.com/cookbook/) daemon.

> Upstart is an event-based replacement for the `/sbin/init` daemon which
> handles starting of tasks and services during boot, stopping them during
> shutdown and supervising them while the system is running.

The library is written in pure Ruby and uses
[ruby-dbus](https://github.com/mvidner/ruby-dbus/) to communicate with
Upstart's D-Bus interface.

WARNING
-------

There is no code yet!

Features
--------

* List and inspect jobs.
* Inspect and control job instances.
* Handle events for manager, job and job instance objects.

Installation
------------

The library is available as a gem on http://rubygems.org/.

    $ gem install upstart

Usage
-----

```ruby
require 'upstart'

manager = Upstart::Manager.new
manager.reload # Reload configuration. (needs superuser privileges!)

version = manager.version # "init (upstart 1.5)"

job = manager.job('doesnotexist') # #<Upstart::MissingJob:0x0000 exists=false>
job = manager.job('cron') # #<Upstart::Job:0x0000 name='cron'>

manager.jobs.each do |job|
  job.inspect # #<Upstart::Job:0x0000 name='cron'>
end

manager.on(:job_added) do |job|
  job.inspect # #<Upstart::Job:0x0000 name='cron'>
end

instance = job.instance('i1') # #<Upstart::JobInstance:0x0000 name='i1'>

# Might require superuser privileges.
instance.restart
instance.start
instance.stop

job.instances.each do |instance|
  instance.inspect # #<Upstart::JobInstance:0x0000 name='_'>

  instance.name # "_"
  instance.goal # "start"
  instance.state # "running"
end
```


License
-------

Copyright (c) 2012 Bernd Ahlers. See LICENSE.txt for further details. (MIT)
