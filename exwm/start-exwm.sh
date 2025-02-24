# set proxy environmental variables
export no_proxy="localhost, 127.0.0.1, 192.168.*.*, .lan"
export http_proxy=""
export https_proxy=""

exec dbus-launch --exit-with-session emacs -mm --debug-init -l ~/.emacs.d/exwm/exwm.el -f exwm-enable

xrdb ~/.emacs.d/exwm/Xresources
