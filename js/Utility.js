

// WARNING!!! This is needed to make forEach work on IE8.
// This is from the Mozilla site.  I have no idea if this 
// is a better idea than replaces forEach'es everywhere or not.
    if (!Array.prototype.forEach) {
	Array.prototype.forEach = function (fn, scope) {
            'use strict';
            var i, len;
            for (i = 0, len = this.length; i < len; ++i) {
		if (i in this) {
                    fn.call(scope, this[i], i, this);
		}
            }
	};
    }


function numberWithCommas(x) {
    var parts = x.toString().split(".");
    parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    return parts.join(".");
}


function medianSortedValues(values) { 
    if (values.length != 0) {
	var half = Math.floor(values.length/2);
	if(values.length % 2) {
            return parseFloat(values[half]["unitPrice"]);
	} else {
	    return (parseFloat(values[half-1]["unitPrice"]) +
		    parseFloat(values[half]["unitPrice"])) / 2.0;
	}
    } else {
	return 0.0;
    }
}


