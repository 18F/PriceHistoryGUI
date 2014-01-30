// These strings really need to transferred to the server
// In order for us to have proper abstraction and language translation    

var standardCommodities = {
    // CPU seems to requie both 7020 and 7025!  This 
    // is why commoditype could end up being a problem for us!
    All: '*',
    CPU: '*702*',
    Software: '*7030*',
    // DANGER!  HACK!
    // Note: the FedBid data has IT supplies lists under 7045.
    // The reality is we need a separate icon for that.  I will 
    // have to deal with that later..for now, I want to reach
    // the OS2 data...
    Supplies: '*7510*',
    Punchcards: '*7040*',
    // Not sure this is correct for Configuration....
    Configuration: '*7010*',
    MiniMicro: '*7042*',
    Component: '*7050*'
};


// This should really be read via an AJAX call to all it to be independent of 
// Prices Paid...That is a step to getting open-source involvement.
var standardFieldDescriptor = [];
standardFieldDescriptor["score"] = "Query Relevance";
standardFieldDescriptor["unitPrice"] = "Unit Price";
standardFieldDescriptor["unitsOrdered"] = "Units Ordered";
standardFieldDescriptor["orderDate"] = "Date";
standardFieldDescriptor["vendor"] = "Vendor";
standardFieldDescriptor["productDescription"] = "Product Description";
standardFieldDescriptor["longDescription"] = "Long Description";
standardFieldDescriptor["contractingAgency"] = "Contracting Agency";
standardFieldDescriptor["awardIdIdv"] = "Award ID/IDV";
standardFieldDescriptor["commodityType"] = "Commodity Type";
standardFieldDescriptor["psc"] = "PSC";

var nonStandardFieldDescriptor = [];
nonStandardFieldDescriptor["dataSource"] = "Data Source";


// What I really want to do here is to cycle through a palette of 16 colors.
// There is no reason not to use whatever jqplot uses, although I don't 
// want to become dependent on it here.
var standardColors = [];
standardColors[0] =  'aqua';
standardColors[1] =   'black';
standardColors[2] =   'blue';
standardColors[3] =   'fuchsia';
standardColors[4] =   'gray';
standardColors[5] =   'green';
standardColors[6] =   'lime'; 
standardColors[7] =  'maroon';
standardColors[8] =   'navy';
standardColors[9] =   'olive'; 
standardColors[10] =  'orange';
standardColors[11] =   'purple';
standardColors[12] =   'red';
standardColors[13] =   'silver';
standardColors[14] =   'teal';
// standardColors[15] =   'white';
standardColors[15] =   'yellow';

var NUM_STANDARD_COLORS = 16;


// This should come from the server!!!
var transactionColumns = [
    {id: "unitPrice", name: standardFieldDescriptor["unitPrice"], field: "unitPrice", width: 100},
    {id: "unitsOrdered", name: standardFieldDescriptor["unitsOrdered"], field: "unitsOrdered", width: 60},
    {id: "orderDate", name: standardFieldDescriptor["orderDate"], field: "orderDate", width: 60},
    {id: "vendor", name: standardFieldDescriptor["vendor"], field: "vendor", width: 200},
    {id: "productDescription", name: standardFieldDescriptor["productDescription"], field: "productDescription", width: 400},
    {id: "longDescription", name: standardFieldDescriptor["longDescription"], field: "longDescription", width: 400},
    {id: "contractingAgency", name: standardFieldDescriptor["contractingAgency"], field: "contractingAgency",
     width: 200},
    {id: "awardIdIdv", name: standardFieldDescriptor["awardIdIdv"], field: "awardIdIdv", width: 100},
    {id: "commodityType", name: standardFieldDescriptor["commodityType"], field: "commodityType", width: 100},
    {id: "psc", name: standardFieldDescriptor["psc"], field: "psc", width: 80},
    {id: "dataSource", name: nonStandardFieldDescriptor["dataSource"], field: "dataSource", width: 150},
    {id: "score", name: standardFieldDescriptor["score"], field: "score", width: 100}
];
//    var controlColumns = [ {id: "starred",name: "Starred", field: "starred",width: 40 } ];
var controlColumns = [];  
var columns = controlColumns.concat(transactionColumns);

// Now I attempt to make every column sortable
columns.forEach(function (c) {
    c.sortable = true;
});    
