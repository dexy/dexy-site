		$(function() { 
        $('ul.sf-menu').superfish({ 
            autoArrows:  true
        }); 
    }); 
		

/*-----------------------------------------------------------------------------------*/
/* Tabs
/*-----------------------------------------------------------------------------------*/
    if(jQuery() .tabs) {	 
		$( "#tabs" ).tabs().addClass( "ui-tabs-vertical ui-helper-clearfix" );
		$( "#tabs li" ).removeClass( "ui-corner-top" ).addClass( "ui-corner-left" );
		$( "#tabs" ).tabs({ fx: { opacity: 'toggle' } });
	};
	
/*-----------------------------------------------------------------------------------*/
/* Pretty Photo
/*-----------------------------------------------------------------------------------*/
	
	$(function(){
	   $("a[rel^='prettyPhoto']").prettyPhoto({
			animation_speed: 'fast', /* fast/slow/normal */
			slideshow: 5000, /* false OR interval time in ms */
			autoplay_slideshow: false, /* true/false */
			opacity: 0.80, /* Value between 0 and 1 */
			show_title: true, /* true/false */
			allow_resize: true, /* Resize the photos bigger than viewport. true/false */
			default_width: 500,
			default_height: 344,
			counter_separator_label: '/', /* The separator for the gallery counter 1 "of" 2 */
			theme: 'pp_default', /* light_rounded / dark_rounded / light_square / dark_square / facebook */
			horizontal_padding: 20, /* The padding on each side of the picture */
			hideflash: false, /* Hides all the flash object on a page, set to TRUE if flash appears over prettyPhoto */
			wmode: 'opaque', /* Set the flash wmode attribute */
			autoplay: true, /* Automatically start videos: True/False */
			modal: false, /* If set to true, only the close button will close the window */
			deeplinking: true, /* Allow prettyPhoto to update the url to enable deeplinking. */
			overlay_gallery: true, /* If set to true, a gallery will overlay the fullscreen image on mouse over */
			keyboard_shortcuts: true, /* Set to false if you open forms inside prettyPhoto */
			changepicturecallback: function(){}, /* Called everytime an item is shown/changed */
			callback: function(){}, /* Called when prettyPhoto is closed */
			ie6_fallback: true
			});
	});
	
	
/*-----------------------------------------------------------------------------------*/
/* Hover Effects
/*-----------------------------------------------------------------------------------*/

     function hover_overlay() {
        
        jQuery('.hover img, .image-grid .hover, .hover img.alignleft, .hover img.alignright').hover( function() {
            jQuery(this).stop().animate({opacity : 0.8}, 1000);
        }, function() {
            jQuery(this).stop().animate({opacity : 1}, 1000);
        });
    }
    
    hover_overlay();

