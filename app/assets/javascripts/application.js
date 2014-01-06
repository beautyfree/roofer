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
//= require jquery-fileupload/index
//= require jquery_nested_form
//= require_tree .

// tooltips
$(document).ready(function(){
    $('[data-toggle~="tooltip"]').tooltip({
        container: 'body'
    })
});

// Modals (updated from [data-toggle~="modal"])
$(document).on('click.modal.data-api', '[data-toggle!="modal"][data-toggle~="modal"]', function (e) {
    var $this = $(this)
        , href = $this.attr('href')
        , $target = $($this.attr('data-target') || (href && href.replace(/.*(?=#[^\s]+$)/, ''))) //strip for ie7
        , option = $target.data('modal') ? 'toggle' : $.extend({ remote:!/#/.test(href) && href }, $target.data(), $this.data())

    e.preventDefault()

    $target
        .modal(option)
        .one('hide', function () {
            $this.focus()
        })
})


/*
var cityCenterData={'moskva':{lon:37.620375,lat:55.754977,zoom:11,name:'Москва',id:32},'sankt-peterburg':{lon:30.311106,lat:59.933976,zoom:13,name:'Санкт-Петербург',id:38},'novosibirsk':{lon:82.929874,lat:55.029291,zoom:13,name:'Новосибирск',id:1},'ekaterinburg':{lon:60.622362,lat:56.839037,zoom:13,name:'Екатеринбург',id:9},'nnovgorod':{lon:44.010896,lat:56.325762,zoom:13,name:'Нижний Новгород',id:19},'samara':{lon:50.135427,lat:53.206593,zoom:13,name:'Самара',id:18},'kazan':{lon:49.110685,lat:55.799438,zoom:13,name:'Казань',id:21},'omsk':{lon:73.417934,lat:54.973073,zoom:13,name:'Омск',id:2},'chelyabinsk':{lon:61.396944,lat:55.171472,zoom:13,name:'Челябинск',id:15},'rostov':{lon:39.774616,lat:47.248286,zoom:13,name:'Ростов-на-Дону',id:24},'ufa':{lon:55.962389,lat:54.739789,zoom:13,name:'Уфа',id:17},'volgograd':{lon:44.522698,lat:48.707928,zoom:13,name:'Волгоград',id:33},'permy':{lon:56.251051,lat:58.014455,zoom:13,name:'Пермь',id:16},'krasnoyarsk':{lon:92.913115,lat:56.04226,zoom:13,name:'Красноярск',id:7},'almaty':{lon:76.928224,lat:43.237414,zoom:13,name:'Алматы',id:67},'odessa':{lon:30.7451,lat:46.466709,zoom:13,name:'Одесса',id:14},'vladivostok':{lon:131.887618,lat:43.115366,zoom:13,name:'Владивосток',id:25}};;$(function(){$('#address_address').focus();var map;var projectId=32;var projectCentroid=[55.753466,37.62017];var projectZoomLevel=11;var projectName='Москва';if(cityCenterData[detectedCity]){projectId=cityCenterData[detectedCity].id;projectCentroid=[cityCenterData[detectedCity].lat,cityCenterData[detectedCity].lon];projectZoomLevel=cityCenterData[detectedCity].zoom;projectName=cityCenterData[detectedCity].name;$('#show_cityselect').text(projectName);}
*/