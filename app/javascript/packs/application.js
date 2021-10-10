// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()  //I always comment out
require("@rails/activestorage").start()
require("channels")
require('jquery') //Add this


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

window.jQuery = $;
window.$ = $;
global.$ = jQuery

import 'bootstrap';
import * as bootstrap from 'bootstrap';
import './application.scss';
import '../stylesheets/custom.css';

import "@fortawesome/fontawesome-free/js/all";

import flatpickr from "flatpickr"
require("flatpickr/dist/flatpickr.min.css")

document.addEventListener("turbolinks:load", () => {
    var dt = new Date();
    dt.setMinutes( dt.getMinutes() + 30 );
    flatpickr("[data-behavior='flatpickr']", {
        enableTime: true,
        altInput: true,
        altFormat: "F j, Y G:i K",
        dateFormat: "Y-m-d H:i",
        defaultDate: dt,
        allowInput: true,
        onOpen: function(selectedDates, dateStr, instance) {
            $(instance.altInput).prop('readonly', true);
        },
        onClose: function(selectedDates, dateStr, instance) {
            $(instance.altInput).prop('readonly', false);
            $(instance.altInput).blur();
        }
    })
})


import 'select2'
import 'select2/dist/css/select2.css'
$(document).ready(function() {
    $('.select2').select2();
});

