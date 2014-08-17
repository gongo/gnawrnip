$(function() {
    $('.screenshot.animation').each(function() {
        var slide = $(this).find('.slides').cycle({
            timeout: 1000,
            autoHeight: "calc",
            pager: $(this).find('div.nav .pager')
        });

        var nav = $(this).find('div.nav');
        var playButton  = nav.find('.play');
        var pauseButton = nav.find('.pause');
        var prevButton  = nav.find('.prev');
        var nextButton  = nav.find('.next');

        var setPauseManipulate = function() {
            playButton.show();
            pauseButton.hide();
            prevButton.show();
            nextButton.show();
        };

        var setPlayManipulate = function() {
            playButton.hide();
            pauseButton.show();
            prevButton.hide();
            nextButton.hide();
        };

        playButton.click(function() { slide.cycle('resume'); });
        pauseButton.click(function() { slide.cycle('pause'); });
        prevButton.click(function() { slide.cycle('prev'); });
        nextButton.click(function() { slide.cycle('next'); });

        setPlayManipulate();

        slide.on('cycle-pager-activated', function(event, opts) {
            slide.cycle('pause');
        });

        slide.on('cycle-paused', function(event, opts) {
            setPauseManipulate();
        });

        slide.on('cycle-resumed', function(event, opts) {
            setPlayManipulate();
        });
    });
});
