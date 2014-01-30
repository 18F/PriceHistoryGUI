// These are specific to our result-rendering.

function refreshSort(grid,transactionData,col,ord,currentPage) {
    sortByColumnAndRedraw(transactionData,col,ord,currentPage);
    grid.setData(transactionData);
    grid.invalidateAllRows();
    grid.render();
    redrawDetailArea(transactionData,currentPage);
}


function sortByColumn(transactionData,col,asc) {
    // We need to reset the currentPage when we sort
    var currentSortCol = col;
    var isAsc = asc;
    var stringSort = function(a,b) {
	var ret;
	if (a[currentSortCol] < b[currentSortCol]) {
	    ret = 1;
	} else if (a[currentSortCol] > b[currentSortCol]) {
            ret = -1;
	} else {
            ret = 0;
	}
	if (isAsc) 
	    return -1*ret;
	else 
	    return ret;
   }
    var numberSort = function(a,b) {
	var ret;
	if (parseFloat(a[currentSortCol]) < parseFloat(b[currentSortCol])) {
	    ret = 1;
	} else if (parseFloat(a[currentSortCol]) > parseFloat(b[currentSortCol])) {
            ret = -1;
	} else {
            ret = 0;
	}
	if (isAsc) 
	    return -1*ret;
	else 
	    return ret;
    }
    transactionData.sort(currentSortCol == "unitPrice" || 
			 currentSortCol == "unitsOrdered" ? numberSort : stringSort);
    return transactionData;
}

function sortByColumnAndRedraw(transactionData,col,asc,currentPage) {
    sortByColumn(transactionData,col,asc);
    // I would rather reset the current page, but it is buggy...
    // This is the best that I can do on short notice.
    //  currentPage = 0;
    redrawDetailArea(transactionData,currentPage);
}

function refreshSort(grid,transactionData,col,ord,currentPage) {
    sortByColumnAndRedraw(transactionData,col,ord,currentPage);
    grid.setData(transactionData);
    grid.invalidateAllRows();
    grid.render();
    redrawDetailArea(transactionData,currentPage);
}


// Note that PAGESIZE and SCRATCH_NUMBER are globals here---very ugly!!!

    function redrawDetailArea(transactionData,page,render_delete) {
	var detailAreaDiv = $("#"+'detailArea');
	detailAreaDiv.empty();
	var smallSlice = transactionData.slice(page*PAGESIZE,
Math.min((page+1)*PAGESIZE,transactionData.length));
	smallSlice.forEach(function (e,i,a) {
            detailAreaDiv.append(renderStyledDetail(e,SCRATCH_NUMBER,render_delete));
	    $(document).on( "click", "#scratch"+SCRATCH_NUMBER, detailItemHandler);
	    $("img[delete_id='"+e.p3id+"']").click(function () {
		var content_key = $(this).attr('delete_id');
                var deco = HANDLER_NAMESPACE_OBJECT.portfolio_url;
		var portfolio = PAGE_CONTEXT.portfolio_name;
                 $.post(deco+"/delete_association/"+portfolio+"/"+content_key,
			HANDLER_NAMESPACE_OBJECT.portfolio_post_data,
			HANDLER_NAMESPACE_OBJECT.decoration_deleted_function
                       ).fail(function() { alert("The addition of that record to the content_area portfolio failed."); });

            });
// Ugly....
	    itemDetailAssociation[SCRATCH_NUMBER] = i+page*PAGESIZE;
	    SCRATCH_NUMBER++;
	});

// Now we must make the drag/drop work.
       $( ".droppablerecord" ).droppable({
           tolerance: "touch",
           drop: function(event, ui) {
	       
               var text = ui.draggable.attr('id').substring("draggable-id-".length);
                 var portfolio = isPortfolio(text);
		 var key = $(this).attr('p3id');
                 var deco = (portfolio) ? HANDLER_NAMESPACE_OBJECT.portfolio_url
		                        : HANDLER_NAMESPACE_OBJECT.tag_url;
                 $.post(deco+"/add_record/"+text+"/"+key,
		        function () {
		    $(HANDLER_NAMESPACE_OBJECT.decoration_add_dialog_id).dialog('open');
			}
                       ).fail(function() { alert("The addition of that record to the content_area portfolio failed."); });
           }
	});

       $( ".droppablerecord" ).draggable({ revert: true });

    }
