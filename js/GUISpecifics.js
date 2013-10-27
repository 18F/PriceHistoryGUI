
// Not sure the best way to do this, may want to check with Marty.
function renderCustomField(name,fieldSeparator,value) {
    var html = "";
    html +=      ' <div  class="customField">';
    html +=      ' <span  class="fieldName">';
    html +=  (name in nonStandardFieldDescriptor) ? nonStandardFieldDescriptor[name] : name;
    //    html += name;

    // This could be done with a .css after class, but I'm not sure
    // it is browser compliant...
    html += fieldSeparator;

    html +=      ' </span>';
    html +=      ' <span  class="fieldValue">';
    html += value;
    html +=      ' </span>';
    html +=      '</div>';
    return html;
}

function renderDetailArea(dataRow,i) {
    var fieldseparator = " : ";
    var html = "";
    html +=      ' <div  class="itemDetailArea">';
    html += renderCustomField('Long Description',fieldseparator, dataRow.longDescription || "No Long Description.");
    html += renderCustomField('Vendor',fieldseparator, dataRow.vendor || "No Vendor.");
    html += renderCustomField('Contracting Agency/Office',fieldseparator, dataRow.contractingAgency || "No Agency.");

    // Note this could be done more efficiently, and 
    // we will someday want a list of custom fields for other purposes, but 
    // this is good enough for now...
    for (var k in dataRow) {
        if (!((k in standardFieldDescriptor) || (k in internalFieldLabel))) {
	    var v = dataRow[k];
	    // This is just to see what will happen, I will have to add proper titles later.
            var label = (k in standardFieldDescriptor) ? standardFieldDescriptor[k] : k;
	    html += renderCustomField(label,fieldseparator,v);
	}
    }

    html +=      '</div>';
    return html;
}


function detailItemHandler(e) {
    var num = "itemDetails".length;
    var scratch = $(this).attr('id').substring(num);
    var id = itemDetailAssociation[scratch];
    var expandableSection = $("#expandArea"+scratch);
    if (expandableSection.html().length != 0) {
	expandableSection.empty();
    } else {
	expandableSection.append(renderDetailArea(transactionData[id],id));
    }
}

function renderRow(label,content) {
    var row = "";
    row += "<tr>";
    row += "<td>";
    row += label;
    row += "</td>";
    row += "<td>";
    row += content;
    row += "</td>";
    row += "</tr>";
    return row;
}

function renderStyledDetail(dataRow,scratchNumber) {
    var html = "";
// This is a joke---in fact, we need to put the id here!
    html +=      ' <div p3id="'+dataRow.p3id+'" class="result mydraggable droppablerecord">';
    html +=      '<p class="result-details "><strong> '+dataRow.productDescription.substring(0,60)+' </strong> '+dataRow.longDescription.substring(0,160)+' </p>';
    html +=      '<div class="result-meta">';
    html +=          '<p class="result-unitscost"><strong> $'+numberWithCommas(dataRow.unitPrice)+'</strong> '+numberWithCommas(dataRow.unitsOrdered)+' units</p>';
    html +=          '<p class="result-whenwho">'+dataRow.orderDate+' <strong> '+dataRow.contractingAgency.substring(0,30)+'</strong></p>';
    html +=      '</div>';
    html +=      '<div style="clear:both;"></div>';
    html +=      '<div class="result-smallprint">';
    html +=          '<span class="indicator red" style="background-color:'+dataRow.color+';" ></span>';
    html +=          '<p><strong>Award ID/IDV:</strong> '+dataRow.awardIdIdv+ '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>Vendor:</strong> '+dataRow.vendor.substring(0,50)+'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>PSC:</strong> '+dataRow.psc+ '</p>';
    var itemDetails = "itemDetails"+scratchNumber;
    var expandArea = "expandArea"+scratchNumber;
    html +=          '<span class="result-more">Click for Item Details  <img id="'+itemDetails+'" src="theme/img/display-details.png" /></span>';
    html += '<span id="'+expandArea+'"></span>';
    html +=          '<div style="clear:both;"></div>';
    html +=      '</div>';
    return html;
}
