$(document).ready(function () {
  // Add smooth scrolling to index nav links
  $(".indexNav").on('click', function (event) {
    if (this.hash !== "") {
      event.preventDefault();
      var hash = this.hash;
      // Using jQuery's animate() method to add smooth page scroll
      $('html, body').animate({
        scrollTop: $(hash).offset().top
      }, 800)
    };
    $("#navDropDown").removeClass("show");
  });
  // Scrolling to contact nav links
  $(".contactNav").on('click', function (event) {
    if (this.hash !== "") {
      // Prevent default anchor click behavior
      event.preventDefault();
      // Store hash
      var hash = this.hash;
      var href;
      href = "index.html" + hash;
      window.location.href = href
      $('html, body').animate({
        scrollTop: $(hash).offset().top
      });
    };
  });
});