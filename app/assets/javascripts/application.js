// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.dataTables
//= require foundation
//= require react
//= require react_ujs
//= require components
//= require_tree .
$(function() {
    $(document).foundation();

    function checkTime(i) {
        if (i < 10) {
            i = "0" + i;
        }
        return i;
    }

    function actionTime() {
        var now = new Date();
        var ending = new Date();
        var h = now.getHours();
        var m = now.getMinutes();
        if (m < 25) {
            ending.setHours(h);
            ending.setMinutes(25);
        } else if (m < 30) {
            ending.setHours(h);
            ending.setMinutes(30)
        } else if (m < 55) {
            ending.setHours(h);
            ending.setMinutes(55)
        } else {
            ending.setHours(h + 1)
            ending.setMinutes(0);
        }
        return ending
    }
    
    function updateClass(m) {
        if (m < 2) {
            document.getElementById('time').classList.remove('focus', 'review', 'relax');
            document.getElementById('time').classList.add('commit');
        } else if (m < 23) {
            document.getElementById('time').classList.remove('commit', 'review', 'relax');
            document.getElementById('time').classList.add('focus');
        } else if (m < 25) {
            document.getElementById('time').classList.remove('commit', 'focus', 'relax');
            document.getElementById('time').classList.add('review');
        } else if (m < 30) {
            document.getElementById('time').classList.remove('commit', 'focus', 'review');
            document.getElementById('time').classList.add('relax');
        } else if (m < 32) {
            document.getElementById('time').classList.remove('focus', 'review', 'relax');
            document.getElementById('time').classList.add('commit');
        } else if (m < 53) {
            document.getElementById('time').classList.remove('commit', 'review', 'relax');
            document.getElementById('time').classList.add('focus');
        } else if (m < 55) {
            document.getElementById('time').classList.remove('commit', 'focus', 'relax');
            document.getElementById('time').classList.add('review');
        } else {
            document.getElementById('time').classList.remove('commit', 'focus', 'review');
            document.getElementById('time').classList.add('relax');
        }
    }

    function startTime() {
        var now = new Date();
        var ending = actionTime();
        var delta_time = ending - now;

        var m = now.getMinutes()
        updateClass(now.getMinutes());
        m = ending.getMinutes() - m - 1;

        var s = 60 - now.getSeconds() - 1;
        // add a zero in front of numbers<10
        m = checkTime(m);
        s = checkTime(s);
        document.getElementById('time').innerHTML = m + ":" + s;
        t = setTimeout(function () {
            startTime()
        }, 400);
    }
    startTime();
});
