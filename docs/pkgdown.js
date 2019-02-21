$(function() {
  $("#sidebar").stick_in_parent({
    offset_top: $("#sidebar").offset().top
  });
  $('body').scrollspy({
    target: '#sidebar'
  });
  $('[data-toggle="tooltip"]').tooltip();

  /* Clipboard --------------------------*/

  function changeTooltipMessage(element, msg) {
    var tooltipOriginalTitle=element.getAttribute('data-original-title');
    element.setAttribute('data-original-title', msg);
    $(element).tooltip('show');
    element.setAttribute('data-original-title', tooltipOriginalTitle);
  }

  if(ClipboardJS.isSupported()) {
      $(document).ready(function() {
        var copyButton = "<button type='button' class='btn btn-primary btn-copy-ex' type = 'submit' title='Copy to clipboard' aria-label='Copy to clipboard' data-toggle='tooltip' data-placement='left auto' data-trigger='hover' data-clipboard-copy><i class='fa fa-copy'></i></button>";

        $(".examples, div.sourceCode").addClass("hasCopyButton");

        // Insert copy buttons:
        $(copyButton).prependTo(".hasCopyButton");

        // Initialize tooltips:
        $('.btn-copy-ex').tooltip({container: 'body'});

        // Initialize clipboard:
        var clipboardBtnCopies = new ClipboardJS('[data-clipboard-copy]', {
          text: function(trigger) {
            return trigger.parentNode.textContent;
          }
        });

        clipboardBtnCopies.on('success', function(e) {
          changeTooltipMessage(e.trigger, 'Copied!');
          e.clearSelection();
        });

        clipboardBtnCopies.on('error', function() {
          changeTooltipMessage(e.trigger,'Press Ctrl+C or Command+C to copy');
        });
      });
  }
});

$(window).scroll(function(){
    if($(window).scrollTop() > 35) {
        $('.navbar').addClass("shrink");
        $('.navbar-brand').addClass("shrink");
        $('.navbar-label').addClass("shrink");
    } else {
        $('.navbar').removeClass("shrink");
        $('.navbar-brand').removeClass("shrink");
        $('.navbar-label').removeClass("shrink");
    }
});
