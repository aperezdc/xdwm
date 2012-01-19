==============
 xdwm-session
==============

----------------------------------
Start XDWM and additional services
----------------------------------

:Author: Adrian Perez <aperez@igalia.com>
:Manual section: 1


SYNOPSIS
========

``xdwm-session``


DESCRIPTION
===========

The ``xdwm-session`` program starts up the XDWM window manager and some
additional convenience services, some of which may be defined by the user.
This command is typically executed by your login manager (either gdm, xdm,
slim...) or from your X startup scripts.

Actually ``xdwm-session`` is *not* a full X11R6-compliant session manager,
but a convenience script to launch additional services and provide a clean
environment to `xdwm(1)`. Therefore, it *will not* manage XSM-compliant
applications despite its name.


ENVIRONMENT
===========

``xdwm-session`` sets a number f environment variables for the use of its
child processes:

``BROWSER``

  If not already defined, ``xdwm-session`` will try to set it to a
  reasonable default value. If no usable browser is detected, the
  variable will be left unset.

``XDWM_DIR``

  Path to a directory (usually inside the user's home directory) in
  which to store transient information related to the session being
  run.

  This directory is used to save the PID files of the services started
  by ``xdwm-session``, sockets and FIFOs used by them. A subdirectory
  called ``log/`` inside it stores the session log.

``DISPLAY``

  The X display being managed.

When sourcing the ``rc`` file (see FILES_ below), it is guaranteed that
the `bash(1)` shell will be used, so its additional features can (and
should!) be used. Plus, the following are available to use:

``service()``

  Function that uses `dmon(8)` to launch and monitor a service. It will
  save a PID file under ``$XDWM_DIR``, and connect the output of the
  process to XDWM's logging FIFO (see FILES_ below). All services started
  using this function will be shut down when the session finishes. The
  arguments to the function should be the application to launch and its
  command line options, *including the ones needed to avoid forking*
  (remember that `dmon(8)` handles the forking itself). For example::

    service /usr/lib/gnome-settings-daemon/gnome-settings-daemon
    service gnome-screensaver --no-daemon

  Note that, if you need to pass options to `dmon(8)`, it is possible
  but you will need to define the service name in the ``S`` variable. For
  example, this will run a task in 10-minute intervals::

    S=cronjob-like-script service --interval 10m cronjob-like-script

  It is even possible to use a service name different from the executable
  program name, passing the ``X`` variable for the executable name. For
  example ``xdwm-session`` itself sets up a clock to be shown in the top
  bar like this::

    S=dwm-status X=sh service --interval 30 \
      sh -c 'xsetroot -name "$(date +%H:%S)"'

  Note that *service()* will skip starting services for which the
  executable program does not exist, thus the need for ``X``.


FILES
=====

``$XDG_CONFIG_DIR/config/xdwm/rc``

  Shell script sourced by ``xdwm-session`` in which the user may define
  extra services to start or environment variables. See the ENVIRONMENT_
  for a description of functions and variables useable from this file.

``$XDG_CONFIG_HOME/xdwm/rc.exit``

  Shell script sourced by ``xdwm-session`` in which the user may set up
  commands to run when closing the session. See the ENVIRONMENT_ section
  for a description of functions and variables useable from this file.

``$XDWM_DIR/log/*``

  Session log. Logs are saved using `drlog(8)` and rotated automatically
  so it is not needed to take care of deleting old ones.

``$XDWM_DIR/log.fifo``

  FIFO which can be used to send messages to the session log.


SEE ALSO
========

`dlog(8)`, `drlog(8)`, `dmon(8)`

