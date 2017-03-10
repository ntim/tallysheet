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
//= require bootstrap-sprockets
//= require turbolinks
//= require d3
//= require bootstrapValidator.min
//= require sisyphus.min
//= require_tree .

Array.prototype.unique = function() {
    var a = [],
        l = this.length;
    for (var i = 0; i < l; i++) {
        for (var j = i + 1; j < l; j++)
            if (this[i] === this[j])
                j = ++i;
        a.push(this[i]);
    }
    return a;
};

$(document).on('ready', function() {
    var socket = new WebSocket("ws://" + window.location.host + "/websocket");
    socket.onmessage = function(event) {
        console.log(event);
        if (event.data.length) {
            var data = JSON.parse(event.data);
            // For tallysheet entries
            if (data.tallysheet_entry && data.tallysheet_entry.create) {
                var id = data.tallysheet_entry.create.id;
                var html = '<div class="alert alert-info alert-dismissable-' + id + ' fade in"><button class="close" data-dismiss="alert">×</button>'
                html += 'A new tallysheet entry has just been created.'
                html += '</div>'
                $("#flash").prepend(html);
                setInterval(function() {
                    $('.alert-dismissable-' + id).alert('close');
                }, 5000);
            }
            // For payments
            if (data.payment && data.payment.create) {
                var id = data.payment.create.id;
                var html = '<div class="alert alert-info alert-dismissable-' + id + ' fade in"><button class="close" data-dismiss="alert">×</button>'
                html += 'A payment of ' + data.payment.create.amount.toFixed(2) + ' € has just been made.'
                html += '</div>'
                $("#flash").prepend(html);
                setInterval(function() {
                    $('.alert-dismissable-' + id).alert('close');
                }, 5000);
            }
        }
    };
    // Try to close socket gracefully (not realiably implemented in all browsers).
    $(window).bind('beforeunload', function() {
        socket.close();
        console.log("Websocket closed.");
    });
    $(window).unload(function(){
        socket.close();
        console.log("Websocket closed.");
    });
    // Remember form entries.
    $("form.sisyphus").sisyphus({autoRelease: false, excludeFields: $( "input[type=hidden]" )});
})

$(document).on('turbolinks:load', function() {
	// Fade out flash messages.
	setInterval(function() {
		$('.alert-dismissable').alert('close');
	}, 5000);
	// Active links.
    $('a.active').parent().addClass('active');
    // Form validation.
    $('form')
        .bootstrapValidator({})
        .on('success.form.bv', function(e) {
            // Called when the form is valid

            var $form = $(e.target);
            if ($form.data('remote') && $.rails !== undefined) {
                e.preventDefault();
            }
    });
    // Remember form entries.
    $("form.sisyphus").sisyphus({autoRelease: false});
});

