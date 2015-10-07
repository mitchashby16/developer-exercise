$(document).ready(function(){

  test("the page will start with all descriptions closed", function() {
    equal($('.description').is(':visible'), false, "Descriptions are not show" );
  });

  test("toggleLink method will close the closest description div", function() {
    $("a:first").click();
    $("a:first").click();
    equal($('.description').is(':visible'), false, "Description is show" );
  });

});
