function ezObjectExplainer(obj, bool_includeFuncs, _cnt) {
	var _db = '';
	var m = -1;
	var i = -1;
	var a = [];
	var cnt = ((_cnt == null) ? '1' : _cnt.toString() + '.0');
	bool_includeFuncs = ((bool_includeFuncs == true) ? bool_includeFuncs : false);

	function isCntComplex(c) {
		return (c.toString().indexOf('.') > -1);
	}

	_db = '';
	if ( (obj.toString != null) && ((typeof obj.toString) == const_function_symbol) && (obj.toString.toString().toLowerCase().indexOf('[native code]') == -1) ) {
		_db += obj.toString();
	} else {
		if ( (obj != null) && ((typeof obj) == const_object_symbol) ) {
			if (obj.length != null) {
			    for (i = 0; i < obj.length; i++) {
					if ( ( (bool_includeFuncs) && ((typeof obj[i]) == const_function_symbol) ) || ( (!bool_includeFuncs) && ((typeof obj[i]) != const_function_symbol) ) ) {
						a.push('[' + obj[i] + ']');
					}
			    }
			} else {
				for (m in obj) {
					if ((typeof obj[m]) == const_object_symbol) {
						a.push(m + ' = [' + ezObjectExplainer(obj[m], bool_includeFuncs, cnt) + ']');
					} else if ( ( (bool_includeFuncs) && ((typeof obj[m]) == const_function_symbol) ) || ( (!bool_includeFuncs) && ((typeof obj[m]) != const_function_symbol) ) ) {
						a.push(m + ' = [' + obj[m] + ']');
					}
				}
			}
			_db += a.join(((isCntComplex(cnt)) ? ',' : '\n'));
		} else if ( ( (bool_includeFuncs) && ((typeof obj) == const_function_symbol) ) || ( (!bool_includeFuncs) && ((typeof obj) != const_function_symbol) ) ) {
			_db += obj + '\n';
		}
	}
	return _db;
}

var ObjectKeys = function(o,func) {
    var accumulator = [];
    var is_func = (typeof func) == const_function_symbol;
    for (var propertyName in o) {
        accumulator.push((is_func) ? func(propertyName) : propertyName);
    }
    return accumulator;
}

var ObjectValues = function(o,func) {
    var accumulator = [];
    var is_func = (typeof func) == const_function_symbol;
    for (var propertyName in o) {
        accumulator.push((is_func) ? func(o[propertyName]) : o[propertyName]);
    }
    return accumulator;
}

function sign(num) {
    return ((num >= 0) ? '+' : '-');
}

function _int(num) {
    return parseInt(num.toString(),10);
}

