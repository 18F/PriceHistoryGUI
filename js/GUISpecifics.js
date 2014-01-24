
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

    return html;
}


function detailItemHandler(e) {
    var num = "scratch".length;
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

/* The design of the result is:
result , comprised of result-top, and result-bottom, and I will put result-detail in middle
result-top will be result-left and result-right.  Result-right will float right.
result-bottom has three areas result-bottom agency, result-bottom vehicle, and result-botom vendor.  This will be spans, with widths set
in percentages.
*/

function renderAgency(dataRow) {
    var html = "";
    html += '<div class="result-agency">';
    html += '<div class="agency-name">' + ((dataRow.contractingAgency) ? dataRow.contractingAgency.substring(0,30) : "") +"</div>";
    html += '<div>' + dataRow.orderDate +"</div>";
    html += '</div>\n';
    return html;
}
function renderVehicle(dataRow) {
    var html = "";
    html += '<div class="result-vehicle">'+dataRow.awardIdIdv+'</div>\n';
    return html;
}
function renderVendor(dataRow) {
    var html = "";
    html += '<div class="result-vendor">'+((dataRow.vendor) ? dataRow.vendor.substring(0,50) : "") +'</div>\n';
    return html;
}

function renderResultBottom(dataRow) {
    var html = "";
    html += '<div class="result-bottom">\n';
    html += renderAgency(dataRow);
    html += renderVehicle(dataRow);
    html += renderVendor(dataRow);
    html += '</div>\n';
    return html;
}

function renderResultLeft(dataRow) {
   var html = "";
    html += '<div class="result-left">\n';
    html += '<div class="result-short-desc">' + ((dataRow.productDescription) ? dataRow.productDescription.substring(0,60) : "") +"</div>";
    html += '<div class="result-long-desc">' + ((dataRow.longDescription) ? dataRow.longDescription.substring(0,160) : "") +"</div>";
    html += '</div>\n';
    return html;
}

function renderResultRight(dataRow,transactionId) {
   var html = "";
    html += '<div class="result-right">\n';
    html += '<div class="droppablerecord" id="'+transactionId+'"><img  title="Drag and drop on a portfolio" class="draghandle" alt="Drag Handle" src="./theme/img/icn_list.svg"></div>';
    html += '<div class="result-cost"><span class="result-cost-glyph">$</span><span class="result-cost-number">'+numberWithCommas(dataRow.unitPrice) +"</span></div>";
    html += '<div class="result-units">'+numberWithCommas(dataRow.unitsOrdered)+' Units</div>';
    if (PAGE_CONTEXT.render_transaction_delete) {
	html += '<img delete_id="'+transactionId+'" src="./theme/img/gnome_window_close.png" alt="delete" width="40px" height="40px">';
    }
    html += '</div>\n';
    return html;
}

function renderResultTop(dataRow,transactionId) {
   var html = "";
    html += '<div class="result-top">\n';
    html += renderResultLeft(dataRow);
    html += renderResultRight(dataRow,transactionId);
    html += '</div>\n';
    return html;
}

function renderExpandArea(dataRow,scratchNumber) {
   var html = "";
    html +=      '<div style="clear:both;"></div>';
    var expandArea = "expandArea"+scratchNumber;
    html += '<span id="'+expandArea+'"></span>';
    html +=          '<div style="clear:both;"></div>';
    return html;
}

function renderStyledDetail(dataRow,scratchNumber) {
    var html = "";
    html += '<div class="result droppablerecord" id="scratch'+scratchNumber+'" p3id="'+dataRow.p3id+'">\n';
    html += renderResultTop(dataRow,dataRow.p3id);
    html += renderExpandArea(dataRow,scratchNumber);
    html += renderResultBottom(dataRow);
    html += '</div>\n';
    return html;
}
