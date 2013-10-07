// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require bootstrap-datepicker/core
//= require bootstrap-datepicker/locales/bootstrap-datepicker.zh-CN
//= require jasny-bootstrap
//= require select2
//= require select2_locale_zh-CN
//= require_tree .

// make table rows of index page can link to each record show page.
var linkify_record_container = function() {
  $("table.my-table tbody tr td:not(:last-child):not(:has(:checkbox))").on("click", function(){
    var href = $(this).parent().attr("href");
    if(href != "") {
      window.location.href = href;
    }
  });
}

// check or uncheck all records  in gam table
var check_or_uncheck_all_records_in_my_table = function() {
  $("table.my-table thead tr th input[type='checkbox']").on("change", function() {
    var check_status = $(this).is(':checked');
    $(this).parents("table.my-table").find("tbody tr td input[type='checkbox']").attr("checked", check_status);
  });
}

// bootstrap-datepicker init
var fire_datepicker = function() {
  default_options = {
    format: "yyyy-mm-dd",
    weekStart: 1
  };
  $('[data-behavior~=datepicker]').datepicker(default_options);
}

// destroy the fields(
var destroy_fields = function(link) {
  // will NOT remove while there's only one left
  var total_size = $(link).closest(".field").parent().find(".field input[type='hidden'][id$='_destroy'][value!='true']").size();
  if(total_size > 1) {
    $(link).prev("input[type='hidden']").val("true");
    $(link).closest(".field").hide();
  }
}

var create_fields = function(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g");
  $(link).closest("tr").before(content.replace(regexp, new_id));
  fire_datepicker();
  fire_select2();
  fire_calculate_asset_transfer_total_quantity();
}

// calculate total quantity of transfer
var calculate_total_quantity = function(elem) {
  var total_quantity = 0;
  $(elem).closest("tbody").find(".field:has(:hidden[value='false']) input[id$='_quantity']").each(function(index, elem) {
    var qty = $(this).val();
    if(!isNaN(qty) && Number(qty) > 0) {
      total_quantity += Number(qty);
    }
  });
  $(elem).closest("tbody").find(".sub_total .quantity").html(total_quantity);
}

var fire_calculate_asset_transfer_total_quantity = function() {
  $("input[id$='_quantity']").on("change", function() {
    calculate_total_quantity(this);
  });
}

var toggle_asset_tabs = function() {
  $("#assetTab a").on("click", function(e) {
    e.preventDefault();
    $(this).tab('show');
  });
}

var toggle_tooltip = function() {
  $("[data-toggle=tooltip]").tooltip();
}

var hightlight_menu = function() {
  var main_path = window.location.pathname.split(/\//);
  while(main_path.length > 0) {
    var current_path = main_path.join('/');
    if ($(".nav.nav-list li:has(a[href$='"+current_path+"']):first").length > 0) {
      $(".nav.nav-list li:has(a[href$='"+current_path+"']):first").addClass("active");
      break;
    }
    main_path.pop();
  }
}

var fire_select2 = function() {
  $("select.select").select2();
}

$(function(){
  fire_datepicker();
  $("a:has(.icon-trash), .create_button").on("click", function() {
    calculate_total_quantity(this);
  });
  fire_calculate_asset_transfer_total_quantity();
  linkify_record_container();
  toggle_tooltip();
  check_or_uncheck_all_records_in_my_table();
  toggle_asset_tabs();
  hightlight_menu();
  fire_select2();
});
