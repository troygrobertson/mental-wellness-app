# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
	$("tr[data-link]").click (e) ->
		if e.target.innerHTML not in ["Edit","Update","New Appointment","Accept Patient","Reject Patient","Close Appointment"]
			window.location =  $(this).data("link")
