$(document).ready(function () {
    setActiveMenu();
});

function setActiveMenu() {
     $( ".navbar__list li" ).each(function() {
         $(this).removeClass("active");
     });
     $( ".list-unstyled li" ).each(function() {
         $(this).removeClass("active");
     });
     $('.list-unstyled #menu--introduce').addClass("active");
     $('.navbar__list #menu--introduce	').addClass("active");
 }