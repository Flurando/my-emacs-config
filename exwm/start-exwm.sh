# set proxy environmental variables
export no_proxy="localhost, 127.0.0.1, 192.168.*.*, .lan"
export http_proxy="127.0.0.1:8118"
export https_proxy="127.0.0.1:8118"

# disable auto compilation of guile
export GUILE_AUTO_COMPILE=0

exec dbus-launch --exit-with-session emacs -mm --debug-init -l ~/.emacs.d/exwm/exwm.el -f exwm-enable

xrdb ~/.emacs.d/exwm/Xresources
