
function grid_rendering() {
    // Now I'm going to try something weird, which seems justified by the nature
    // of our data--I'm only going to plot the lowest-prices 80%.  The upper
    // 20% is often something not really in the data set you are looking at
    // and it messes up the plot.  This should really be under the control
    // of the user, but that will have to wait.
    // In order to do this we will sort on unitPrice, which is probably
    // a good way to present the data anyway.
    transactionData.sort(
        function (a,b) {
            var ret;
            if (parseFloat(a["unitPrice"]) < parseFloat(b["unitPrice"])) {
                ret = 1;
            } else if (parseFloat(a["unitPrice"]) > parseFloat(b["unitPrice"])) {
                ret = -1;
            } else {
                ret = 0;
            }
            return ret;
        });

    var medianValue = medianSortedValues(transactionData);
    medianUnitPrice = (transactionData.length > 0) ? medianValue
        : 0.0;

    var sumOfUnitPrice = 0.0;
    transactionData.forEach(function(d) {
        var x = parseFloat(d["unitPrice"]);
        if (!isNaN(x))
            sumOfUnitPrice += x
        else {
            d["unitPrice"] = "0.0";
        }
    });

   var currentColumn = "score";
   var currentOrderIsAscending = false; 
   sortByColumn(transactionData,currentColumn,currentOrderIsAscending);

    var options = {
        editable: true,
        asyncEditorLoading: false,
        enableCellNavigation: true,
        enableColumnReorder: false
    };


    transactionData.forEach(function (e,i,a) {
        var obj = e;
        e["starred"] = "";
// This randomizes color but keeps the same colors associated with the same 
// field...
        e.color = standardColors[Math.abs(Hashcode.value(e["awardIdIdv"])) % NUM_STANDARD_COLORS];
        data[i] = obj;
    });

    redrawDetailArea(transactionData,0);

    function renderStarredTransactionsInDetailArea() {
	var div = document.getElementById('detailArea');
	div.innerHTML = "";
	data.forEach(function (e) {
            if (e.starred == "Starred") {
		div.innerHTML += renderStyledDetail(e);
	    }
	});
    }

    // Define function used to get the data and sort it.
    function getItem(index) {
	return transactionData[index];
    }
    function getLength() {
	return transactionData.length;
    }
    var colclickcount = 0;


    $("#columnDropdownWrapper").click(function(){
	if ((colclickcount % 2) == 1) {
	    var col = $("#sortColumn").val();
	    currentColumn = col;
	    refreshSort(grid,transactionData,currentColumn,currentOrderIsAscending,currentPage);
	}
	colclickcount++;
    });

    var ordclickcount = 0;
    $("#orderDropdownWrapper").click(function(){
	if ((ordclickcount % 2) == 1) {
	    var ord = $("#sortOrder").val();
            currentOrderIsAscending =  (ord == "asc");
	    refreshSort(grid,transactionData,currentColumn,currentOrderIsAscending,currentPage);
	}
	ordclickcount++;
    });


    $(function () {
	$('#myGrid').innerHTML = "";
	grid = new Slick.Grid("#myGrid", transactionData, columns, options);

	// There's got to be a way to make this more compact!!!
	grid.onSort.subscribe(function (e, args) {

	    var currentSortCol;
	    var isAsc = args.sortAsc;
	    currentSortCol = args.sortCol.field;
	    sortByColumnAndRedraw(transactionData,currentSortCol,isAsc,currentPage);

	    grid.setData(transactionData);
	    grid.invalidateAllRows();
	    grid.render();
	    redrawDetailArea(transactionData,currentPage);
	});
    });

    grid.onClick.subscribe(function (e) {
	var cell = grid.getCellFromEvent(e);
	if (grid.getColumns()[cell.cell].id == "starred") {
            if (!grid.getEditorLock().commitCurrentEdit()) {
		return;
            }
            var states = { "": "Starred", "Starred": ""};
            data[cell.row].starred = states[data[cell.row].starred];
            grid.updateRow(cell.row);
            e.stopPropagation();
	}
    });
}