/*-----------------------------------------------------------------------------------*/
/* Galleriffic Slider
/*-----------------------------------------------------------------------------------*/
	if(jQuery() .galleriffic) {
				// We only want these styles applied when javascript is enabled
				$('div.content').css('display', 'block');

				// Initially set opacity on thumbs and add
				// additional styling for hover effect on thumbs
				var onMouseOutOpacity = 0.67;
				$('#thumbs ul.thumbs li, div.navigation a.pageLink').opacityrollover({
					mouseOutOpacity:   onMouseOutOpacity,
					mouseOverOpacity:  1.0,
					fadeSpeed:         'fast',
					exemptionSelector: '.selected'
				});
				
				// Initialize Advanced Galleriffic Gallery
				var gallery = $('#thumbs').galleriffic({
					delay:                     2500,
					numThumbs:                 3,
					preloadAhead:              3,
					enableTopPager:            false,
					enableBottomPager:         false,
					imageContainerSel:         '#slideshow',
					controlsContainerSel:      '#controls',
					captionContainerSel:       '#caption',
					loadingContainerSel:       '#loading',
					renderSSControls:          true,
					renderNavControls:         true,
					playLinkText:              'Play Slideshow',
					pauseLinkText:             'Pause Slideshow',
					prevLinkText:              '&lsaquo; Previous Photo',
					nextLinkText:              'Next Photo &rsaquo;',
					nextPageLinkText:          'Next &rsaquo;',
					prevPageLinkText:          '&lsaquo; Prev',
					enableHistory:             true,
					autoStart:                 false,
					syncTransitions:           true,
					defaultTransitionDuration: 1500,
					onSlideChange:             function(prevIndex, nextIndex) {
						// 'this' refers to the gallery, which is an extension of $('#thumbs')
						this.find('ul.thumbs').children()
							.eq(prevIndex).fadeTo('fast', onMouseOutOpacity).end()
							.eq(nextIndex).fadeTo('fast', 1.0);

						// Update the photo index display
						this.$captionContainer.find('div.photo-index')
							.html('Photo '+ (nextIndex+1) +' of '+ this.data.length);
					},
					onPageTransitionOut:       function(callback) {
						this.fadeTo('fast', 0.0, callback);
					},
					onPageTransitionIn:        function() {
						var prevPageLink = this.find('a.prev').css('visibility', 'hidden');
						var nextPageLink = this.find('a.next').css('visibility', 'hidden');
						
						// Show appropriate next / prev page links
						if (this.displayedPage > 0)
							prevPageLink.css('visibility', 'visible');

						var lastPage = this.getNumPages() - 1;
						if (this.displayedPage < lastPage)
							nextPageLink.css('visibility', 'visible');

						this.fadeTo('fast', 1.0);
					}
				});

				/**************** Event handlers for custom next / prev page links **********************/

				gallery.find('a.prev').click(function(e) {
					gallery.previousPage();
					e.preventDefault();
				});

				gallery.find('a.next').click(function(e) {
					gallery.nextPage();
					e.preventDefault();
				});

				/****************************************************************************************/

				/**** Functions to support integration of galleriffic with the jquery.history plugin ****/

				// PageLoad function
				// This function is called when:
				// 1. after calling $.historyInit();
				// 2. after calling $.historyLoad();
				// 3. after pushing "Go Back" button of a browser
				function pageload(hash) {
					// alert("pageload: " + hash);
					// hash doesn't contain the first # character.
					if(hash) {
						$.galleriffic.gotoImage(hash);
					} else {
						gallery.gotoIndex(0);
					}
				}

				// Initialize history plugin.
				// The callback is called at once by present location.hash. 
				$.historyInit(pageload, "advanced.html");

				// set onlick event for buttons using the jQuery 1.3 live method
				$("a[rel='history']").live('click', function(e) {
					if (e.button != 0) return true;

					var hash = this.href;
					hash = hash.replace(/^.*#/, '');

					// moves to a new page. 
					// pageload is called at once. 
					// hash don't contain "#", "?"
					$.historyLoad(hash);

					return false;
				});
			};
				
 
 
/*-----------------------------------------------------------------------------------*/
/* Quicksand
/*-----------------------------------------------------------------------------------*/
    
(function($) {
        $.fn.sorted = function(customOptions) {
            var options = {
                reversed: false,
                by: function(a) {
                    return a.text();
                }
            };
            $.extend(options, customOptions);

            $data = $(this);
            arr = $data.get();
            arr.sort(function(a, b) {

                var valA = options.by($(a));
                var valB = options.by($(b));
                if (options.reversed) {
                    return (valA < valB) ? 1 : (valA > valB) ? -1 : 0;              
                } else {        
                    return (valA < valB) ? -1 : (valA > valB) ? 1 : 0;  
                }
            });
            return $(arr);
        };

    })(jQuery);

    $(function() {

      var read_button = function(class_names) {
        var r = {
          selected: false,
          type: 0
        };
        for (var i=0; i < class_names.length; i++) {
          if (class_names[i].indexOf('selected-') == 0) {
            r.selected = true;
          }
          if (class_names[i].indexOf('segment-') == 0) {
            r.segment = class_names[i].split('-')[1];
          }
        };
        return r;
      };

      var determine_sort = function($buttons) {
        var $selected = $buttons.parent().filter('[class*="selected-"]');
        return $selected.find('a').attr('data-value');
      };

      var determine_kind = function($buttons) {
        var $selected = $buttons.parent().filter('[class*="selected-"]');
        return $selected.find('a').attr('data-value');
      };

      var $preferences = {
        duration: 800,
        easing: 'easeInOutQuad',
        adjustHeight: false
      };

      var $list = $('#list');
      var $data = $list.clone();

      var $controls = $('ul.splitter ul');

      $controls.each(function(i) {

        var $control = $(this);
        var $buttons = $control.find('a');

        $buttons.bind('click', function(e) {

          var $button = $(this);
          var $button_container = $button.parent();
          var button_properties = read_button($button_container.attr('class').split(' '));      
          var selected = button_properties.selected;
          var button_segment = button_properties.segment;

          if (!selected) {

            $buttons.parent().removeClass('selected-0').removeClass('selected-1').removeClass('selected-2').removeClass('selected-3').removeClass('selected-4').removeClass('selected-5').removeClass('selected-6');
            $button_container.addClass('selected-' + button_segment);

            var sorting_type = determine_sort($controls.eq(1).find('a'));
            var sorting_kind = determine_kind($controls.eq(0).find('a'));

            if (sorting_kind == 'all') {
              var $filtered_data = $data.find('li');
            } else {
              var $filtered_data = $data.find('li.' + sorting_kind);
            }

            if (sorting_type == 'size') {
              var $sorted_data = $filtered_data.sorted({
                by: function(v) {
                  return parseFloat($(v).find('span.colore').text());
                }
              });
            } else {
              var $sorted_data = $filtered_data.sorted({
                by: function(v) {
                  return $(v).find('strong').text().toLowerCase();
                }
              });
            }

            $list.quicksand($sorted_data, $preferences, function(){
						 hover_overlay();
						 $("a[rel^='prettyPhoto']").prettyPhoto();
			});

          }

          e.preventDefault();
        });

      }); 

      var high_performance = true;  
      var $performance_container = $('#performance-toggle');
      var $original_html = $performance_container.html();

      $performance_container.find('a').live('click', function(e) {
        if (high_performance) {
          $preferences.useScaling = false;
          $performance_container.html('CSS3 scaling turned off. Try the demo again. <a href="#toggle">Reverse</a>.');
          high_performance = false;
        } else {
          $preferences.useScaling = true;
          $performance_container.html($original_html);
          high_performance = true;
        }
        e.preventDefault();
      });
    });

/*-----------------------------------------------------------------------------------*/
/* Coda Slider
/*-----------------------------------------------------------------------------------*/
if(jQuery() .codaSlider){ 	
       $('#coda-slider-1').codaSlider({
           dynamicArrows: false,
           dynamicTabs: false
       });
   };
if(jQuery() .codaSlider){ 	
       $('#coda-slider-2').codaSlider({
			dynamicTabsPosition: 'bottom',
			dynamicArrows: false
       });
   };

 
/*-----------------------------------------------------------------------------------*/
/* Form Validation
/*-----------------------------------------------------------------------------------*/
 
$(document).ready(function(){
	$("#contactform").validate();
	$("#quoteform").validate();
	$("#quickform").validate();
});

       