function sprintf () {
    var regex = /%%|%(\d+\$)?([-+\'#0 ]*)(\*\d+\$|\*|\d+)?(\.(\*\d+\$|\*|\d+))?([scboxXuidfegEG])/g;
    var a = arguments,
        i = 0,
        format = a[i++];

    var pad = function (str, len, chr, leftJustify) {
        if (!chr) {
            chr = ' ';
        }
        var padding = (str.length >= len) ? '' : Array(1 + len - str.length >>> 0).join(chr);
        return leftJustify ? str + padding : padding + str;
    };

    var justify = function (value, prefix, leftJustify, minWidth, zeroPad, customPadChar) {
        var diff = minWidth - value.length;
        if (diff > 0) {
            if (leftJustify || !zeroPad) {
                value = pad(value, minWidth, customPadChar, leftJustify);
            } else {
                value = value.slice(0, prefix.length) + pad('', diff, '0', true) + value.slice(prefix.length);
            }
        }
        return value;
    };

    var formatBaseX = function (value, base, prefix, leftJustify, minWidth, precision, zeroPad) {
        var number = value >>> 0;
        prefix = prefix && number && {
            '2': '0b',
            '8': '0',
            '16': '0x'
        }[base] || '';
        value = prefix + pad(number.toString(base), precision || 0, '0', false);
        return justify(value, prefix, leftJustify, minWidth, zeroPad);
    };

    var formatString = function (value, leftJustify, minWidth, precision, zeroPad, customPadChar) {
        if (precision != null) {
            value = value.slice(0, precision);
        }
        return justify(value, '', leftJustify, minWidth, zeroPad, customPadChar);
    };

    var doFormat = function (substring, valueIndex, flags, minWidth, _, precision, type) {
        var number;
        var prefix;
        var method;
        var textTransform;
        var value;

    if (substring == '%%') {
        return '%';
    }

    var leftJustify = false,
        positivePrefix = '',
        zeroPad = false,
        prefixBaseX = false,
        customPadChar = ' ';
    var flagsl = flags.length;
    for (var j = 0; flags && j < flagsl; j++) {
        switch (flags.charAt(j)) {
        case ' ':
            positivePrefix = ' ';
            break;
        case '+':
            positivePrefix = '+';
            break;
        case '-':
            leftJustify = true;
            break;
        case "'":
            customPadChar = flags.charAt(j + 1);
            break;
        case '0':
            zeroPad = true;
            break;
        case '#':
            prefixBaseX = true;
            break;
        }
    }

    if (!minWidth) {
        minWidth = 0;
    } else if (minWidth == '*') {
        minWidth = +a[i++];
    } else if (minWidth.charAt(0) == '*') {
        minWidth = +a[minWidth.slice(1, -1)];
    } else {
        minWidth = +minWidth;
    }

    if (minWidth < 0) {
        minWidth = -minWidth;
        leftJustify = true;
    }

    if (!isFinite(minWidth)) {
        throw new Error('sprintf: (minimum-)width must be finite');
    }

    if (!precision) {
        precision = 'fFeE'.indexOf(type) > -1 ? 6 : (type == 'd') ? 0 : undefined;
    } else if (precision == '*') {
        precision = +a[i++];
    } else if (precision.charAt(0) == '*') {
        precision = +a[precision.slice(1, -1)];
    } else {
        precision = +precision;
    }

    value = valueIndex ? a[valueIndex.slice(0, -1)] : a[i++];

    switch (type) {
    case 's':
        return formatString(String(value), leftJustify, minWidth, precision, zeroPad, customPadChar);
    case 'c':
        return formatString(String.fromCharCode(+value), leftJustify, minWidth, precision, zeroPad);
    case 'b':
        return formatBaseX(value, 2, prefixBaseX, leftJustify, minWidth, precision, zeroPad);
    case 'o':
        return formatBaseX(value, 8, prefixBaseX, leftJustify, minWidth, precision, zeroPad);
    case 'x':
        return formatBaseX(value, 16, prefixBaseX, leftJustify, minWidth, precision, zeroPad);
    case 'X':
        return formatBaseX(value, 16, prefixBaseX, leftJustify, minWidth, precision, zeroPad).toUpperCase();
    case 'u':
        return formatBaseX(value, 10, prefixBaseX, leftJustify, minWidth, precision, zeroPad);
    case 'i':
    case 'd':
        number = (+value) | 0;
        prefix = number < 0 ? '-' : positivePrefix;
        value = prefix + pad(String(Math.abs(number)), precision, '0', false);
        return justify(value, prefix, leftJustify, minWidth, zeroPad);
    case 'e':
    case 'E':
    case 'f':
    case 'F':
    case 'g':
    case 'G':
        number = +value;
        prefix = number < 0 ? '-' : positivePrefix;
        method = ['toExponential', 'toFixed', 'toPrecision']['efg'.indexOf(type.toLowerCase())];
        textTransform = ['toString', 'toUpperCase']['eEfFgG'.indexOf(type) % 2];
        value = prefix + Math.abs(number)[method](precision);
        return justify(value, prefix, leftJustify, minWidth, zeroPad)[textTransform]();
    default:
        return substring;
    }
};

    return format.replace(regex, doFormat);
}

PI_PER_180 = (Math.PI / 180);

function degreesToRadians$(deg) {
    return deg * PI_PER_180;
}

function radiansToDegrees$(rad) {
    return rad / PI_PER_180;
}

function _ezObjectExplainer(objs) {
    var t = '';
    for (o in objs) {
        t += ezObjectExplainer(objs[o]);
    }
    return t;
}

function findIndexOfItem(selector,pattern) {
    var i;
    var obj;
    for (i = 0; i < this.length; i++) {
        obj = this[i];
        if ( ((typeof obj) != const_string_symbol) && (selector) && ((typeof selector) == const_string_symbol) ) {
            if (obj[selector] == pattern) {
                return i;
            }
        } else {
            if (obj == pattern) {
                return i;
            }
        }
    }
    return -1;
}

Array.prototype.findIndexOfItem = findIndexOfItem;

/*
    GeolocationDistance.js
*/

GeolocationDistance = function(id){
    this.id = id;	// the id is the position within the global array
};

GeolocationDistance.$ = [];

GeolocationDistance.get$ = function() {
    var instance = GeolocationDistance.$[GeolocationDistance.$.length];
    if(instance == null) {
        instance = GeolocationDistance.$[GeolocationDistance.$.length] = new GeolocationDistance(GeolocationDistance.$.length);
    }
    return instance;
};

GeolocationDistance.i = function() {
    return GeolocationDistance.get$(); // this is an alias that aids the transmission of code from the server to the client...
};

GeolocationDistance.remove$ = function(id) {
    var ret_val = false;
    if ( (id > -1) && (id < GeolocationDistance.$.length) ) {
        var instance = GeolocationDistance.$[id];
        if (!!instance) {
            GeolocationDistance.$[id] = object_destructor(instance);
            ret_val = (GeolocationDistance.$[id] == null);
        }
    }
    return ret_val;
};

GeolocationDistance.remove$s = function() {
    var ret_val = true;
    for (var i = 0; i < GeolocationDistance.$.length; i++) {
        GeolocationDistance.remove$(i);
    }
    GeolocationDistance.$ = [];
    return ret_val;
};

GeolocationDistance.LAT_DELTAS = {
    0.00001 : 3.64,
    0.0001 : 36.4,
    0.001 : 364,
    0.01 : 0.69 * 5280,
    0.1 : 6.9 * 5280,
    1.0 : 68.97 * 5280,
    10.0 : 690.23 * 5280
};

GeolocationDistance.LNG_DELTAS = {
    0.00001 : 2.904,
    0.0001 : 29.04,
    0.001 : 290.4,
    0.01 : 0.55 * 5280,
    0.1 : 5.5 * 5280,
    1.0 : 55.00 * 5280,
    10.0 : 549.76 * 5280
};

GeolocationDistance.UNITS = {
    radians : 'radians',
    miles : 'miles',
    mi : 'mi',
    feet : 'feet',
    meters : 'meters',
    m : 'm',
    km : 'km',
    degrees : 'degrees',
    min : 'min'
};

GeolocationDistance.EARTH_RAD=6378137.0;

GeolocationDistance.radmiles = GeolocationDistance.EARTH_RAD*100.0/2.54/12.0/5280.0;

GeolocationDistance.feet_per_meter = 3280.8398950131 / 1000;

GeolocationDistance.pi = Math.PI;

GeolocationDistance.multipliers = {
    radians : 1,
    miles : GeolocationDistance.radmiles,
    mi : GeolocationDistance.radmiles,
    feet : GeolocationDistance.radmiles * 5280,
    meters : GeolocationDistance.EARTH_RAD,
    m : GeolocationDistance.EARTH_RAD,
    km : GeolocationDistance.EARTH_RAD / 1000,
    degrees : 360 / (2 * GeolocationDistance.pi),
    min : 60 * 360 / (2 * GeolocationDistance.pi)
};

GeolocationDistance.convert_feet_to_feet = function(feet) {
    return feet;
};

GeolocationDistance.convert_miles_to_feet = function(miles) {
    return miles * 5280;
};

GeolocationDistance.convert_km_to_feet = function(km) {
    return km * GeolocationDistance.feet_per_meter * 1000;
};

GeolocationDistance.convert_m_to_feet = function(m) {
    return m * GeolocationDistance.feet_per_meter;
};

GeolocationDistance.convertible_units = [
    {label:'feet',func:GeolocationDistance.convert_feet_to_feet},
    {label:'miles',func:GeolocationDistance.convert_miles_to_feet},
    {label:'km',func:GeolocationDistance.convert_km_to_feet},
    {label:'meters',func:GeolocationDistance.convert_m_to_feet}
];

GeolocationDistance.determine_max_factor = function(source,value) {
    var _source;
    function factor(num,val) {
        return parseFloat(val.toString()) / parseFloat(num.toString());
    }
    if (ObjectKeys(source).length == 0) {
        return -1;
    }
    var result = -1;
    var guess;
    for (var i in source) {
        guess = factor(source[i],value);
        if (parseInt(guess.toString(),10) > 0) {
            result = parseFloat(i.toString()) * guess;
            break;
        }
    }
    return result;
}

GeolocationDistance.min_or_max_delta_from = function(source,is_min) {
    is_min = ( (is_min == true) || (is_min == false) ) ? is_min : true;
    var keys = ObjectKeys(source,
        function (value) {
            return parseFloat(value.toString());
        }
    );
    function numericComparison(a,b) {
        return a - b;
    }

    keys.sort(numericComparison);
    return source[keys[(is_min) ? 0 : keys.length-1]];
};

GeolocationDistance.max_delta_from = function(source) {
    return GeolocationDistance.min_or_max_delta_from(source,false);
};

GeolocationDistance.min_delta_from = function(source) {
    return GeolocationDistance.min_or_max_delta_from(source,true);
};

GeolocationDistance.max_delta_lat = function() {
    return GeolocationDistance.max_delta_from(GeolocationDistance.LAT_DELTAS);
};

GeolocationDistance.min_delta_lat = function() {
    return GeolocationDistance.min_delta_from(GeolocationDistance.LAT_DELTAS);
};

GeolocationDistance.min_delta_lng = function() {
    return GeolocationDistance.min_delta_from(GeolocationDistance.LNG_DELTAS);
};

GeolocationDistance.max_delta_lng = function() {
    return GeolocationDistance.max_delta_from(GeolocationDistance.LNG_DELTAS);
};

GeolocationDistance.delta_from_units_lat_or_lng = function(value,units,source) {
    var result = value;
    try {
        var i = GeolocationDistance.convertible_units.findIndexOfItem('label',units);
        if (i > -1) {
            result = GeolocationDistance.convertible_units[i].func(value); // now we have value expressed as 'feet'.
            var max_factor = GeolocationDistance.determine_max_factor(source,result);
            if (max_factor == -1) {
                var key = GeolocationDistance.min_delta_from(source).toString();
                result = result * parseFloat(source[key]);
            } else {
                result = max_factor;
            }
        }
    } catch (e) {
        alert('GeolocationDistance.delta_from_units_lat_or_lng().6 :: e='+e+'\n'+ezObjectExplainer(e));
    }
    return result;
};

GeolocationDistance.delta_from_units_lat = function(value,units) {
    var is_neg = value < 0;
    var result = GeolocationDistance.delta_from_units_lat_or_lng(Math.abs(value),units,GeolocationDistance.LAT_DELTAS);
    return (is_neg) ? -result : result;
};

GeolocationDistance.delta_from_units_lng = function(value,units) {
    var is_neg = value < 0;
    var result = GeolocationDistance.delta_from_units_lat_or_lng(Math.abs(value),units,GeolocationDistance.LNG_DELTAS);
    return (is_neg) ? -result : result;
};

GeolocationDistance.distance = function(pt1, pt2, units) {
    var lat1 = pt1.lat();
    var pt1_latRadians = degreesToRadians$(lat1);
    var lat2 = pt2.lat();
    var pt2_latRadians = degreesToRadians$(lat2);
    var lng1 = pt1.lng();
    var pt1_lngRadians = degreesToRadians$(lng1);
    var lng2 = pt2.lng();
    var pt2_lngRadians = degreesToRadians$(lng2);
    var sdlat = Math.sin((pt1_latRadians - pt2_latRadians) / 2.0);
    var sdlon = Math.sin((pt1_lngRadians - pt2_lngRadians) / 2.0);
    var result = Math.sqrt(sdlat * sdlat + Math.cos(pt1_latRadians) * Math.cos(pt2_latRadians) * sdlon * sdlon);
    result = 2 * Math.asin(result);
    try {
        if (GeolocationDistance.multipliers[units]) {
            result = result * GeolocationDistance.multipliers[units];
        }
    } catch (e) {}
    return result;
};

GeolocationDistance.hemispherical_offset_for_lat_or_lng = function(value,units,direction) {
    direction = ((direction == true) || (direction == false)) ? direction : false;
    return (direction) ? ((value > 0) ? -units : units) : ((value > 0) ? units : -units);
};

GeolocationDistance.unit_test = function() {
    var a = new google.maps.LatLng(37.4228327, -122.0850778);
    var delta = {x:0.00001,y:0.00001};
    var b = new google.maps.LatLng(a.lat()+delta.x, a.lng()+delta.y);
    var dst = this.distance(a,b,GeolocationDistance.UNITS.miles);
};

GeolocationDistance.prototype = {
    id : -1,
    toString : function() {
        function toStr() {
            var s = '[';
            s += ']';
            return s;
        }
        var s = 'id = [' + this.id + ']\n' + toStr();
        return s;
    },
    init : function(data) {
        return this;
    },
    destructor : function() {
        return (this.id = GeolocationDistance.$[this.id] = null);
    },
    dummy : function() {
        return false;
    }
};
// ===========================

/*
    SmithMicroHeatMapDataModel.js
*/

SmithMicroHeatMapDataModel = function(id){
    this.id = id;	// the id is the position within the global array
    this.data = [];
    this.target = null;
    this.total_count = 0;
    this.is_heat_gps = false;
    this.min_lat = 0;
    this.max_lat = 0;
    this.min_lng = 0;
    this.max_lng = 0;
    this.map_bounds = null;
    this.map_center = null;
    this.map_SE = null;
    this.map_SW = null;
    this.map_NE = null;
    this.map_NW = null;
    this._i_ =  -1;
    this.status = '';
    this.results = null;
};

SmithMicroHeatMapDataModel.$ = [];

SmithMicroHeatMapDataModel.get$ = function() {
    var instance = SmithMicroHeatMapDataModel.$[SmithMicroHeatMapDataModel.$.length];
    if(instance == null) {
        instance = SmithMicroHeatMapDataModel.$[SmithMicroHeatMapDataModel.$.length] = new SmithMicroHeatMapDataModel(SmithMicroHeatMapDataModel.$.length);
    }
    return instance;
};

SmithMicroHeatMapDataModel.i = function() {
    return SmithMicroHeatMapDataModel.get$(); // this is an alias that aids the transmission of code from the server to the client...
};

SmithMicroHeatMapDataModel.remove$ = function(id) {
    var ret_val = false;
    if ( (id > -1) && (id < SmithMicroHeatMapDataModel.$.length) ) {
        var instance = SmithMicroHeatMapDataModel.$[id];
        if (!!instance) {
            SmithMicroHeatMapDataModel.$[id] = object_destructor(instance);
            ret_val = (SmithMicroHeatMapDataModel.$[id] == null);
        }
    }
    return ret_val;
};

SmithMicroHeatMapDataModel.remove$s = function() {
    var ret_val = true;
    for (var i = 0; i < SmithMicroHeatMapDataModel.$.length; i++) {
        SmithMicroHeatMapDataModel.remove$(i);
    }
    SmithMicroHeatMapDataModel.$ = [];
    return ret_val;
};

var MIN_ALPHA = 0.1;
var MAX_ALPHA = 0.65;
var DELTA_ALPHA = MAX_ALPHA - MIN_ALPHA;

var OK_SYMBOL = 'OK';

var HEAT_LAT_SYMBOL = 'heat_lat';
var HEAT_LNG_SYMBOL = 'heat_lng';
var HEAT_X_SYMBOL = 'heat_x';
var HEAT_Y_SYMBOL = 'heat_y';
var HEAT_NUM_SYMBOL = 'heat_num';
var HEAT_GPS_SYMBOL = 'heat_gps';

var REQUIRED_COLUMNS = [
    HEAT_LAT_SYMBOL,
    HEAT_LNG_SYMBOL,
    HEAT_X_SYMBOL,
    HEAT_Y_SYMBOL,
    HEAT_NUM_SYMBOL,
    HEAT_GPS_SYMBOL
];

var PERCENT_SYMBOL = '%';
var GPS_SYMBOL = '@';
var ALPHA_SYMBOL = '&';

SmithMicroHeatMapDataModel.prototype = {
    id : -1,
    data: [],
    target:null,
    total_count:0,
    is_heat_gps:false,
    min_lat:0,
    max_lat:0,
    min_lng:0,
    max_lng:0,
    map_bounds:null, // LatLng
    map_center:null, // LatLng
    map_SE:null,    // LatLng
    map_SW:null,    // LatLng
    map_NE:null,    // LatLng
    map_NW:null,    // LatLng
    _i_: -1,
    status:'',
    results:null,    // DO NOT ASSIGN ANY VARIABLES HERE...
    toString : function(delim) {
        function toStr(_this) {
            var s = '[';
	    delim = ((delim == null) ? '' : delim);
            s += 'target='+_this.target;
            s += ','+delim+'total_count='+_this.total_count;
            s += ','+delim+'min_lat='+_this.min_lat;
            s += ','+delim+'max_lat='+_this.max_lat;
            s += ','+delim+'min_lng='+_this.min_lng;
            s += ','+delim+'max_lng='+_this.max_lng;
            s += ','+delim+'map_bounds='+_this.map_bounds;
            s += ','+delim+'map_center='+_this.map_center;
            s += ','+delim+'_i_='+_this._i_;
            s += ','+delim+'length='+_this.length();
	    if ( (_this.data) && (_this.data.length) ) {
		s += ''+delim+'BEGIN:';
		for (var i in _this.data) {
		    s += delim+'#'+i+'='+ezObjectExplainer(_this.data[i]);
		}
		s += ''+delim+'END!';
	    }
            s += ']';
            return s;
        }
        var s = 'id = [' + this.id + ']\n' + toStr(this);
        return s;
    },
    init : function(data) {
        var i;
        var j;
        var aBucket;
        var datum;
        var _gps = null;
        if ( (data.columns) && (data.results) ) {
            this.determine_target(data.columns);
            this.total_count = 0;
            for (i = 0; i < data.results.length; i++) {
                aBucket = {};
                datum = data.results[i];
                for (j = 0; j < data.columns.length; j++) {
                    aBucket[data.columns[j]] = (data.columns[j] != HEAT_GPS_SYMBOL) ? parseInt(datum[j].toString(),10) : datum[j];
                }
                if (this.is_target_valid) {
                    try {
                        aBucket[this.target] = parseFloat(aBucket[this.target]);
                        this.total_count += aBucket[this.target];
                        _gps = null;
                        if (this.is_heat_gps) {
                            try {
                            _gps = aBucket[HEAT_GPS_SYMBOL];
                            } catch (e) {}
                        }
                        if (_gps) {
                            aBucket[GPS_SYMBOL] = new google.maps.LatLng(_gps.lat,_gps.lng);
                        } else {
                            aBucket[GPS_SYMBOL] = new google.maps.LatLng(aBucket[HEAT_LAT_SYMBOL]+(aBucket[HEAT_Y_SYMBOL]/aBucket[HEAT_NUM_SYMBOL]),aBucket[HEAT_LNG_SYMBOL]+(aBucket[HEAT_X_SYMBOL]/aBucket[HEAT_NUM_SYMBOL]));
                        }
                    } catch (e) {}
                }
                this.data.push(aBucket);
            }
            this.determine_percents();
            this.determine_map_center();
            this.status = OK_SYMBOL;
        } else {
            alert('WARNING:\n\nCannot process your data request at this time due to a data formatting issue.');
        }
        return this;
    },
    is_target_valid : function() {
        return ( ((typeof this.target) == const_string_symbol) && (this.target.length > 0) );
    },
    determine_target: function(cols) {
        var j;
        if ((typeof this.target) == const_string_symbol) {
            return;
        }
        for (j = 0; j < REQUIRED_COLUMNS.length; j++) {
            REQUIRED_COLUMNS[j] = String(REQUIRED_COLUMNS[j]).toLowerCase();
        }
        for (j = 0; j < cols.length; j++) {
            if (REQUIRED_COLUMNS.indexOf(String(cols[j]).toLowerCase()) == -1) {
                this.target = cols[j];
                break;
            }
        }
    },
    determine_percents: function() {
		function _determine_heat_from_percent(pcent,_min,_max) {
		    var alpha = 0;
		    var delta = _max - _min;
		    alpha = (((pcent-_min)/delta) * MAX_ALPHA);
		    if (alpha < MIN_ALPHA) {
			alpha += MIN_ALPHA;
		    }
		    return alpha;
		}
        var i;
        var aBucket;
		var min_pcent = 100;
		var max_pcent = -1;
        for (i = 0; i < this.data.length; i++) {
            aBucket = this.data[i];
            aBucket[PERCENT_SYMBOL] = aBucket[this.target] / this.total_count;
	    min_pcent = Math.min(aBucket[PERCENT_SYMBOL],min_pcent);
	    max_pcent = Math.max(aBucket[PERCENT_SYMBOL],max_pcent);
        }
        for (i = 0; i < this.data.length; i++) {
            aBucket = this.data[i];
            aBucket[ALPHA_SYMBOL] = _determine_heat_from_percent(aBucket[PERCENT_SYMBOL],min_pcent,max_pcent);
        }
    },
    determine_map_center: function() {
        this.min_lat = 99;
        this.max_lat = -99;
        this.min_lng = 180;
        this.max_lng = -180;
        var i;
        var aBucket;
        var aLatLng;
        for (i = 0; i < this.data.length; i++) {
            aBucket = this.data[i];
            aLatLng = aBucket[GPS_SYMBOL];
            if (aLatLng) {
                this.min_lat = Math.min(this.min_lat,aLatLng.lat());
                this.min_lng = Math.min(this.min_lng,aLatLng.lng());

                this.max_lat = Math.max(this.max_lat,aLatLng.lat());
                this.max_lng = Math.max(this.max_lng,aLatLng.lng());
            }
        }
        this.map_bounds = new google.maps.LatLngBounds(new google.maps.LatLng(this.min_lat,this.min_lng),new google.maps.LatLng(this.max_lat,this.max_lng));
        var units = GeolocationDistance.convertible_units[0].label;
        var northWest = new google.maps.LatLng(this.map_bounds.getNorthEast().lat(),this.map_bounds.getSouthWest().lng());
        var distLeft = GeolocationDistance.distance(northWest,this.map_bounds.getSouthWest(),units);
        var distTop = GeolocationDistance.distance(northWest,this.map_bounds.getNorthEast(),units);
        var offsetLat = GeolocationDistance.hemispherical_offset_for_lat_or_lng(northWest.lat(),GeolocationDistance.delta_from_units_lat((distLeft/2),units),false);
        var newLat = northWest.lat()-offsetLat;
        var offsetLng = GeolocationDistance.hemispherical_offset_for_lat_or_lng(northWest.lng(),GeolocationDistance.delta_from_units_lng((distTop/2),units),false);
        var newLng = northWest.lng()-offsetLng;
        this.map_center = new google.maps.LatLng(newLat,newLng);
        this.map_SE = new google.maps.LatLng(this.min_lat, this.max_lng);
        this.map_SW = new google.maps.LatLng(this.min_lat, this.min_lng);
        this.map_NE = new google.maps.LatLng(this.max_lat, this.max_lng);
        this.map_NW = new google.maps.LatLng(this.max_lat, this.min_lng);
    },
    next_record: function() {
        var i = this._i_ + 1;
        if (i < this.data.length) {
            this._i_ = i;
            return this.data[i];
        }
        this._i_ = 0;
        return null;
    },
    i: function() {
        return (this.data) ? this._i_ : 0;
    },
    length: function() {
        return (this.data) ? this.data.length : 0;
    },
    destructor : function() {
        return (this.id = SmithMicroHeatMapDataModel.$[this.id] = null);
    },
    dummy : function() {
        return false;
    }
};

function _add_polygon_overlay(latLng,alpha,g) {
    var delta_width = 1/g[HEAT_NUM_SYMBOL];
    var delta_height = 1/g[HEAT_NUM_SYMBOL];
    var verticies = [
        new google.maps.Point(0,0),
        new google.maps.Point(delta_width,0),
        new google.maps.Point(delta_width,delta_height),
        new google.maps.Point(0,delta_height)
    ];
    var aVertex1;
    var aVertex2;
    var latLng1;
    var latLng2;
    var i;
    var m = verticies.length-1;
    var coords = [];
    for (i = 0; i <= m; i++) {
        aVertex1 = verticies[i];
        aVertex2 = verticies[((i == m) ? 0 : i+1)];
        latLng1 = (coords.length == 0) ? new google.maps.LatLng(latLng.lat()+aVertex1.y, latLng.lng()+aVertex1.x) : coords[coords.length-1];
        latLng2 = new google.maps.LatLng(latLng.lat()+aVertex2.y, latLng.lng()+aVertex2.x);
        if (coords.length == 0) {
            coords.push(latLng1);
            coords.push(latLng2);
        } else {
            coords.push(latLng2);
        }
    }
    var aPolygon = new google.maps.Polygon({
      paths: coords,
      strokeColor: "#000000",
      strokeOpacity: 0.25,
      strokeWeight: 1,
      fillColor: "#FF0000",
      fillOpacity: alpha
    });
    aPolygon.setMap(__map__);

    if (!__infowindow__) {
        __infowindow__ = new google.maps.InfoWindow()
    }

    google.maps.event.addListener(aPolygon, 'click',
	function (event) {
	    var vertices = this.getPath();

	    var contentString = "<b>Polygon</b><br/>";
	    contentString += "Clicked Location: <small>" + event.latLng.lat() + "," + event.latLng.lng() + "</small><br/>";

	    contentString += "<small>";
	    for (var i =0; i < vertices.length; i++) {
	      var xy = vertices.getAt(i);
	      contentString += "<br/>" + "Coordinate: " + i + "&nbsp;" + xy.lat() +"," + xy.lng();
	    }
	    contentString += "<p/>" + ezObjectExplainer(g) + "</p>";
	    contentString += "</small>";

	    if (!__infowindow__) {
            __infowindow__ = new google.maps.InfoWindow()
	    }

	    __infowindow__.close();
	    __infowindow__.setContent(contentString);
	    __infowindow__.setPosition(event.latLng);

	    __infowindow__.open(__map__);
	}
    );
}

if (__callback_heat_map_utils__) {
    try {
        __callback_heat_map_utils__();
    } catch (e) {}
}
