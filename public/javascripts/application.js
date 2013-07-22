// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

var smap = {}; // Smith Micro Analytics Portal
(function() {

    /******************
     * private
     ******************/

    // perform an ajax request to load the series field for Highcharts for each report
    var requestData = function(chart) {
        var request_url;
        if (chart.dashboardId) {
            request_url = '/dashboards/' + chart.dashboardId + '/reports/' +
                    chart.reportId + '/data.json';
        } else {
            request_url = '/reports/' +
                    chart.reportId + '/data.json';
        }
        $.getJSON(request_url, null, function(series) {
            length = series.length;
            for (var i = 0; i < length; i++) {
                if (i == (length - 1))
                    chart.addSeries(series[i], true, true);
                else
                    chart.addSeries(series[i], false, false);
            }
            chart.hideLoading();
        });
    };

    // create the DataTable elements from the jQuery DataTable plugin
    var initDataTable = function(dashboardId, reportId, isKpi) {
        var selectorPrefix;
        var aoColumnDefs;
        if (isKpi) {
            selectorPrefix = '#kpi_report_';
            aoColumnDefs = [
                { "bVisible": false,  "aTargets": [ 'data' ] }
            ];
        } else {
            selectorPrefix = '#table_report_';
            aoColumnDefs = {};
        }

        var request_url;
        if (dashboardId) {
            request_url = '/dashboards/' + dashboardId + '/reports/' +
                    reportId + '/data.json';
        } else {
            request_url = '/reports/' +
                    reportId + '/data.json';
        }

        var tableObj = $(selectorPrefix + reportId).dataTable({
            "bAutoWidth": false,
            "bFilter": false,
            "bPaginate": false,
            "bInfo": false,
            "bProcessing": true,
            "sAjaxSource": request_url,
            "oLanguage": {
                "sProcessing": "Loading...."
            },
            "aoColumnDefs": aoColumnDefs,
            "fnServerData": function (sSource, aoData, fnCallback) {
                $.getJSON(sSource, aoData, function (json) {
                    /* sends json to DataTables */
                    fnCallback(json);

                    // TODO don't hard code this
                    var target_array_pos = 2;
                    var data_array_pos = 5;

                    $.each(json.aaData, function() {
                        var defaultParams = {
                            chart: {
                                renderTo: this[data_array_pos].trend_elem_id,
                                defaultSeriesType: 'line',
                                margin: [0, 0, 0, 0],
                                spacingTop: 0,
                                spacingRight: 0,
                                spacingBottom: 0,
                                spacingLeft: 0,
                                borderRadius: 0
                            },
                            credits: {
                                enabled: false
                            },
                            title: {
                                text: null
                            },
                            subtitle: {
                                y: 0
                            },
                            legend: {
                                enabled: false,
                                x: 0,
                                margin: 0,
                                symbolPadding: 0,
                                symbolWidth: 0
                            },
                            xAxis: {
                                type: 'datetime',
                                labels: {
                                    enabled: false
                                },
                                title: {
                                    text: null
                                },
                                gridLineWidth: 0,
                                tickWidth: 0,
                                lineWidth: 0,
                                tickPosition: 'inside',
//                                minPadding: 0,
//                                maxPadding: 0,
                                startOnTick: false,
                                endOnTick: false
                            },
                            yAxis: {
                                labels: {
                                    enabled: true
                                },
                                title: {
                                    text: null
                                },
                                gridLineWidth: 0,
                                tickWidth: 0,
                                lineWidth: 0,
                                tickPosition: 'inside',
//                                minPadding: 0,
//                                maxPadding: 0,
                                startOnTick: false,
                                endOnTick: false,
                                plotLines: [
                                    {
                                        color: '#6B80F7',
                                        width: 1,
                                        value: this[target_array_pos]
                                    }
                                ]
                            },
                            plotOptions: {
                                line: {
                                    color: 'black',
                                    marker: {
                                        enabled: false,
                                        states: {
                                            hover: {
                                                enabled: false
                                            }
                                        }
                                    }
                                },
                                series: {
                                     borderWidth:0,
                                     shadow:false,
                                     pointPadding:0,
                                     groupPadding:0
                                }
                            },
                            series: [
                                {
                                    data: this[data_array_pos].series_data
                                }
                            ]
                        };
                        new Highcharts.Chart(defaultParams);
                    });
                });
            }
        });
    };

    /******************
     * public
     ******************/

    this.initChartReport = function(dashboardId, reportId, params, tooltipFormatter) {
        var defaultParams = {
            chart: {
                "events": {
                    "load": function () {
                        this.showLoading();
                        this.reportId = reportId;
                        this.dashboardId = dashboardId;
                        requestData(this);
                    }
                }
            }
        };
        // merge defaultParams with params passed into initTableReport
        var highchartsParams = $.extend(true, {}, params, defaultParams);

        if (tooltipFormatter) {
            highchartsParams = $.extend(true, highchartsParams,
                    {
                        tooltip: {
                            formatter: tooltipFormatter
                        }
                    }
            );
        }

        new Highcharts.Chart(highchartsParams);
    };

    this.initTableReport = function(dashboardId, reportId) {
        initDataTable(dashboardId, reportId, false);
    };

    this.initKpiReport = function(dashboardId, reportId) {
        initDataTable(dashboardId, reportId, true);
    };

    this.initDatePickers = function() {
        $('.date-fields input[type="radio"]').change(function() {
            if ($('input[@name="option_layout"]:checked').val() == 0) {
                $('.date-input input').each(function(i, el) {
                    $(el).removeAttr('disabled');
                });
            } else {
                $('.date-input input').each(function(i, el) {
                    $(el).attr('disabled', 'disabled');
                });
            }
        });

        $('.date-input input').each(function(i, el) {
            $(el).datepicker();
        });
    };

    this.initCheckBoxFilters = function() {
        $('.parent-check-box').change(function() {
            console.log('foo');
            var childCheckBoxes = $(this).closest('div.multi-check-boxes').find('.sub-check-boxes input[type="checkbox"]');
            if ($(this).is(':checked')) {
                childCheckBoxes.each(function(i, el) {
                    $(el).removeAttr('disabled');
                });
            } else {
                childCheckBoxes.each(function(i, el) {
                    $(el).attr('disabled', 'disabled');
                });
            }
        });
    };

    this.initTree = function() {
        $("#tree").treeview({
            persist: "cookie"
        });
    };

    this.initPrintButton = function() {
        window.print();
    };

}).apply(smap);