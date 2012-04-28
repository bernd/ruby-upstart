Upstart D-Bus
-------------

The Upstart init daemon contains a D-Bus server which exports several services
to the system bus. That means Upstart can be controlled and inspected with any
program that uses D-Bus bindings. (and has the needed permissions!)

It is available on the system bus with the name **com.ubuntu.Upstart**.

If the D-Bus system daemon is not available, it is possible to open a private
D-Bus connection to the Upstart daemon via the
`unix:abstract=/com/ubuntu/upstart` socket address. This requires superuser
privileges! See [the Upstart wiki](http://upstart.ubuntu.com/wiki/DBusInterface)
for more details.

The [d-feet](http://live.gnome.org/DFeet) application can be used to inspect
the "live" D-Bus status on your or a remote machine. It was used to write
the following Upstart D-Bus object descriptions.

Object Paths
------------

# Manager Object - /com/ubuntu/Upstart

## Interface com.ubuntu.Upstart0\_6

**Methods**

* EmitEvent(String name, Array[String] env, Boolean wait)
* GetAllJobs() => (Array[ObjectPath] jobs)
* GetJobByName(String name) => (ObjectPath job)
* ReloadConfiguration()

**Properties**

* String log\_priority
* String version

**Signals**

* JobAdded(ObjectPath job)
* JobRemoved(ObjectPath job)

# Job Object - /com/ubuntu/Upstart/jobs/<name>

## Interface com.ubuntu.Upstart0\_6.Job

**Methods**

* GetAllInstances() => (Array[ObjectPath] instances)
* GetInstance(Array[String env]) => (ObjectPath instance)
* GetInstanceByName(String name) => (ObjectPath instance)
* Restart(Array[String] env, Boolean wait) => (ObjectPath instance)
* Start(Array[String] env, Boolean wait) => (ObjectPath instance)
* Stop(Array[String] env, Boolean wait)

**Properties**

* String author
* String description
* String name
* String version

**Signals**

* InstanceAdded(ObjectPath instance)
* InstanceRemoved(ObjectPath instance)

# Instance Object - /com/ubuntu/Upstart/jobs/<name>/<instance>

## Interface com.ubuntu.Upstart0\_6.Instance

**Methods**

* Restart(Boolean wait)
* Start(Boolean wait)
* Stop(Boolean wait)

**Properties**

* Array[Struct[String, Int32]] processes
* String goal
* String name
* String state
