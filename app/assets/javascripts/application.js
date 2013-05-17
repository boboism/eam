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
//= require_tree .


// bootstrap-datepicker init
fire_datepicker = function() {
  default_options = {
    format: "yyyy-mm-dd",
    weekStart: 1
  };
  $('[data-behavior~=datepicker]').datepicker(default_options);
}

// destroy the fields(
destroy_fields = function(link) {
  // will NOT remove while there's only one left
  var total_size = $(link).closest(".field").parent().find(".field input[type='hidden'][value!='true']").size();
  if(total_size > 1) {
    $(link).prev("input[type='hidden']").val("true");
    $(link).closest(".field").hide();
  }
}

create_fields = function(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g");
  $(link).closest("tr").before(content.replace(regexp, new_id));
  fire_datepicker();
}

// calculate total quantity of transfer
calculate_total_quantity = function(elem) {
  var total_quantity = 0;
  $(elem).closest("tbody").find(".field:has(:hidden[value='false']) input[id$='_quantity']").each(function(index, elem) {
    var qty = $(this).val();
    if(!isNaN(qty) && Number(qty) > 0) {
      total_quantity += Number(qty);
    }
  });
  $(elem).closest("tbody").find(".sub_total .quantity").html(total_quantity);
}

toggle_asset_tabs = function() {
  $("#assetTab a").on("click", function(e) {
    e.preventDefault();
    $(this).tab('show');
  });
}

$(function(){
  fire_datepicker();
  $("a:has(.icon-trash), .create_button").on("click", function() {
    calculate_total_quantity(this);
  });
  
  $("input[id$='_quantity']").on("change", function() {
    calculate_total_quantity(this);
  });

  toggle_asset_tabs();
});
