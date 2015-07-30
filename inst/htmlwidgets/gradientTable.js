HTMLWidgets.widget({

  name: 'gradientTable',

  type: 'output',

  initialize: function(el, width, height) {

    return {
      // TODO: add instance fields as required
    }

  },

  renderValue: function(el, x, instance) {
    function tabulate(data, columns) {
            var table = d3.select("#tabledata"),
                thead = table.append("thead"),
                tbody = table.append("tbody");

            // append the header row
            thead.append("tr")
                .selectAll("th")
                .data(columns)
                .enter()
                .append("th")
                    .text(function(column) { return column; });

            // create a row for each object in the data
            var rows = tbody.selectAll("tr")
                .data(data)
                .enter()
                .append("tr");

            // create a cell in each row for each column
            var cells = rows.selectAll("td")
                .data(function(row) {
                    return columns.map(function(column) {
                        return {column: column, value: row[column],color : row[column+".Color"]};
                    });
                })
                .enter()
                .append("td")
                    .text(function(d) { return d.value; })
                    .style("background-color",function(d) { return d.color||"lightgrey"; });

            return table;
        }

    d3.select('#intable').html( '<table cellpadding="2px" cellspacing="0" border="0" class="display" id="tabledata"></table>' );

    var intable = tabulate(x.indata,x.cols);

  },

  resize: function(el, width, height, instance) {

  }

});
