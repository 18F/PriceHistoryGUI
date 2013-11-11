
function initialize_plot(data,medianUnitPrice) {
    var plotData = [[]];
    var i = 0;
    var thingToPlot = data.forEach(function (e) {
	// we don't want to plot it if it is more than 4 times the median price, 
	// as it is probably erroneous

	if ((data.length < 15) || (medianUnitPrice <= 100.0) || (e.unitPrice < (medianUnitPrice * 4.0))) {
	    var newArray = [];

	    newArray[0] = e.orderDate;
	    newArray[1] = Math.ceil(e.unitPrice * 100) / 100;
	    newArray[2] = Math.sqrt(Math.abs(e.unitsOrdered));
	    newArray[3] = {
		label: e.vendor,
		color:  e.color
	    };
	    plotData[0].push(newArray);
	}
    });

    $('#chartdiv').empty();

// It seems we no longer need this!
//    if (isIE8orLower) {
    if (false) {
      $('#chartdiv').append("<div style='width: 700px; color: red; margin: 20px'>The graph not supported on Internet Explorer less than Version 9.  You appear to be using version "+ieversion+", or your browser is using that as its rendering mode for some reason. If you need the graph, upgrade, or use a different browser, or change the document mode.<\div>");
    } else {
    var plot1b = $.jqplot('chartdiv', plotData, {
	title: 'Unit Prices',
	seriesDefaults:{
            renderer: $.jqplot.BubbleRenderer,
            rendererOptions: {
		bubbleAlpha: 0.6,
		highlightAlpha: 0.8,
		showLabels: false
            },
            shadow: true,
            shadowAlpha: 0.05
        },
	axes:{
            xaxis:{
		renderer:$.jqplot.DateAxisRenderer,
		label: '<span color: black;>Color denotes Vehicle.</span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span>Bubble size denotes number of units.</span>'
            },
            yaxis:{
		label: 'Dollars',
		tickOptions:{
		    formatString:'$%.2f'
		}
            }
	},
	highlighter: {
            show: true,
            sizeAdjust: 7.5
	},
	cursor: {
            show: true,
            tooltipLocation:'sw'
	}
    }
			 );
    }


    // Now bind function to the highlight event to show the tooltip
    // and highlight the row in the legend.
    $('#chartdiv').bind('jqplotDataHighlight',
			function (ev, seriesIndex, pointIndex, data, radius) {   
			    var chart_left = $('#chartdiv').offset().left,
			    chart_top = $('#chartdiv').offset().top,
			    x = plot1b.axes.xaxis.u2p(data[0]),  // convert x axis unita to pixels
			    y = plot1b.axes.yaxis.u2p(data[1]);  // convert y axis units to pixels
			    var color = 'rgb(50%,50%,100%)';
			    $('#tooltip1b').css({left:chart_left+x+radius+5, top:chart_top+y});
			    
			    $('#tooltip1b').html('<span style="font-size:14px;font-weight:bold;color: ' + color + ';">' + data[3] + '</span><br />' + 'x: ' + data[0] +
						 '<br />' + 'y: ' + data[1] + '<br />' + 'r: ' + data[2]);
			    
			    $('#tooltip1b').show();
			});
    // Bind a function to the unhighlight event to clean up after highlighting.
    $('#chartdiv').bind('jqplotDataUnhighlight',
			function (ev, seriesIndex, pointIndex, data) {
			    $('#tooltip1b').empty();
			    $('#tooltip1b').hide();
			});
}
