$(document).ready(function(){
  $('.wrapper').css('height' , $(window).height()- $('.jumbotron').innerHeight()) - $('.breadcrumb').innerHeight();
  $('#enable_hour').change(function() {
    if ($(this).is(':checked')) {
            $('.hour').attr("disabled",false);
        }
    else{
      $('.hour').attr("disabled",true);
    }
  });
})
